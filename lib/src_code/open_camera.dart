


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snbiz/src_code/multipleImage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:snbiz/src_code/imagePreview.dart';
import 'package:flutter/services.dart';
import 'file_picker.dart';



class CameraApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CameraAppState();
  }
}
class CameraAppState extends State<CameraApp> {
  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension="";
  bool _loadingPath = true;
  bool _multiPick = true;
  bool _hasValidMime = true;
  FileType _pickingType=FileType.ANY;


  File imageFile;
 String img;


  void _openFileExplorer() async {
    if (_pickingType != FileType.CUSTOM || _hasValidMime) {
      setState(() => _loadingPath = true);
      try {
        if (_multiPick) {
          _path = null;
          _paths = await FilePicker.getMultiFilePath(
              type: _pickingType, fileExtension: _extension);
              image1();
        } else {
          _paths = null;
          var filePath = FilePicker.getFilePath(
              type: _pickingType, fileExtension: _extension);
          _path = await filePath;
          image1();
        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;
      setState(() {
        _loadingPath = false;
        _fileName = _path != null
            ? _path.split('/').last
            : _paths != null ? _paths.keys.toString() : '...';
            image1();
      });
    }
  }

 
 

  void openCamera() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    imageFile = picture;
    call();
    img = imageFile.path;
     call();
    
  }

  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
      _controller.addListener(() => _extension = _controller.text);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 350,
              width: 200,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(height: 150.0),
                      Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(5.0)),
                          color: const Color(0xFF1500ff),
                        ),
                      ),
                      Positioned(
                        top: 50.0,
                        left: 94.0,
                        child: Container(
                          height: 90.0,
                          width: 90.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45.0),
                              border: Border.all(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 10.0),
                              image: DecorationImage(
                                  image: new AssetImage("assets/logo.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Make your choice!",
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FloatingActionButton(
                            child: Icon(Icons.sd_storage),
                            onPressed: () => _openFileExplorer(),
                          ),
                          FloatingActionButton(
                            child: Icon(Icons.camera_alt),
                            onPressed: () {
                              openCamera();
                              Navigator.of(context).pop();

                              // To close the dialog
                            },
                          ),

                        ],
                        ),
                  )
                ],
              ),
            ),
          );
              
          
        
        },
      );
    });
  }

void image1(){
  if(_paths.isNotEmpty){
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => MultipleImage(url:_paths )));
  }
}
  void call() {
    if (img.isNotEmpty) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PreviewImage(url: img)));
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
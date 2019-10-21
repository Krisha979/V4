import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
//import 'package:snbiz/Model_code/documents.dart';
import 'package:snbiz/src_code/createmeeting.dart';
import 'package:snbiz/src_code/invoice.dart';
import 'package:snbiz/src_code/static.dart';
//import 'package:snbiz/src_code/open_camera.dart';
import 'package:snbiz/src_code/task.dart';
import 'package:snbiz/src_code/documents.dart';

import 'package:snbiz/src_code/multipleImage.dart';


import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:snbiz/src_code/imagePreview.dart';
import 'package:flutter/services.dart';
import 'file_picker.dart';


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {

  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension="";
  bool _loadingPath = true;
  bool _multiPick = true;
  bool _hasValidMime = true;
  FileType _pickingType=FileType.ANY;
  AnimationController controller;
  Animation<double> animation;
  bool showIndicator = false;

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

              image1();        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;
      setState(() {
        _loadingPath = false;
        _fileName = _path != null
            ? _path.split('/').last
            : _paths != null ? _paths.keys.toString() : '...';

           //   image1();
                    });
    }
  }

 
 File imageFile;

 String img;

  openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    imageFile = picture;
    img = imageFile.path;
    StaticValue.imgfile = imageFile;
    call();
  }

  TextEditingController _controller = new TextEditingController();

   addpopup() {
     showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
           Size size = MediaQuery.of(context).size;

          return Dialog(
           // shape: RoundedRectangleBorder(
             //   borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: size.height/3.4,
             width: size.width/1.2,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xFFFBF4F4)),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                     // Container(height: 150.0),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        height: size.height/13,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(5.0)),
                          color: const Color(0xFFFBF4F4),
                        ),
                        child: Center(
                          child: Text("UPLOAD OPTIONS", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)),
                      ),
                      
                    ],
                  ),
                
                 
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[

                       

                          
                       
                          
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                                          child: Image(
                                   image: new AssetImage("assets/file.png"),
                        height: size.height /8,
                        width: size.width/5),
                        
                        onTap: (){
                               _openFileExplorer();
                               Navigator.pop(context);
                               

                        },
                              ),
                              Text("Files"),
                            ],
                          ),

                           Column(
                             children: <Widget>[
                               GestureDetector(
                                                          child: Image(
                                   image: new AssetImage("assets/camera.png"),
                                    height: size.height /8,
                        width: size.width/5
                                   ),
                                   onTap: (){
                                      openCamera(context);
                                        Navigator.pop(context);
                                   },
                                 


                          ),
                          Text("Camera")
                             ],
                           ),
                          

                         

                         /* FloatingActionButton(
                            //child: Icon(Icons.sd_storage),
                            onPressed: () => _openFileExplorer(),
                          ),
                          FloatingActionButton(
                            child: Icon(Icons.camera_alt),
                            onPressed: () {
                              openCamera(context);
                              Navigator.of(context).pop();

                              // To close the dialog
                            },
                          ),*/

                        ],
                        ),
                  
                ],
              ),
            ),
          );
              
          
        
        },
      );
    }

    void image1(){
  if(_paths.isNotEmpty){
     findnames();
    
  }
}
  void findnames(){
      String names = _paths.toString();
      StaticValue.filenames= names.split(',');
                      Navigator.push(context,
    MaterialPageRoute(builder: (context) => MultipleImage(url:_paths )));
  }
  void call() {
    if (img.isNotEmpty) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PreviewImage(url:img)));
    }
  }

  


  @override
  void initState() {
    super.initState();
     _controller.addListener(() => _extension = _controller.text);
    controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    animation = Tween(begin: 5.0, end: 18.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }





  final carousel2 = Carousel(
    boxFit: BoxFit.cover,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 2000),
    dotSize: 2.0,
    dotIncreasedColor: Color(0xFFFFFFFF),
    dotBgColor: Colors.black.withOpacity(0),
    autoplayDuration: Duration(seconds: 5),
    images: [
      AssetImage(
        'assets/image1.png',
      ),
      AssetImage('assets/image2.png'),
      AssetImage('assets/image3.png'),
      AssetImage('assets/image4.png'),
    ],
    // dotBgColor: Colors.white.withOpacity(1),
  );


  
    
  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //  double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFd6d6d6),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white),
                child: Column(
                  children: <Widget>[
                    new Image(
                        image: new AssetImage("assets/logo.jpg"),
                        height: size.height / 4.8,
                        width: size.width),
                  ],
                ),
              ),
              Container(
                //color: Colors.black,

                child: Wrap(children: <Widget>[
                  Container(
                    height: size.height / 2.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    // color: Colors.white,
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                    //color: Colors.black,
                    // width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                InkWell(
                                  splashColor: Colors.red,
                                  onTap: () {
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage()));
                                  },
                                  child: Image(
                                    image: new AssetImage("assets/icon1.png"),
                                    height: size.height / 13,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Text("Tasks"),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                InkWell(
                                  splashColor: Colors.red,
                                  onTap: () {
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => Invoice()));
                                  },
                                  child: Image(
                                    image: new AssetImage("assets/invoice.png"),
                                    height: size.height / 13,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Text("Invoice"),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                InkWell(
                                  splashColor: Colors.red,
                                  onTap: () {
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => Documents()));
                                  },
                                  child: Image(
                                    image:
                                        new AssetImage("assets/Document.png"),
                                    height: size.height / 13,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Text("Documents"),
                                )
                              ],
                            ),
                          ],
                        ),

                        //  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        Divider(
                          color: Colors.grey,
                          height: 50.0,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                InkWell(
                                  splashColor: Colors.red,
                                  onTap: () {
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => Create()));
                                  },
                                  child: Image(
                                    image: new AssetImage("assets/icon5.png"),
                                    height: size.height / 13,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Text("Set Meetings"),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                InkWell(
                                  splashColor: Colors.red,
                                  onTap: () {
                                     addpopup();
                                  },
                                  child: Image(
                                    image: new AssetImage("assets/icon3.png"),
                                    height: size.height / 13,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Text("Upload"),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              GestureDetector(
                onTap: () {}, // code hack do nothing
                child: Wrap(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      height: size.height / 4.8,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: carousel2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    
  }
  
}
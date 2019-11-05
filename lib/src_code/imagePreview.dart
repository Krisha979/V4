import 'dart:io';
import 'dart:convert';
// import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
//import 'package:snbiz/src_code/profile.dart' as prefix0;
import 'package:snbiz/src_code/static.dart';
//import 'package:snbiz/Model_code/File_type.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class PreviewImage extends StatefulWidget {
  //final String imageFile;

  final String url;
  const PreviewImage({Key key, this.url}) : super(key: key);
  @override
  State createState() => PreviewImageState(url);
}

class PreviewImageState extends State<PreviewImage> {
  File imageFile;
  String url;
  PreviewImageState(this.url);

  Future<void> upload(File files) async {
    List<File> docs = new List();
    // if (files.isNotEmpty) {
    //   files.forEach((k, v) => docs.add(new File(v)));
    // }
    docs.add(files);
    // string to uri
    var uri = Uri.parse(StaticValue.baseUrl +
        "api/UploadDocuments?Orgid=" +
        StaticValue.orgId.toString() +
        "&OrgName=" +
        StaticValue.orgName);
    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    for (File file in docs) {
      // open a bytestream
      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));

      // get file length
      var length = await file.length();
      // multipart that takes file
      var multipartFile = new http.MultipartFile('Files', stream, length,
          filename: basename(file.path));

      // add file to multipart
      request.files.add(multipartFile);
    }
    // send
    var response = await request.send();
    print(response.statusCode);
    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  //using dio package
  // Future<void> uploadFiles(File file) async{

  //       BaseOptions options = new BaseOptions(
  //             baseUrl: "https://s-nbiz.conveyor.cloud/api",
  //             connectTimeout: 10000,
  //             receiveTimeout: 30000,
  //             method:'POST',
  //             headers: {
  //                   'Content-type': 'application/json',
  //                   'Accept': 'application/json',
  //             }
  //       );
  //       FormData formdata = new FormData();
  //       formdata.add("files", new UploadFileInfo(file, basename(file.path)));
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: (AppBar(title: Text('Image', style: TextStyle(
          color: Colors.white, fontStyle: FontStyle.normal,
           fontWeight: FontWeight.normal, fontSize: 19),
           ),
            backgroundColor: Color(0xFF9C38FF),
           )
           ),
        body: Container(
          height: size.height,
          width: size.width,
          color: Color(0xFFE0CECE),
            child: Column(children: <Widget>[
          Expanded(
                      child: new Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFFFFFFFF),
                ),
                
                margin: EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                     
                        
                         Center(
                          child: Text("INSTANT IMAGE UPLOAD", style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal,color:  Color(0xFF665959)),),
                        ),
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 10,),
                        child: Image.file(File(url),
                            width: size.width,
                            height: size.height/1.5
                            ),
                      ),
                
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: MaterialButton(
                            height: 50,
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  });
                              if (StaticValue.imgfile.path == url) {
                                await upload(StaticValue.imgfile);
                              }

                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            textColor: Colors.white,
                            color: Color(0xFFB56AFF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Center(
                              child:
                                  Text('Upload', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            )),
                      ),
                    ])),
          )
        ])));
  }
}

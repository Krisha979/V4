import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:snbiz/src_code/static.dart';
//import 'package:snbiz/Model_code/File_type.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class PreviewImage extends StatefulWidget {
   //final String imageFile;
  
  final String url;
const PreviewImage({Key key, this.url}) : super(key: key);
  @override
  State createState() => PreviewImageState( url);
}

class PreviewImageState extends State<PreviewImage> {

   File imageFile;
  String url;
  PreviewImageState( this.url);
  //List<FileType> _fileType = FileType.getFileType();
  //List <DropdownMenuItem<FileType>> _dropdownMenuItems;
  //FileType _file;
  
 Future<void>upload(files) async {    
     
      List<File> docs = new List();
     files.forEach((k,v) => docs.add(new File(v)));
     
      // string to uri
      var uri = Uri.parse(StaticValue.baseUrl + "api/UploadDocuments?Orgid="+StaticValue.orgId.toString() + "&OrgName="+ StaticValue.orgName);
      // create multipart request
      var request = new http.MultipartRequest("POST", uri
      ); 
      for(File file in docs){
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
  Future<void> uploadFiles(File file) async{
     
        BaseOptions options = new BaseOptions(
              baseUrl: "https://s-nbiz.conveyor.cloud/api",
              connectTimeout: 10000,
              receiveTimeout: 30000,
              method:'POST',
              headers: {
                    'Content-type': 'application/json',
                    'Accept': 'application/json',
              }
        );
        FormData formdata = new FormData();
        formdata.add("files", new UploadFileInfo(file, basename(file.path)));
  }
 
  
    @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: (AppBar(title: Text('Image'))),
      body: SingleChildScrollView(
      child: Column(
      children: <Widget>[
        new Container (
         // height: size.height,
          width: size.width,
          
          margin: EdgeInsets.all(8.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[    
           
            Image.file(File(url), 
            width: size.width,
            height: size.height/2),
           
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            
           FlatButton(
             onPressed: (){
             upload(url);
             Navigator.pop(context);

             },
             child: Text("Upload", style: TextStyle(color: Colors.white),),
             color: Colors.blue,
           )
          ]
          
        )
        
        )
      ]
      )
      )
      );
  }
}
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:snbiz/src_code/static.dart';


class MultipleImage extends StatefulWidget {
  
 final Map<String, String> url;

  const MultipleImage({Key key, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MultipleImageState(url);
  
}

class MultipleImageState extends State<MultipleImage>{
Map<String, String> url;
 //  String url;
  MultipleImageState( this.url);
  Future<void>upload(Map<String, String> files) async {    
     
      List<File> docs = new List();
     files.forEach((k,v) => docs.add(new File(v)));
     
      // string to uri
      var uri = Uri.parse("https://s-nbiz.conveyor.cloud/api/UploadDocuments?Orgid="+StaticValue.orgId.toString() + "&OrgName="+ StaticValue.orgName);
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
      appBar: AppBar(
        title: Text("Preview Image"),

      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: <Widget>[
            Text(url.toString(),
            ),

            FlatButton(
              onPressed: (){
               upload(url); 
                    
                
              },

              color: Colors.blue,
              child: Text("Upload",
              style: TextStyle(color: Colors.white),),
            )
          ],
        ),
        
        
        
     
       


      ),
    );
  }

}

import 'dart:convert';
import 'dart:io';

// import 'package:dio/dio.dart';
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

class MultipleImageState extends State<MultipleImage> {
  
  Map<String, String> url;
  //  String url;
  MultipleImageState(this.url);
  List<String> names;

  Future<void> upload(Map<String, String> files) async {
    List<File> docs = new List();
    if (files.isNotEmpty) {
      files.forEach((k, v) => docs.add(new File(v)));
    }

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

  // Future<void> uploadFiles(File file) async {
  //   BaseOptions options = new BaseOptions(
  //       baseUrl: "https://s-nbiz.conveyor.cloud/api",
  //       connectTimeout: 10000,
  //       receiveTimeout: 30000,
  //       method: 'POST',
  //       headers: {
  //         'Content-type': 'application/json',
  //         'Accept': 'application/json',
  //       });
  //   FormData formdata = new FormData();
  //   formdata.add("files", new UploadFileInfo(file, basename(file.path)));
  // }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview Image",),
        backgroundColor: Color(0xFF9C38FF),
      ),
      body: Container(
        color: Color(0xFFE0CECE),

        //  margin: EdgeInsets.all(10.0),

        child: Container(
          height: size.height,
          width: size.width,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Column(

            children: <Widget>[
               Padding(
                              padding: const EdgeInsets.only(right: 100, top: 20),
                              child: Text("UPLOAD IMAGES & FILES", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                            ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: StaticValue.filenames.length,
                  itemBuilder: (BuildContext ctxt, int index) {

                    

                    return ListTile(
                      

                        title: Column(
                          children: <Widget>[
                           
                           
                            Row(
                             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: new Image(
                                      image: new AssetImage("assets/pdf.png"),
                                      height: size.height / 8,
                                      width: size.width / 8),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                ),
                                Text(StaticValue.filenames[index].substring(
                                    StaticValue.filenames[index].lastIndexOf('/') +
                                        1),style: TextStyle(fontStyle: FontStyle.normal, fontSize: 14, fontWeight: FontWeight.normal), ),
                                        
                                        
                              ],
                              
                            ),

                                        //Divider(height: 0,color: Color(0xFFB162F7),
                                        //)
                                     /* SizedBox(
                                        height: 10,
                                        width: 10,
                                        
                                      )*/

                                      new Container(height: 1, width: size.width, color: Color(0xFFB162F7),
                        margin: const EdgeInsets.only(left: 2.0, right: 2.0),),
                                      
                                    
                          ],
                        ),

                      
                      
                    );
                    
                  }),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    height: size.height/16,
                    width: size.width/1.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFFB56AFF),
                      
                      boxShadow: [new BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            blurRadius: 10, 
            
          ),]
                    ),
                    child: RaisedButton(
                      onPressed: () async {
                        

                        showDialog(
                         context: context,
                         builder: (BuildContext context) {
                           return Center(child: CircularProgressIndicator(),);
                         } 
                       );
                       await upload(url);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      },
                      textColor: Colors.white,
                       color: Color(0xFFB56AFF),
                         shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                       

                     
                          child: Center(
                            child: Text('Upload', style: TextStyle(fontSize: 16)),
                          )),
                  ),
                ),
                ),
              
            ] 
          )
            
        )
        ),
      

      /* FlatButton(
                  
                  onPressed: () async{
                  
                   showDialog(
                     context: context,
                     builder: (BuildContext context) {
                       return Center(child: CircularProgressIndicator(),);
                     } 
                   );
                  await upload(url);
                  Navigator.pop(context);
                  Navigator.pop(context);

                  
                    
                        
                    
                  },

                  color: Colors.blue,
                  child: Text("Upload",
                  style: TextStyle(color: Colors.white),),
                )*/
    );
  }
}

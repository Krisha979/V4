import 'dart:convert';
import 'dart:io';
import 'package:SNBizz/src_code/static.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

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


var responsecode;
  Future<void> upload(Map<String, String> files) async {

    
    
    List<File> docs = new List();
    if (files.isNotEmpty) {
      files.forEach((k, v) => docs.add(new File(v)));
    }

    // string to uri
    var uri = Uri.parse(StaticValue.baseUrl + StaticValue.multipleimage_url + StaticValue.orgId.toString() +  "&OrgName=" + StaticValue.orgName);


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
    //print(response.statusCode);

     responsecode = response.statusCode;

     

    

     

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
  var ctx;


  Future<bool> _onBackPressed() async {
    Navigator.pop(ctx);
    Navigator.pop(ctx);
    // Your back press code here...
    //CommonUtils.showToast(context, "Back presses");
  }

Future<bool> checkConnectivity()  async{
                        var result =  await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.none){
                         return false;
                        }
                        return true;
                        }
 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Files",
            style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
          backgroundColor: Color(0xFF9C38FF),
        ),
        body: Container(
          color: Color(0xFFE0CECE),


          child: Column(children: <Widget>[
            Container(
              height: size.height - 200,
              width: size.width,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          "UPLOAD IMAGES & FILES",
                          style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xFF665959)),
                        ),
                      ),
                    ),
                  
                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: StaticValue.filenames.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return ListTile(
                            title: Column(
                              children: <Widget>[
                                Row(
                                
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20,bottom: 15),
                                      child: new Image(
                                          image:
                                              new AssetImage("assets/snbizsfiles-web.png"),
                                          height:60,
                                          width: 60),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 0, 0),
                                    ),
                                    Flexible(
                                      child: Text(
                                        StaticValue.filenames[index].substring(
                                            StaticValue.filenames[index]
                                                    .lastIndexOf('/') +
                                                1),
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ],
                                ),
                                new Container(
                                  height: 1.5,
                                  width: size.width,
                                  color: Color(0xFFB162F7),
                                  margin: const EdgeInsets.only(
                                      left: 2.0, right: 2.0),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Container(
        
              height: 95,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                  color: Colors.white),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15,bottom: 10),
                    child: MaterialButton(
                       height: 50,

                      
                        onPressed: () async {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                ctx = context;
                                return new WillPopScope(

                                  onWillPop: _onBackPressed,

                                  child: Center(
                                     child: Theme(
                                        data: new ThemeData(
                                          hintColor: Colors.white,
                                        ),
                                       child: CircularProgressIndicator(

                                            strokeWidth: 3.0,
                                            backgroundColor: Colors.white
                                        ),

                                      ),
                                  ),
                                );
                              });
                              bool con = await checkConnectivity();
                              if(con == true){
                                  await upload(url);
                                Navigator.pop(context);
                               

                                 if(responsecode==200){
                                              showGeneralDialog(
                barrierColor: Colors.black.withOpacity(0.5), //SHADOW EFFECT
                transitionBuilder: (context, a1, a2, widget) {
                  return Center(
                    child: Container(
                      height: 100.0 * a1.value,  // USE PROVIDED ANIMATION
                      width: 100.0 * a1.value,
                      color: Colors.transparent,
                      child: Image(image: AssetImage("assets/acceptedtick-web.png"),),
                      

                    ),
                  );
                },
                transitionDuration: Duration(milliseconds: 700), // DURATION FOR ANIMATION
                barrierDismissible: true,
                barrierLabel: 'LABEL',
                context: context,
                pageBuilder: (context, animation1, animation2) {
                  return Text('PAGE BUILDER');

                  
                });
                 Future.delayed(const Duration(milliseconds:1000),(){
                   setState(() {
                Navigator.pop(context);
                Navigator.pop(context);
                
                   });
               
                 });
               
       }

                              }

               
                             
                              else{
                                showDialog(
                 context: context,
                 barrierDismissible: false,
                 builder: (BuildContext context){
                   return AlertDialog(
                     title: Text("Please, check your internet connection",
                  
                     style: TextStyle(color:Color(0xFFA19F9F,),
                     fontSize: 15,
                     fontWeight: FontWeight.normal),),
                     actions: <Widget>[
                       FlatButton(child: Text("OK"),
                       onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                         Navigator.pop(context);
                       })
                     ],
                   );
                 }

               );
                              }
                          
                        },
                        textColor: Colors.white,
                        color: Color(0xFFB56AFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: Text('Upload', style: TextStyle(fontSize: 20)),
                        )),
                  ),
                ],
              ),
            )
          ]),
        ));

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
  }
}

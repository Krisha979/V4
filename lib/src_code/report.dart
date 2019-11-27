import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snbiz/Model_code/documents.dart';
import 'package:snbiz/src_code/static.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Report extends StatefulWidget{

  @override
  ReportState createState() => ReportState();
}

class ReportState extends State<Report> {


   Future<List<Document>> _future; 
  
  @override
  void initState() {
    super.initState();
   _future = getDocuments();
   
  }
   //method to format date and time
  String formatDateTime(String date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime format = (dateFormat.parse(date));
    DateFormat longdate = DateFormat("EEEE, MMM d, yyyy");
    date = longdate.format(format);
    return date;
  }
    
  //internet connection function 
  
 Future<bool> _checkConnectivity()  async{
                        var result =  await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.none){
             
                         return false;
                        }
                        }

    //api call function to get the uploaded document
  Future<List<Document>> getDocuments()async{
    bool connection = await _checkConnectivity();
      if(connection == false){
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
                       })
                     ],
                   );
                 }

               );
      }else {

  try{
  http.Response data = await http.get(
          Uri.encodeFull(StaticValue.baseUrl+ StaticValue.reportUrl + StaticValue.orgId.toString()), 
          headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Cache-Control': 'no-cache,private,no-store,must-revalidate'

  }
      );
      
var jsonData = json.decode(data.body);
  List <Document> report = [];
  for (var u in jsonData){
      var reports = Document.fromJson(u);
    report.add(reports);
  }
print(report.length);
 // if(report.length == 0){
              //               // ignore: missing_return
              //           //     return Container(
              //           //     child: Center(
              //           //       child: Text("No Records Available.",
              //           //           textAlign: TextAlign.left,
              //           //           style: TextStyle(
              //           //               fontSize: 16,
              //           //               fontWeight: FontWeight.normal)
              //           //                 )
              //           // )
              //           // );
              //           showDialog(
              //    context: context,
              //    barrierDismissible: false,
              //    builder: (BuildContext context){
              //      return AlertDialog(
              //        title: Text("No Records Available.",
                  
              //        style: TextStyle(color:Color(0xFFA19F9F,),
              //        fontSize: 15,
              //        fontWeight: FontWeight.normal),),
              //        actions: <Widget>[
              //          FlatButton(child: Text("OK"),
              //          onPressed: (){
              //          Navigator.pop(context);
              //           Navigator.pop(context);
              //          })
              //        ],
              //      );
              //    }

              //  );
                 //       }else{
return report;
                    //    }



}
catch(e){
  print(e);
  return null;

}
  }
}
 @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
  return Scaffold(
        appBar: AppBar(
        backgroundColor: Color(0xFF9C38FF),
          title: Text("Report", style: TextStyle(
          color: Colors.white, fontStyle: FontStyle.normal,
           fontWeight: FontWeight.normal, fontSize: 20),),
        ),
        body:   Container(
           child: FutureBuilder(
            future: _future,
            builder:(BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
              // ignore: missing_return
              case ConnectionState.none:
                  return Container(
                  child: Center(
                      // ignore: missing_return
                      child:Flexible(child: Text("Try Loading Again.", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal))),
                  )  
                );
              case ConnectionState.active:
              case ConnectionState.waiting:
                    return Container(
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

                  )
                );
              case ConnectionState.done:
              // if (snapshot.data!=0) {
              //             return Container(
              //               child: Center(
              //                 child: Text("Try Loading Again.",
              //                     textAlign: TextAlign.left,
              //                     style: TextStyle(
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.normal)
              //                           )
              //           )
              //           );
              //           }
                          if(snapshot.data.length == 0){
                            // ignore: missing_return
                            return Container(
                            child: Center(
                              child: Text("No Records Available.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)
                                        )
                        )
                        );
                        
                        }
                        else{
                        return Container(
                          child:ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                 
                //  var url = details.documents[index].documentURL;
                  var url = snapshot.data[index].documentURL;
                  return GestureDetector(
                    onTap: (){
                       launch('$url');

                    },
                    child: Container(
                     // padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Card(
                            elevation: 5,
                            margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),

                            child: ListTile(
                              title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    // Padding(
                                    //   padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                                    // ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                        InkWell(
                                          child: Text(
                                         ( snapshot.data[index].fileName == null)? //to check if file name is null then show the last index of filename
                                         snapshot.data.substring(snapshot.data[index].documentURL.lastIndexOf('/')+1):
                                         snapshot.data[index].fileName,

                                          
                                            textAlign: TextAlign.left,
                                          style: TextStyle(
                                                 fontStyle: FontStyle.normal,
                                                 fontSize: 16,
                                                 fontWeight: FontWeight.normal),
                                           ),
                                          onTap: () {
                                            launch('$url');  // to open uploaded document
                                          },
                                        ),
                                        Text(formatDateTime( snapshot.data[index].docDate),
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFFA19F9F),
                                          fontSize: 14
                                        ),),
                                   
                                          ]),
                                      ),
                                        Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                  height: size.height / 12,
                                  width: size.height / 12,
                                  

                                  //to check the extension of image and show the icon as per the extension
                                  //pdf then pdf icon other wise generic icon 


                          child: url.contains(".jpeg") 
                                          ? Image.network(snapshot.data[index].documentURL,
                                             fit: BoxFit.cover,
                                             ): url.contains(".webp") 
                                          ? Image.network(snapshot.data[index].documentURL,
                                             fit: BoxFit.cover,
                                             ): url.contains(".mp4")
                                             ? Image(
                        image: new AssetImage("assets/mp4-icon.jpg"),
                        height: size.height / 10,
                      ): url.contains(".mp3")
                                             ? Image(
                        image: new AssetImage("assets/mp4-icon.jpg"),
                        height: size.height / 10,
                      ) : url.contains(".pdf") ?
                       Image(
                         image: new AssetImage("assets/pdf.png"),
                         height: size.height / 10,
                       ): Image( 
                         image: new AssetImage("assets/snbizsfiles-web.png"),height: size.height/10,)
                     
 )
                                    
                                        
                                      ]
                                      )
                                      ]
                                      )
                                  ),
                        ),
                              ),
                  ); 
                }
            )
                        );

                        
                        }

                        

              
                        }
                        
            }
            )
                        
   )
    );
  
  }

  }

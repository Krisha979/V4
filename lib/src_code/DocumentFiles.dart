import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snbiz/Model_code/DocumentModel.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentFilesPage extends StatefulWidget {
  final DocumentModel details;
  const DocumentFilesPage({Key key, this.details}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DocumentFilesState(this.details);
  }
}

class DocumentFilesState extends State<DocumentFilesPage> {
  final DocumentModel details;
  DocumentFilesState(this.details);
  String documentUrl;
  String formatDateTime(String date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime format = (dateFormat.parse(date));
    DateFormat longdate = DateFormat("EEEE, MMM d, yyyy");
    date = longdate.format(format);
    return date;
  }

  String formatTime(String time) {
    DateFormat dateFormatremoveT = DateFormat("yyyy-MM-ddTHH:mm:ss");
    // DateFormat dateFormat = DateFormat.yMd().add_jm();
    DateTime formattedtime = (dateFormatremoveT.parse(time));
    DateFormat longtme = DateFormat.jm();
    time = longtme.format(formattedtime);
    print(time);
    // DateTime timee = (dateFormat.parse(DateTime.now().toString()));
    return time.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   
    return Scaffold(
      appBar: AppBar(title: Text('Documents'),),
      body: 
      Container(            
         
              child: ListView.builder(
                itemCount: details.documents.length,
                itemBuilder: (BuildContext context, int index){
                   var url = details.documents[index].documentURL;
                   return Container(
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        
                                              child: ListTile(
                                                 
                          title: Container(
                      
                     
                     child:Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                                        ),
                                        Flexible(
                                          
                                          child:Column(
                                            children: <Widget>[
                                              InkWell(
                                                                                              child: Text(details.documents[index].fileName,
                                                textAlign: TextAlign.left,
                                            style: TextStyle(
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                                  
                                          ),
                                          onTap: (){
                                            launch('$url'); 
                                            
                                          },
                                              ),
                                          //  Text(details.documents[index].documentURL,
                                          //   style: TextStyle(
                                          //       fontStyle: FontStyle.normal,
                                          //       fontSize: 14,
                                          //       fontWeight: FontWeight.normal),
                                          // ),
                                            ]),
                                        ),
                                      ],
                                    ),
                    ),
         )));
                }
              
                  )
            
      )
         );     




            }
  
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snbiz/Model_code/DocumentModel.dart';
import 'package:snbiz/Model_code/OrgTask.dart';
import 'package:snbiz/Model_code/Task.dart';
import 'package:snbiz/src_code/static.dart';
import 'package:http/http.dart' as http;

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
    //Size size = MediaQuery.of(context).size;
   
    return Scaffold(
      body: 
      Container(            
         
              child: ListView.builder(
                itemCount: details.documents.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: Container(
                    width: 315.0,
                    height: 125.0,
                     decoration: new BoxDecoration(
                     color: Colors.white,
                     borderRadius: new BorderRadius.circular(15.0),
                     boxShadow: [
                     BoxShadow(
                            blurRadius: 4.0,
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(0.5, 0.5),
                          ),
                        ],
                     ),
                     child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                           Text(details.documents[index].fileName),
                           Text(details.documents[index].documentURL),
                          ],

                        ),
                  
                       ClipOval(
                          child: Material(
                            color: Colors.blue, // button color
                            child: InkWell(
                              splashColor: Colors.red, // inkwell color
                              child: SizedBox(width: 56, height: 56,
                               child: Icon(
                                 Icons.picture_as_pdf,
                                 color: Colors.white,
                                 )),
                              
                            ),
                          ),
                        )
                      ],
                    ),
                    ),
         );
                }
              
                  )
            
      )
         );     




            }
  
}
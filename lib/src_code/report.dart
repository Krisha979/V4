import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snbiz/Model_code/DocumentModel.dart';
import 'package:snbiz/src_code/static.dart';
import 'package:http/http.dart' as http;

class Report extends StatefulWidget{

  @override
  ReportState createState() => ReportState();
}

class ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
   
   Future<List<DocumentModel>> _future; 

  //internet connection function 
  
 Future<bool> _checkConnectivity()  async{
                        var result =  await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.none){
             
                         return false;
                        }
                        }

    //api call function to get the uploaded document
  Future<List<DocumentModel>> getDocuments()async{
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
  List <DocumentModel> documents = [];
  for (var u in jsonData){     
      var tasks = DocumentModel.fromJson(u);
    documents.add(tasks);
  }
print(documents.length);
return documents;

}
catch(e){
  print(e);
  return null;

}
  }
}

  }
}
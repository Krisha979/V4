import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:snbiz/Model_code/DocumentModel.dart';
import 'package:http/http.dart' as http;
import 'package:snbiz/src_code/DocumentFiles.dart';
import 'package:snbiz/src_code/static.dart';


class Documents extends StatefulWidget{

  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  Future<List<DocumentModel>> getDocuments()async{
  try{
  http.Response data = await http.get(
          Uri.encodeFull(StaticValue.baseUrl+ "api/OrgDocumentsList?Orgid=" + StaticValue.orgId.toString()), 
          headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json' 
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
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
   
    return Scaffold(
      body: 
      Container(            
         child: FutureBuilder(
          future: getDocuments(),
          builder:(BuildContext context, AsyncSnapshot snapshot){
            print(snapshot.data);
            if(snapshot.data==null){
              return Container(
                child: Center(
                child: CircularProgressIndicator()
               
                )
              );
            }else{
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  var name = snapshot.data[index].documents[0].fileTypeName;
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
                          Text(name),
                            
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
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> DocumentFilesPage(details:                        
                                snapshot.data[index])));
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    ),
         );
                }
                  );
            }
          } 
         )
      )
         );     




            }
}
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
    Size size = MediaQuery.of(context).size;
   
    return Scaffold(
      appBar: AppBar(title: Text('Documents', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)), backgroundColor: const Color(0xFF9C38FF),),
      body: Container(
               color:Color(0XFFF4EAEA),
        child: Column(
              children: <Widget>[
               
                Container(           
                          margin: EdgeInsets.fromLTRB(9, 7, 9, 7),
                         padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
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

                           child: Column(
                                children: <Widget>[ 
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("All Task"),
                                 // Text('$count'),
                                  

                                ],
                                

                              ),
                            Image(
                                      image: new AssetImage("assets/new_meeting.png"),
                                      height: size.height / 11,
                                    ),
                            ],
                          ),

                        
                        ])),
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
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  var name = snapshot.data[index].documents[0].fileTypeName;
                  return ListTile(
                      title: InkWell(
                                              child: new Theme(
                                                data: new ThemeData(
                                hintColor: Colors.white,
                              ),
                    child: Container(
                    margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                    padding: EdgeInsets.fromLTRB(10, 20, 7, 20),
                     decoration: new BoxDecoration(
                     color: Colors.white,
                     borderRadius: new BorderRadius.circular(10.0),
                     boxShadow: [
                     BoxShadow(
                            blurRadius: 4.0,
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(0.5, 0.5),
                          ),
                        ],
                     ),
                     child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                          Text(name, style: TextStyle(fontWeight: FontWeight.bold),),
                            
                          ],

                        ),
                  
                       ClipOval(
                          child: Material(
                            color: Colors.blue, // button color
                            child: InkWell(
                              splashColor: Colors.red, // inkwell color
                              child: SizedBox(
                                height: size.height/15,
                                      width: size.height/15,
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
         ),
        onTap: () {
 Navigator.push(context, MaterialPageRoute(builder: (context)=> DocumentFilesPage(details:                        
                                snapshot.data[index])));
                                      },
         )
         );
                }
                  );
            }
          } 
         )
      )
                ])  ));     




            }
}
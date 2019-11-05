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
  Future<List<DocumentModel>> _future;

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
  void initState() {
    super.initState();
    _future = getDocuments();
       
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
                width: size.width,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(0.0, 0.5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible (
                                          child: Column(
                        //  mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text("Uploaded Date",
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xFFA19F9F),
                                    fontWeight: FontWeight.bold)),
                          ),
                         Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(StaticValue.uploadedDate,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                         
Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text("Uploads today",
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xFFA19F9F),
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(StaticValue.uploadsToday.toString(),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                         
                          
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Image(
                        image: new AssetImage("assets/snbizcircledocument.png"),
                        height: size.height / 10,
                      ),
                    ),
                  ],
                ),
              ),
      Container(            
         child: FutureBuilder(
          future: _future,
          builder:(BuildContext context, AsyncSnapshot snapshot){
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                  return Container(
                  child: Center(
                      child:Flexible(child: Text("Try Loading Again.", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal))),
                  )  
                );
              case ConnectionState.active:
              case ConnectionState.waiting:
                    return Container(
                  child: Center(

                  child: CircularProgressIndicator()

                  )
                );
              case ConnectionState.done:
              print(snapshot.data);
              if(snapshot.data==null){
                
                return Container(
                  child: Center(
                      child:Container(child: Text("No details Avaliable", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal))),
                  )  
                );
              }else{
              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  var name = snapshot.data[index].documents[0].fileTypeName;
                  var icon = "assets/snbizcircledocument.png";
                                      if(name.contains("VAT Billssss")){
                                       icon = "assets/snbizvaticon.png";
                                          }
                                          else if(name.contains("Instant")){
                                            icon = "assets/snbizinstantupload.png";
                                          }else{
                                            icon = "assets/snbizcircledocument.png";
                                          }  
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
                   
                     ),
                     child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
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
                               child:Image(
                        image: new AssetImage(icon),
                        height: size.height / 12,
                      ),),
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
            return Container(
                  child: Center(
                      child:Flexible(child: Text("Try Loading Again.", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal))),
                  )  
                );
          } 
         )
      )
                ])  ));     




            }
}
import 'dart:convert';
import 'package:SNBizz/Model_code/DocumentModel.dart';
import 'package:SNBizz/src_code/search.dart';
import 'package:SNBizz/src_code/static.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';


class Documents extends StatefulWidget{
  String parentkey,documentkey;
  Documents(this.parentkey,this.documentkey);

  @override
  _DocumentsState createState() => _DocumentsState(parentkey,documentkey);
}

class _DocumentsState extends State<Documents> {
  String parentkey,documentkey;
  _DocumentsState(this.parentkey,this.documentkey);
  Future<List<ParentDocumentModel>> _future;
  Future<List<DocumentListModel>> _futuredocumentlist;

  //internet connection function 
  
 Future<bool> _checkConnectivity()  async{
                        var result =  await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.none){
             
                         return false;
                        }
                        }

  Future<List<ParentDocumentModel>> getParentDocuments(String parenttypeid)async{
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
      if(parenttypeid ==null){
      parenttypeid="";
      }
      try{
        http.Response data = await http.get(
            Uri.encodeFull(StaticValue.baseUrl+ "/api/OrgParentDocList"+"?Orgid="+StaticValue.orgId.toString()+"&parenttypeid="+parenttypeid.toString()),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              "apikey" : StaticValue.apikey,
              'Cache-Control': 'no-cache,private,no-store,must-revalidate'

            }
        );

        var jsonData = json.decode(data.body);
        List <ParentDocumentModel> documents = [];
        for (var u in jsonData){
          var tasks = ParentDocumentModel.fromJson(u);
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

  //api call function to get the uploaded document
  // ignore: missing_return
  Future<List<DocumentListModel>> getDocumentlist(String parenttypeid)async{
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
            Uri.encodeFull(StaticValue.baseUrl+ "/api/DocumentList?Orgid="+StaticValue.orgId.toString()+"&parenttypeid="+parenttypeid.toString()),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              "apikey" : StaticValue.apikey,
              'Cache-Control': 'no-cache,private,no-store,must-revalidate'

            }
        );

        var jsonData = json.decode(data.body);
        List <DocumentListModel> documents = [];
        for (var u in jsonData){
          var tasks = DocumentListModel.fromJson(u);
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

  //method to format date and time
  String formatDateTime(String date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime format = (dateFormat.parse(date));
    DateFormat longdate = DateFormat("EEEE, MMM d, yyyy");
    date = longdate.format(format);
    return date;
  }
//method to format time
  String formatTime(String time) {
    DateFormat dateFormatremoveT = DateFormat("yyyy-MM-ddTHH:mm:ss");

    DateTime formattedtime = (dateFormatremoveT.parse(time));
    DateFormat longtme = DateFormat.jm();
    time = longtme.format(formattedtime);
    print(time);

    return time.toString();
  }


 @override
  void initState() {
    super.initState();
    _future = getParentDocuments(parentkey);
    _futuredocumentlist = getDocumentlist(documentkey);

       
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Color(0XFFF4EAEA),
      appBar: AppBar(
        title: Text('Documents', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)), backgroundColor: const Color(0xFF9C38FF),
        actions: <Widget>[
           InkWell(
             onTap: (){
               Navigator.push(context,
                   CupertinoPageRoute(builder: (context) => Search()));
             },
             child: Padding(
               padding: const EdgeInsets.only(right:8.0),
               child: Icon(Icons.search),
             ),
           )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[


                 Wrap(
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
                                          child: Text(StaticValue.uploadsToday,
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

                              FutureBuilder(
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
                                                    margin: EdgeInsets.all(10),
                                                    height: size.width/2,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Theme(
                                                          data: new ThemeData(
                                                            hintColor: Colors.white,
                                                          ),
                                                          child: CircularProgressIndicator(

                                                              strokeWidth: 3.0,
                                                              backgroundColor: Colors.white
                                                          ),

                                                        ),
                                                      ],
                                                    ),


                                                  );
                                            case ConnectionState.done:
                                           if (!snapshot.hasData) {
                                                        return Container(
                                                          height: 1,
                                                      );
                                                      } else {
                                                        if(snapshot.data.length == 0){
                                                          return Container(
                                                          height: 1.0,
                                                      );}

                                                        return Column(
                                                          children: <Widget>[
                                                            Row(
                                                              children: <Widget>[
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top:8.0,left: 15.0),
                                                                  child: Text("Folders",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                            height: snapshot.data.length*size.width/3,

                                                            child:  ListView.builder(
                                                                    physics: const NeverScrollableScrollPhysics(),
                                                                    primary: true,
                                                                    itemCount: snapshot.data.length,
                                                                    itemBuilder: (BuildContext context, int index){
                                                                      var name = snapshot.data[index].fileTypeName.toString().toUpperCase();
                                                                      var icon = "assets/foldernewicon.png";
                                                                      //condition to show the icon according to the uploaded file type
                                                                                          if(name.contains("VAT Billssss")){
                                                                                           icon = "assets/snbizvaticon.png";
                                                                                              }
                                                                                              else if(name.contains("Instant Uploads")){
                                                                                                icon = "assets/snbizinstantupload.png";
                                                                                              }
                                                                                              else if(name.contains("Legals")){
                                                                                               icon = "assets/legals.png";
                                                                                               }
                                                                                          else if(name.contains("Registration")){
                                                                                            icon = "assets/registration-web.png";
                                                                                          }
                                                                                          else if(name.contains("Expense")){
                                                                                            icon = "assets/expense-web.png";
                                                                                          }
                                                                                          else if(name.contains("Income")){
                                                                                            icon = "assets/income-web.png";
                                                                                          }
                                                                                          else if(name.contains("Profit")){
                                                                                            icon = "assets/profit-web.png";
                                                                                          }
                                                                                                else{
                                                                                                icon = "assets/foldernewicon.png";

                                                                                              }
                                                                      return Card(
                                                                        margin: EdgeInsets.only(left:8,right: 8,top: 4),
                                                                        child: ListTile(
                                                                            title: InkWell(
                                                                                                    child: new Theme(
                                                                                                      data: new ThemeData(
                                                                                      hintColor: Colors.white,
                                                                                    ),
                                                                          child: Container(
//                                                                        margin: EdgeInsets.fromLTRB(0, 2, 2, 0),
                                                                          padding: EdgeInsets.fromLTRB(12, 20, 10, 20),
                                                                           decoration: new BoxDecoration(
                                                                           color: Colors.white,
                                                                           borderRadius: new BorderRadius.circular(3.0),

                                                                           ),
                                                                           child: new Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Column(
                                                                               crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: <Widget>[
                                                                                Text(name, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),

                                                                                ],

                                                                              ),

                                                                             ClipOval(
                                                                                child: Material(
                                                                                  color: Colors.white, // button color
                                                                                  child: InkWell(
                                                                                 //   splashColor: Colors.red, // inkwell color
                                                                                    child: SizedBox(
                                                                                      height: size.height/15,
                                                                                            width: size.height/15,
                                                                                     child:Image(
                                                                              image: new AssetImage(icon),
                                                                              height: size.height / 12,
                                                                            ),),
                                                                                    onTap: () {
                                                                                      Navigator.push(
                                                                                          context,
                                                                                          CupertinoPageRoute(
                                                                                              builder: (context) =>
                                                                                                  Documents(snapshot.data[index].fileTypeId.toString(),snapshot.data[index].fileTypeId.toString())));
//                                                                                      _future=  getParentDocuments(snapshot.data[index].fileTypeId.toString());
//                                                                                      _futuredocumentlist=getDocumentlist(snapshot.data[index].fileTypeId.toString());
                                                                                      setState(() {

                                                                                      });

                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          ),
                                                   ),
                                                                                    onTap: () {
                                                                                      Navigator.push(
                                                                                          context,
                                                                                          CupertinoPageRoute(
                                                                                              builder: (context) =>
                                                                                                  Documents(snapshot.data[index].fileTypeId.toString(),snapshot.data[index].fileTypeId.toString())));
//                                                                                     _future=  getParentDocuments(snapshot.data[index].fileTypeId.toString());
//                                                                                      _futuredocumentlist=getDocumentlist(snapshot.data[index].fileTypeId.toString());
                                                                                      setState(() {

                                                                                      });
                                                                                            },
                                                   )
                                                   ),
                                                                      );
                                                                    }
                                                                      ),


                                                            ),
                                                          ],
                                                        );
                                            }
                                            }
                                                          return Container(
                                                                child: Center(
                                                                    child:Flexible(child: Text("Try Loading Again.", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal))),
                                                                )
                                                              );
                                          }
                                         ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0,right:8.0),
                                child: Divider(height: 1.0,thickness: 1.0,color: Colors.white,),
                              ),
                              FutureBuilder(
                                            future: _futuredocumentlist,
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
                                                      height: size.width/2,
                                                    margin: EdgeInsets.all(10),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Theme(
                                                              data: new ThemeData(
                                                                hintColor: Colors.white,
                                                              ),
                                                              child: CircularProgressIndicator(

                                                                  strokeWidth: 3.0,
                                                                  backgroundColor: Colors.white
                                                              ),

                                                            ),
                                                          ],
                                                        ),


                                                  );
                                                case ConnectionState.done:
                                                  if (!snapshot.hasData) {
                                                    return Container(
                                                        child: Center(
                                                            child: Text("Try Loading Again.",
                                                                textAlign: TextAlign.left,
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.normal)
                                                            )
                                                        )
                                                    );
                                                  } else {
                                                    if(snapshot.data.length == 0){
                                                      return Container(
                                                        height: 1.0,
                                                      );}
                                                    return  Column(
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding: const EdgeInsets.only(top:8.0,left: 15.0),
                                                              child: Text("Files",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: snapshot.data.length*size.width/3.8,

                                                              child: ListView.builder(
                                                                  physics: NeverScrollableScrollPhysics(),
                                                                  primary: true,
                                                                  itemCount: snapshot.data.length,
                                                                  itemBuilder: (BuildContext context, int index) {
                                                                    var url = snapshot.data[index].documentURL;
                                                                    return GestureDetector(
                                                                      onTap: (){
                                                                        launch('$url');

                                                                      },
                                                                      child: Container(

                                                                        child: Card(

                                                                          margin: EdgeInsets.fromLTRB(10.0, 5.0, 4.0, 0.0),

                                                                          child: ListTile(
                                                                              title: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: <Widget>[
                                                                                              InkWell(
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.only(top:8.0),
                                                                                                  child: Text(
                                                                                                    ( snapshot.data[index].fileName == null)? //to check if file name is null then show the last index of filename
                                                                                                   snapshot.data[index].documentURL.substring(snapshot.data[index].documentURL.lastIndexOf('/')+1):
                                                                                                    snapshot.data[index].fileName,


                                                                                                    textAlign: TextAlign.left,
                                                                                                    style: TextStyle(
                                                                                                        fontStyle: FontStyle.normal,
                                                                                                        fontSize: 16,
                                                                                                        fontWeight: FontWeight.normal),
                                                                                                  ),
                                                                                                ),
                                                                                                onTap: () {
                                                                                                  launch('$url');  // to open uploaded document
                                                                                                },
                                                                                              ),
                                                                                              Text(formatDateTime(snapshot.data[index].dateCreated),
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
                                                                                                  image: new AssetImage("assets/docnew.png"),height: size.height/10,)

                                                                                            )


                                                                                          ]
                                                                                      )
                                                                                    ]
                                                                                ),
                                                                              )
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                              ),


                                                        ),
                                                      ],
                                                    );
                                                  }
                                              }
                                              return Container(
                                                  child: Center(
                                                    child:Flexible(child: Text("Try Loading Again.", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal))),
                                                  )
                                              );
                                            }
                                        ),


                    ]),

          ],
        ),
      ),


     );




            }
}
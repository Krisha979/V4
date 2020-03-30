
import 'package:SNBizz/Model_code/DocumentModel.dart';
import 'package:SNBizz/src_code/static.dart';
import 'package:SNBizz/src_code/static.dart' as prefix0;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Search extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SearchState();
  }

}
Future<List<ParentDocumentModel>> _future;
Future<List<DocumentListModel>> _futuredocumentlist;

//Future<List<ParentDocumentModel>> _futureparent;
//Future<List<DocumentListModel>> _futuredocument;

TextEditingController _searchcontroller = new TextEditingController();
bool loading =false;
class SearchState extends State<Search>{
  // ignore: missing_return
  Future<bool> _checkConnectivity()  async{
    var result =  await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none){

      return false;
    }
  }
  String formatDateTime(String date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime format = (dateFormat.parse(date));
    DateFormat longdate = DateFormat("EEEE, MMM d, yyyy");
    date = longdate.format(format);
    return date;
  }
  //api call function to get the uploaded document
  // ignore: missing_return
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
        StaticValue.parentfilteredlist.clear();
        setState(() {

          StaticValue.parentfilteredlist = documents;
        });
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
        StaticValue.documentfilteredlist.clear();
        setState(() {

          StaticValue.documentfilteredlist = documents;
        });
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
  Future<List<ParentDocumentModel>> searchparents(String searchitem)async{
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
            Uri.encodeFull(StaticValue.baseUrl+ "/api/SearchByParent"+"?Orgid="+StaticValue.orgId.toString()+"&searchterm="+searchitem.toString().toLowerCase()),
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

        setState(() {
          StaticValue.parentfilteredlist = documents;
        });

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
  Future<List<DocumentListModel>> searchdocuments(String searchitem)async{
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
            Uri.encodeFull(StaticValue.baseUrl+ "/api/SearchByDocument?Orgid="+StaticValue.orgId.toString()+"&searchterm="+searchitem.toString().toLowerCase()),
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

        setState(() {
          StaticValue.documentfilteredlist = documents;
        });

        print(documents.length);
        return documents;

      }
      catch(e){
        print(e);
        return null;

      }
    }
  }
  @override
  void initState() {
    super.initState();
   StaticValue.parentfilteredlist.clear();
   StaticValue.documentfilteredlist.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Colors.white70,
      appBar: AppBar(
        title: Text('Documents', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)), backgroundColor: const Color(0xFF9C38FF),
        actions: <Widget>[
        ],
      ),
      body: SingleChildScrollView(
        child: Wrap(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0,0.0,10.0,0.0),
                        child: new Container(
                          margin: EdgeInsets.only(top: 15),
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffEFE6E6),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0, 2.0), // shadow direction: bottom right
                                )
                              ],
                            ),
                            child: TextFormField(
                              controller: _searchcontroller,
                              onFieldSubmitted: (String value) async {

                                if(value.isNotEmpty){
                                  setState(() {
                                    loading =true;
                                    if(StaticValue.parentfilteredlist.isNotEmpty){
                                      StaticValue.parentfilteredlist.clear();
                                    }
                                    if(StaticValue.documentfilteredlist.isNotEmpty){
                                      StaticValue.documentfilteredlist.clear();
                                    }
                                  });



                                  _future = searchparents(_searchcontroller.text);
                                  _futuredocumentlist = searchdocuments(_searchcontroller.text);

                                  setState(() {
                                    loading=false;
                                  }
                                  );

                                }else{
                                showdialoge(context, "Search Text Cannot be Empty");

                                }




                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                hintStyle: TextStyle(fontSize: 17),
                                hintText: 'Search documents here',fillColor: Color(0xff1470AE),
                                focusColor: Color(0xff1470AE),
                                hoverColor: Color(0xff1470AE),


                                suffixIcon: InkWell(
                                    onTap: () async {
                                      if(_searchcontroller.text.isNotEmpty){
                                        setState(() {
                                          loading =true;
                                          if(StaticValue.parentfilteredlist.isNotEmpty){
                                            StaticValue.parentfilteredlist.clear();
                                          }
                                          if(StaticValue.documentfilteredlist.isNotEmpty){
                                            StaticValue.documentfilteredlist.clear();
                                          }
                                        });




                                        _future = searchparents(_searchcontroller.text);
                                        _futuredocumentlist = searchdocuments(_searchcontroller.text);

                                        setState(() {
                                          loading=false;
                                        }
                                        );

                                      }else{
                                        showdialoge(context, "Search Text Cannot be Empty");
                                      }
                                    },
                                    child: Icon(Icons.search,color: Colors.black,)),
                                border: InputBorder.none,
                              ),
                            ),

                          ),

                        ),
                      ),
                      loading==false?StaticValue.parentfilteredlist.isNotEmpty?
                      Container(
                        child: Column(
                          children: <Widget>[
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
                                                    var name = snapshot.data[index].fileTypeName;
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
                                                                            setState(() {
                                                                              loading =true;
                                                                            });
                                                                            _future =  getParentDocuments(snapshot.data[index].fileTypeId.toString());
                                                                            _futuredocumentlist = getDocumentlist(snapshot.data[index].fileTypeId.toString());
                                                                            setState(() {
                                                                          loading=false;
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
                                                              setState(() {
                                                                loading =true;
                                                              });
                                                              _future =  getParentDocuments(snapshot.data[index].fileTypeId.toString());
                                                              _futuredocumentlist = getDocumentlist(snapshot.data[index].fileTypeId.toString());
                                                              setState(() {
                                                                loading =false;
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
                          ],
                        ),
                      ):Container(
                          height: 1,
                          ):Container(
                        height: 1,
                        margin: EdgeInsets.only(top:20,right: 15),
                      ),
                      loading==false?StaticValue.documentfilteredlist.isNotEmpty?
                      Container(

                        child: Wrap(
                          children: <Widget>[
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
                                                                                  snapshot.data[index].documentURL.substring(snapshot.data[index].documentURL.lastIndexOf('/')+1):
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
                          ],
                        ),
                      ):Container(
                          height:size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Search Document \nusing Name \n& Folders using Name",style: TextStyle(color: Colors.white),),
                        ),
                        ): Container(
                        height: 1,
                        margin: EdgeInsets.only(top:20,right: 15),
                      ),

                    ],),
                  ],

                ),
      ),





    );

  }

}

showdialoge(BuildContext context,String message) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message,
            style: TextStyle(color: Color(0xFFA19F9F,),
                fontSize: 15,
                fontWeight: FontWeight.normal),),
          actions: <Widget>[
            FlatButton(child: Text("OK"),
                onPressed: () {

                  Navigator.pop(context);
                })
          ],
        );
      }
  );
}

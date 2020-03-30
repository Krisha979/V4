import 'dart:convert';

import 'package:SNBizz/Model_code/Notification.dart';
import 'package:SNBizz/src_code/send-notification.dart';
import 'package:SNBizz/src_code/static.dart';
import 'package:SNBizz/src_code/task.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'documents.dart';
import 'invoice.dart';

class AllNotification extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return AllNotificationState();
  }
}

class AllNotificationState extends State<AllNotification> {
  int notificationNumber = 0;
  Future<List<NotificationModel>> _future;
  final RefreshController _refreshController = RefreshController();
  String date;
  bool loading = false;
  List<int> deleteloading =[];
  final storage = new FlutterSecureStorage();
  var latestid;


  //to check internet 
  // ignore: missing_return
  Future<bool> _checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    }
  }


  // ignore: missing_return
  Future<int> deletenotifications(BuildContext context,String notifid) async {

    bool connection = await _checkConnectivity();
    if (connection == false) {    //condtition to check the internet connectivity
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Please, check your internet connection",
                style: TextStyle(
                    color: Color(
                      0xFFA19F9F,
                    ),
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
              actions: <Widget>[
                FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      StaticValue.controller.animateTo(0);
                      Navigator.pop(context);
                    })
              ],
            );
          });
    } else {
      try {
        String orgid ="";
        if(notifid==""){
          orgid = StaticValue.orgId.toString();
        }
        http.Response response = await http.get( Uri.encodeFull(StaticValue.baseUrl
            +"api/DeleteNotification"+"?notifid="+notifid+"&orgid="+orgid
        ),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "apikey" : StaticValue.apikey,
            'Cache-Control': 'no-cache,private,no-store,must-revalidate'
          },
        );

        print(response);
        return response.statusCode;

      } catch (e) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  "Please, check your internet connection",
                  style: TextStyle(
                      color: Color(
                        0xFFA19F9F,
                      ),
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
                actions: <Widget>[
                  FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        StaticValue.controller.animateTo(0);
                        Navigator.pop(context);
                      })
                ],
              );
            });
      }
    }
  }


  // ignore: missing_return
  Future<List<NotificationModel>> getNotifications() async { //function to call notification api
    bool connection = await _checkConnectivity();
    if (connection == false) {    //condtition to check the internet connectivity
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Please, check your internet connection",
                style: TextStyle(
                    color: Color(
                      0xFFA19F9F,
                    ),
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
              actions: <Widget>[
                FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      StaticValue.controller.animateTo(0);
                      Navigator.pop(context);
                    })
              ],
            );
          });
    } else {
      try {
        http.Response data = await http.get(   // recent notification api call
            Uri.encodeFull(StaticValue.baseUrl +
                 StaticValue.notification_url +
                StaticValue.orgId.toString()),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
               "apikey" : StaticValue.apikey,
              'Cache-Control': 'no-cache,private,no-store,must-revalidate'
            });
        var jsonData = json.decode(data.body);
        List<NotificationModel> notifications = [];
        for (var u in jsonData) {
          var notification = NotificationModel.fromJson(u);
          notifications.add(notification);
        }
      //  print(notifications.length);
        setState(() {
          StaticValue.shownotificationReceived=false;
          notificationNumber = notifications.length;
        });
        latestid = notifications[0].notificationId;
        print(latestid);
        var id = await storage.read(key: "LatestNotificationId");
        try {
          StaticValue.latestNotificationId = int.parse(id);
        } catch (e) {
          StaticValue.latestNotificationId = 0;
        }
        print(StaticValue.latestNotificationId);
        return notifications;
      } catch (e) {
        print(e);
        return null;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _future = getNotifications();
    });
  }

  Future<void> storeLatesId(String id) async {   //to store the last nottification id
    await storage.write(key: "LatestNotificationId", value: id);
  }

  String formatDateTime(String date) {   // date time format  method
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime format = (dateFormat.parse(date));
    DateFormat longdate = DateFormat("EEEE, MMM d, yyyy");
    date = longdate.format(format);
    return date;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
          _future = getNotifications();
          _refreshController.refreshCompleted(); //method call for refreshing page
        },
        child: Container(
          width: size.width,
          color: Color(0XFFF4EAEA),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text("ALL NOTIFICATIONS",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFA19F9F),
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            '$notificationNumber',   
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        loading==false?InkWell(
                          onTap: () async {


                            setState(() {
                              loading=true;
                            });
                            var status = await deletenotifications(context,"");

                            if(status.toString().contains("20")){

                              setState(() {
                                _future = getNotifications();
                              loading = false;
                              });
                            }else{
                              setState(() {
                                loading=false;
                              });
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Task Failed..Please check your internet connection...",
                                        style: TextStyle(
                                            color: Color(
                                              0xFFA19F9F,
                                            ),
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                            child: Text("OK"),
                                            onPressed: () {

                                              Navigator.pop(context);
                                            })
                                      ],
                                    );
                                  });
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 28.0,top: 8.0),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 0.10,color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.delete_outline,color: Colors.brown,),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(child: Text("Clear\nAll Notifications",style: TextStyle(color: Colors.brown,fontSize: 12,fontWeight: FontWeight.bold),)),
                                ),
                              ],
                            ),
                          ),
                        ):Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 25,width: 25,
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
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: (){
                                 Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        SendNotification()));
                            },
                                                      child: Image(
                              image: new AssetImage("assets/snbiznotification.png"),
                              height: size.height / 11,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: (){
                               Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        SendNotification()));

                            },
                                                      child: Text("Send", style: TextStyle(color: Color(0xFFA19F9F), fontWeight: FontWeight.normal,
                            fontSize: 16),),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

                   Expanded(

                      child: Container(
                     color: Color(0XFF),
                       margin: EdgeInsets.fromLTRB(10, 10, 10, 0),

                        child: FutureBuilder(
                            future: _future,
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
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
              
              if (!snapshot.hasData) {
                          return Container(
                            child: Center(
                              child: Text("No Records Avaliable.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)
                                        )
                        )
                        );
                        } else {
                                return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var date = formatDateTime(
                                          snapshot.data[index].dateCreated);
                                      var type = "";
                                      int color = 0xFFA19F9F;
                                      var icon = "assets/snbiznotification.png";

                                      //condtition to set the icon according to the type of notification
                                      if (snapshot.data[index].notificationBody   
                                          .contains("meeting")) {
                                        icon = "assets/snbizmeetings.png";
                                      } else if (snapshot
                                          .data[index].notificationBody
                                          .contains("Document")) {
                                        icon = "assets/snbizuploads.png";
                                      } else if (snapshot
                                          .data[index].notificationBody
                                          .contains("Task")) {
                                        icon = "assets/snbiztasks.png";
                                      } else if (snapshot
                                          .data[index].notificationBody
                                          .contains("invoice")) {
                                        icon = "assets/snbizinvoice.png";
                                      }
                                      if (StaticValue.latestNotificationId !=
                                              null &&
                                          snapshot.data[index].notificationId >
                                              StaticValue
                                                  .latestNotificationId) {
                                        type = "New";
                                        color = 0xFFEFF0F1;
                                      }


                                      return GestureDetector(
                                        child: Wrap(children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0.0, 5.0, 0.0, 0.0),
                                              padding: EdgeInsets.fromLTRB(
                                                  15, 10, 15, 10),
                                              constraints: new BoxConstraints(
                                                  minWidth: size.width),
                                              width: size.width,
                                              decoration: new BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                              ),
                                              child: buildListTile(snapshot,index,date,type,icon,color)),
                                        ]),
                                        onTap: () {
                                          String notificationtype = snapshot
                                              .data[index].notificationBody
                                            ..toString();

                                            //navigating to the particular page according to the notification type
                                          if (notificationtype
                                              .contains("meeting")) {
                                            StaticValue.controller.animateTo(1);
                                          } else if (notificationtype
                                              .contains("Document")) {
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        Documents("","")));
                                          } else if (notificationtype
                                              .contains("Task")) {
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        TaskPage()));
                                          } else if (notificationtype
                                              .contains("invoice")) {
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        Invoice()));
                                          }
                                        },
                                      );
                                    });
                              }
                          }
                          return Container(
                              child: Center(
                            child: Flexible(
                                child: Text("Try Loading Again.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal))),
                          ));
                        })),
              ),
            ],
          ),
        ),
      ),
    );
  }



  ListTile buildListTile(AsyncSnapshot snapshot, int index, String date, type,
      String icon, int color) {
    var list = ListTile(
      title: Container(
        padding: EdgeInsets.only(top: 10),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Text(
                    snapshot.data[index].notificationBody,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(date,
                      style: TextStyle(color: Color(0xFFA19F9F), fontSize: 16)),

                  Row(
                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: Text(
                          type,
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                      !deleteloading.contains(snapshot.data[index].notificationId)?InkWell(
                        onTap: () async {
                          setState(() {
                            deleteloading.add(snapshot.data[index].notificationId);
                          });
                          var status = await deletenotifications(context,snapshot.data[index].notificationId.toString());
                          if(status.toString().contains("20")){

                            setState(() {
                              _future = getNotifications();
                              deleteloading.remove(snapshot.data[index].notificationId);
                            });
                          }else{
                            setState(() {
                              deleteloading.clear();
                            });
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Task Failed..Please check your internet connection...",
                                      style: TextStyle(
                                          color: Color(
                                            0xFFA19F9F,
                                          ),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                          child: Text("OK"),
                                          onPressed: () {

                                            Navigator.pop(context);
                                          })
                                    ],
                                  );
                                });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,3),
                          child: Container(
                              height: 30,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white70),
                              padding: EdgeInsets.all(3),
                              child: Icon(Icons.delete_outline,color: Colors.brown,size: 25,)),
                        ),
                      ):Container(
                          height: 30,width: 30,
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                ClipOval(
                  child: Material(
                    color: Colors.blue,
                    child: InkWell(
                        splashColor: Colors.red,
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image(
                            image: new AssetImage(icon),
                            height: 50,
                            width: 50,
                          ),
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    storeLatesId(latestid.toString());
    return list;
  }
}

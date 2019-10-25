import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:snbiz/Model_code/Notification.dart';
import 'package:snbiz/src_code/static.dart';

class AllNotification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AllNotificationState();
  }
}

class AllNotificationState extends State<AllNotification> {
  int notificationNumber;
  Future<List<NotificationModel>> _future;
  final RefreshController _refreshController = RefreshController();
  String date;
  final storage = new FlutterSecureStorage();
  var latestid;
  Future<List<NotificationModel>> getNotifications() async {
    try {
      http.Response data = await http.get(
          Uri.encodeFull(StaticValue.baseUrl +
              "api/RecentNotifications?Orgid=" +
              StaticValue.orgId.toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      var jsonData = json.decode(data.body);
      List<NotificationModel> notifications = [];
      for (var u in jsonData) {
        var notification = NotificationModel.fromJson(u);
        notifications.add(notification);
      }
      print(notifications.length);
      setState(() {
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

  @override
  void initState() {
    super.initState();
    setState(() {
      _future = getNotifications();
    });
  }

  Future<void> storeLatesId(String id) async {
    await storage.write(key: "LatestNotificationId", value: id);
  }

  String formatDateTime(String date) {
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
          getNotifications();
          _refreshController.refreshCompleted();
        },
        child: Container(
          // height: size.height * 2,
          width: size.width,
          color: Color(0xFFE0CECE),
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
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text("ALL NOTIFICATIONS",
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xFFA19F9F))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            '$notificationNumber',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Image(
                                image: new AssetImage("assets/due.png"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text("Last Notification",
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xFFA19F9F))),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image(
                        image: new AssetImage("assets/notification.png"),
                        height: size.height / 10,
                      ),
                    ),
                  ],
                ),
              ),

                   Expanded(
                      child: Container(
                      
                       color: Colors.white,
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

                  child: CircularProgressIndicator()

                  )
                );
              case ConnectionState.done:
              print(snapshot.data);
              if(snapshot.data==null){
                return Container(
                  child: Center(
                      child:Flexible(child: Text("No records Available.", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal))),
                  )  
                );
              }else{
                                return ListView.builder(
                                  
                                    shrinkWrap: true,
                                    physics: const AlwaysScrollableScrollPhysics(),

                                    itemCount: snapshot.data.length,

                                    itemBuilder: (BuildContext context, int index) {
                                      var date = formatDateTime(
                                          snapshot.data[index].dateCreated);
                                      var type = "";
                                      if (StaticValue.latestNotificationId != null &&
                                          snapshot.data[index].notificationId >
                                              StaticValue.latestNotificationId) {
                                        type = "New";
                                      }
                                      return Card(

                                          elevation: 3,
                                              margin: EdgeInsets.fromLTRB(
                                                  10.0, 15.0, 10.0, 0.0),

                                        child: buildListTile(snapshot, index, date, type));
                                        
                                    });
                              }
                               }
                               return Container(
                  child: Center(
                      child:Flexible(child: Text("Try Loading Again.", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal))),
                  )  
                );
                              
                            })),
                   ),

                          
            ],
              ),
            
          ),
        ),
      
    );
  }

  ListTile buildListTile(AsyncSnapshot snapshot, int index, String date, type) {
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
                  Center(child: Text(snapshot.data[index].notificationBody)),
                  Text(date),
                  Text(type),
                ],
              ),
            ),
            ClipOval(
              child: Material(
                color: Colors.blue, // button color
                child: InkWell(
                  splashColor: Colors.red, // inkwell color
                  child: SizedBox(
                      width: 56,
                      height: 56,
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
    storeLatesId(latestid.toString());
    return list;
  }
}

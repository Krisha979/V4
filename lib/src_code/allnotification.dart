import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:snbiz/Model_code/Notification.dart';
import 'package:snbiz/src_code/static.dart';
class AllNotification extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AllNotificationState();
  }
  
}

class AllNotificationState extends State<AllNotification>{
   final storage = new FlutterSecureStorage();
   var latestid;
  Future<List<NotificationModel>> getNotifications()async{
  try{
  http.Response data = await http.get(
          Uri.encodeFull("https://s-nbiz.conveyor.cloud/" + "api/RecentNotifications?Orgid=" + StaticValue.orgId.toString()), 
          headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json' 
        }
      );
  var jsonData = json.decode(data.body);
  List <NotificationModel> notifications = [];
  for (var u in jsonData){
      var notification = NotificationModel.fromJson(u);
    notifications.add(notification);
  }
print(notifications.length);
latestid = notifications[0].notificationId; 
print(latestid);
StaticValue.latestNotificationId = int.parse(await storage.read(key:"LatestNotificationId"));
print(StaticValue.latestNotificationId);
return notifications;
 
}
catch(e){
  print(e);
  return null;

}
}

Future<void> storeLatesId(String id)async {
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
    //Size size = MediaQuery.of(context).size;
   
    return Scaffold(
      body: 
      Container(            
         child: FutureBuilder(
          future: getNotifications(),
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
                   var date = formatDateTime(snapshot.data[index].dateCreated);
                   var type="";
                    if(StaticValue.latestNotificationId !=null && snapshot.data[index].notificationId > StaticValue.latestNotificationId){
                             type = "New";
                       }
                  return buildListTile(snapshot, index, date, type);
                }
                
                  );
                  
            }
          } 
         )
      )
         );     
   }

 ListTile buildListTile(AsyncSnapshot snapshot, int index, String date, type) {
   var list =  ListTile(
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
                        Text(snapshot.data[index].notificationBody),
                         Text(date),
                          Text(type),
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
       storeLatesId(latestid.toString());
       return list;
 }

}
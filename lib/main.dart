

import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:snbiz/src_code/home.dart';
import 'package:snbiz/src_code/login.dart';

void main() {
  runApp(new AppStart());
}

class AppStart extends StatefulWidget {
  @override
  _AppStart createState() => _AppStart();
}

class _AppStart extends State<AppStart> {
final FirebaseMessaging _fcm = FirebaseMessaging();
 FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
 
//  Future<void> getnotified() async {
//       var pendingNotificationRequest = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
//  }

  Future<dynamic> selectNotification(String payload){
      return showDialog(
                context: context,
                builder: (context) => AlertDialog(
                        content: new Text('$payload'),
                        title: Text('aa'),
                ),
            );
    }

    // Future scheduleNotification(int time, int channelid) async{
    //           var scheduledNotificationDateTime =
    //           new DateTime.now().add(new Duration(seconds: time));
    //           var currenttime = DateTime.now();
    //           String message;
    //           int hours = currenttime.hour;
    //           if(hours<=12){
    //               message = "Good Morning!";
    //           }else if(hours<=16){
    //               message = "Good Afternoon!";
    //           }else if(hours<=21){
    //               message = "Good Evening!";
    //           }else if(hours<=24){
    //               message = "Good Night!";
    //           }
            
    //           var vibrationPattern = new Int64List(10);
    //             vibrationPattern[0] = 0;
    //             vibrationPattern[1] = 100
    //             ;
    //             // vibrationPattern[2] = 500;
    //             // vibrationPattern[3] = 1000;
    //             // vibrationPattern[4] = 500;
    //             // vibrationPattern[5] = 1000;
    //             // vibrationPattern[6] = 500;
    //             // vibrationPattern[7] = 200;
    //             // vibrationPattern[8] = 100;
    //             // vibrationPattern[9] = 200;

    //   var androidPlatformChannelSpecifics =
    //       new AndroidNotificationDetails('channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
    //   priority: Priority.High,importance: Importance.Max, vibrationPattern: vibrationPattern
    //   );
    //   var iOSPlatformChannelSpecifics =
    //       new IOSNotificationDetails();
    //   NotificationDetails platformChannelSpecifics = new NotificationDetails(
    //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    //   await flutterLocalNotificationsPlugin.schedule(
    //       channelid,
    //       'S.N Business',
    //       message,
    //       scheduledNotificationDateTime,
    //       platformChannelSpecifics);
    // }

    showNotification(Map<String,dynamic> message) async {
      var vibrationPattern;
    if(message.toString().contains("due")){
      vibrationPattern= new Int64List(10);
      vibrationPattern[0] = 500;
      vibrationPattern[1] = 1000;
      vibrationPattern[2] = 500;
      vibrationPattern[3] = 1000;
      vibrationPattern[4] = 500;
      vibrationPattern[5] = 1000;
      vibrationPattern[6] = 500;
      vibrationPattern[7] = 200;
      vibrationPattern[8] = 100;
      vibrationPattern[9] = 2000;
    }else{
      vibrationPattern= new Int64List(10);
      vibrationPattern[0] = 200;
    }


      var android = new AndroidNotificationDetails('channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.High,importance: Importance.Max
          ,vibrationPattern: vibrationPattern
      );
      var iOS = new IOSNotificationDetails();
      var platform = new NotificationDetails(android, iOS);
      await flutterLocalNotificationsPlugin.show(0, 'S.N. Business', message['notification']['body'], platform,payload: message['data']['body']);
    }
@override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    // scheduleNotification(10,1000000);
    // scheduleNotification(20,100);
    var android = new AndroidInitializationSettings("@mipmap/launcher_icons");
    var ios = new IOSInitializationSettings();
    var initiSettings = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initiSettings,onSelectNotification: selectNotification);
     _fcm.configure(
          onMessage: (Map<String, dynamic> message) async {
            print("onMessage: $message");

            showNotification(message);
        },
        onLaunch: (Map<String, dynamic> message) async {
            print("onLaunch: $message");
           showNotification(message);
        },
        onResume: (Map<String, dynamic> message) async {
            print("onResume: $message");
            showNotification(message);
          
        },
      );
  }
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, 
        fontFamily: 'Poppins'
      ),
    debugShowCheckedModeBanner: false,
   
    home: LoginPage(),
    );
  }
}

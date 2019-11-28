import 'dart:async';
import 'dart:typed_data';
import 'package:SNBizz/src_code/bridge.dart';
import 'package:SNBizz/src_code/static.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


void main() {
  runApp(new AppStart());
}

class AppStart extends StatefulWidget {
  @override
  _AppStart createState() => _AppStart();
}

class _AppStart extends State<AppStart> {
final FirebaseMessaging _fcm = FirebaseMessaging(); //for notification 
 FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


  Future<dynamic> selectNotification(String payload){
      return showDialog(
                context: context,
                builder: (context) => AlertDialog(
                        content: new Text('$payload'),
                        title: Text('aa'),
                ),
            );
    }

    //vibration pattern

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

//setting up notification channel
      var android = new AndroidNotificationDetails('channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.High,importance: Importance.Max
          ,vibrationPattern: vibrationPattern
      );
      var iOS = new IOSNotificationDetails();
      var platform = new NotificationDetails(android, iOS);
      await flutterLocalNotificationsPlugin.show(0, 'S.N. Business', message['notification']['body'], platform,payload: message['data']['body']);
    }
@override
  void initState()  {
    super.initState();    

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings("@mipmap/launcher_icons");
    var ios = new IOSInitializationSettings();
    var initiSettings = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initiSettings,onSelectNotification: selectNotification);
     _fcm.configure(
          onMessage: (Map<String, dynamic> message) async {
            print("onMessage: $message");
            setState(() {
              StaticValue.shownotificationReceived = true;
            });
            if(message.toString().contains("Task")){
              setState(() {
                StaticValue.Tasknotification = true;
              });
            }
            if(message.toString().contains("Document")){
              setState(() {
                StaticValue.Documentnotification = true;
              });
            }
            showNotification(message);
        },
        onLaunch: (Map<String, dynamic> message) async {
            print("onLaunch: $message");
            setState(() {
              StaticValue.shownotificationReceived = true;
            });
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
//checkFirstSeen();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, 
        fontFamily: 'Poppins'
      ),
    debugShowCheckedModeBanner: false,
     

     home: Bridge(), //navigate to tutorial or login page
     );
  }
}

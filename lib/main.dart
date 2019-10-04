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
 
 Future<void> getnotified() async {
      var pendingNotificationRequest = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
 }

  Future selectNotification(String payload){
      showDialog(
                context: context,
                builder: (context) => AlertDialog(
                        content: new Text('$payload'),
                        title: Text('aa'),
                ),
            );
    }

    showNotification(Map<String,dynamic> message) async {
      var android = new AndroidNotificationDetails('channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.High,importance: Importance.Max
      );
      var iOS = new IOSNotificationDetails();
      var platform = new NotificationDetails(android, iOS);
      await flutterLocalNotificationsPlugin.show(0, 'S.N. Business', 'asdasdasd', platform,payload: 'asdasdasd');
    }
@override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    getnotified();
    var android = new AndroidInitializationSettings("@mipmap/ic_launcher");
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
        primarySwatch: Colors.deepPurple
      ),
    debugShowCheckedModeBanner: false,
   
    home: LoginPage(),
    );
  }
}

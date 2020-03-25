import 'dart:io';

import 'package:SNBizz/src_code/privacy.dart';
import 'package:SNBizz/src_code/profile.dart';
import 'package:SNBizz/src_code/report.dart';
import 'package:SNBizz/src_code/static.dart';
import 'package:SNBizz/src_code/tutorial.dart';
import 'package:SNBizz/src_code/webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:url_launcher/url_launcher.dart';
import 'contact.dart';
import 'invoice.dart';
import 'login.dart';

class Nav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NavBar();
}

class NavBar extends State<Nav> {


        final storage = new FlutterSecureStorage();

        //removing values from the storage
        removeStaticValue(){
   StaticValue.orgName=null;
   StaticValue.logo=null;
   StaticValue.userRowstamp=null;
   StaticValue.orgRowstamp=null;
   StaticValue.upcomingMeetingsCount= "-"; 
    StaticValue.meetingTime = "- - -";
  StaticValue.activeTaskcount = "-";
  StaticValue.taskName = "- - -" ;
  StaticValue.totalPaymentDue = "-";
  StaticValue.lastInvoiceDate = "- - -";
  StaticValue.uploadsToday = "-";
  StaticValue.uploadedDate = "- - -";
   StaticValue.wasloggedout = true;
   StaticValue.orgUserId = null;
        }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: 
      ListView(
        
        children: <Widget>[

        Container(
          height: size.height/3,
          width: size.width,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFFAE8E8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
               Image
               (image: AssetImage("assets/snbizlogo.png"), 
               height: size.height/7,
               width: 140),
                                Padding(padding: EdgeInsets.only(top: 5),),
                                
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
               
                Text(
                  "SN Business Solutions",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 20.0),
                ),
                Text(
                  "Pvt. Ltd",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16.0),
                ),
                Text("Taking business to new heights", style: TextStyle(fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal, fontSize: 12,),),
                
              ],
            ),
              ])
          ),
        ),
       
       Center(
                child: GestureDetector(
                   onTap: () {
                Navigator.push(context,
CupertinoPageRoute(builder: (context) => Profile()));
              },
                                  child: Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: new BoxDecoration(
                            color: const Color(0xFF9C38FF),
                            
                             borderRadius: new BorderRadius.circular(5.0),
                    ),
                    
                  child:Row(
                   

                    children: <Widget>[
                      
                                        Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 24.0,
                          
                        ),
                   Expanded(
                    
                    child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(StaticValue.orgName.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal)),
                  ),
                                      
                   ),
          
                    ])),
                ),
       ),
        
       
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
          child: ListTile(
              title: Row(
                children: <Widget>[
                   Icon(
      Icons.info_outline,
      color: Colors.black,
      size: 24.0,
      
    ),
                  
                  
    Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                   Text('About Us',
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal)),
                  
                ],
              ),
              onTap: () {
                Navigator.push(context,
                   CupertinoPageRoute(builder: (context) => WebView()));
    
              }),
        ),
   Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
          child: ListTile(
              title: Row(
                children: <Widget>[
                   Icon(
      Icons.inbox,
      color: Colors.black,
      size: 24.0,
      
    ),             
    Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                   Text('Invoice',
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal)),
                  
                ],
              ),
              onTap: () {
                Navigator.push(context,
                   CupertinoPageRoute(builder: (context) => Invoice()));
    
              }),
        ),
        
       
      
Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
          child: ListTile(
              title: Row(
                children: <Widget>[
                   Icon(
      Icons.report,
      color: Colors.black,
      size: 24.0,
      
    ),
                  
                  
    Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                   Text('Report',
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal)),
                  
                ],
              ),
              onTap: () {
                Navigator.push(context,
                   CupertinoPageRoute(builder: (context) => Report()));
    
              }),
        ),

        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
          child: ListTile(
              title: Row(
                children: <Widget>[
                   Icon(
      Icons.video_label,
      color: Colors.black,
      size: 24.0, 
    ),             
    Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                   Text('Overview',
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal)),
                  
                ],
              ),
              onTap: () {
                   Navigator.of(context).push(new CupertinoPageRoute<Null>(
                       builder: (BuildContext context) {
                       return new Tutorial();
                      },
                      fullscreenDialog: true));
    
              }),
        ),
         Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
          child: ListTile(
              title: Row(
                children: <Widget>[
                  Icon(
      Icons.phone,
      color: Colors.black,
      size: 24.0,
      
    ),
    Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                  
                    Text('Contact',
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal)),
                  
                ],
              ),
              onTap: () {
                Navigator.push(context,
                   CupertinoPageRoute(builder: (context) => Contact()));
               }),
        ),

        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
          child: ListTile(
              title: Row(
                children: <Widget>[
                 Icon(
      Icons.compare_arrows,
      color: Colors.black,
      size: 24.0,
      
    ),
                  
                  Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                  
                    Text('Logout',
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal)),
                  
                ],
              ),

            //log out
              onTap: () async {
                var appDir = (Directory.systemTemp.path);
                new Directory(appDir).delete(recursive: true);
                await storage.delete(key: "Password"); //deletes pass word from storage
                await storage.delete(key: "fcmtoken");//deletes fmtocken from storage
                removeStaticValue(); //removing static value
                 
               Navigator
        .of(context)
        .pushReplacement(new CupertinoPageRoute(builder: (BuildContext context) {
      return new LoginPage();
    }));
                 
               
              }),
        ),
        
        Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,

          children: <Widget>[
        Row(
         
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 0, 0),
              child: InkWell(
                splashColor: Colors.red,
                onTap: () => launch(StaticValue.facebookurl ),
                child: Image(
                  image: new AssetImage("assets/facebook.png"),
                  height: 30.0,
                  width: 30.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 18, 0, 0),
              child: InkWell(
                splashColor: Colors.blue,
                onTap: () => launch(StaticValue.whatsapp), 
                child: Image(
                  image: new AssetImage("assets/whatsapp.png"),
                  height: 33.0,
                  width: 33.0,
                ),
                
              ),
            ),
           
          ],
        ),
       
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
             height: 0.5,
             margin: EdgeInsets.only(left: 20, right: 40),
              color: Color(0xFFA19F9F),
            
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
        InkWell(
          onTap:(){
            Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => PrivacyWebView()));
          },child: Center(
           
                child:Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Privacy Policy |Terms of Use"),
                ),
              
            ))

      ]),
      ])
    );
  }


  
}

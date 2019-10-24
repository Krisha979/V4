import 'dart:ui' as prefix0;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ContactState();
  }

}

class ContactState extends State<Contact>{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
      ),
      body:
        Container(
                 color:Color(0XFFF4EAEA),
                 height: size.height,
                 width: size.width,
                margin: EdgeInsets.all(15),

            child: Container(
              
              decoration: BoxDecoration(
                color: Colors.white,
              boxShadow: [
                          BoxShadow(
                                 blurRadius: 4.0,
                                 color: Colors.black.withOpacity(0.5),
                                 offset: Offset(0.0, 0.5),
                               ),
                              ],
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
               child: Column(
                
                children: <Widget>[
                   Text("Contact Info", style: TextStyle(fontWeight: FontWeight.bold, 
                fontSize:20, color: Color(0xFF665959) ),
                ),
                  
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text('5TH FLOOR, NEWA NUGA BUILDING', style:TextStyle(color: Colors.black, 
                fontWeight: FontWeight.normal, fontSize: 17)),
                Text('OM BAHAL-23,KATHMANDU', style:TextStyle(color: Colors.black, 
                fontWeight: FontWeight.normal, fontSize: 17)),  
                Text('P.O. BOX 9893', style:TextStyle(color: Colors.black, 
                fontWeight: FontWeight.normal, fontSize: 17)),
                InkWell(
                                  child: Text('+977 9801042730', style:TextStyle(color: Colors.black, 
                  fontWeight: FontWeight.normal,fontSize: 17)),
                  onTap: 
                  () => launch("tel:+977 9801042730" ),
                ),
                Text('INFO@SNBIZNEPAL.COM', style:TextStyle(color: Colors.black, 
                fontWeight: FontWeight.normal, fontSize: 17))
              ],)
                ])
            ),
      ),
    );
  }




}

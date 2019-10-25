

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
                color:Color(0xffd6d6d6),
              boxShadow: [
                          BoxShadow(
                                 blurRadius: 4.0,
                                 color: Colors.black.withOpacity(0.5),
                                 offset: Offset(0.0, 0.5),
                               ),
                              ],
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.fromLTRB(10, 40, 10, 20),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                
                children: <Widget>[
                   Text("Contact Info", style: TextStyle(fontWeight: FontWeight.bold, 
                fontSize:22, color: Color(0xFF665959) ),
                ),
              Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
              Flexible(
                              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 
                  children: <Widget>[
                    Text(
                                    "Address",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFFA19F9F)),
                                  ),
                  Text('5TH FLOOR, NEWA NUGA BUILDING', style:TextStyle(fontSize: 18,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal),),
              
                Text('OM BAHAL-23,KATHMANDU', style:TextStyle(fontSize: 18,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal)),  
                Text('P.O. BOX 9893', style:TextStyle(fontSize: 18,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal)),
                InkWell(
                                  child: Text('+977 9801042730', style:TextStyle(fontSize: 18,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal,
                                        color: const Color(0xFF9C38FF),)),
                  onTap: 
                  () => launch("tel:+977 9801042730" ),
                ),
                Text('INFO@SNBIZNEPAL.COM', style:TextStyle(fontSize: 18,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal))
              ],)
               )])
            ),
      ),
    );
  }




}

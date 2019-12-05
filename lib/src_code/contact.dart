

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
        title: Text("Contact",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
          backgroundColor: const Color(0xFF9C38FF),),
      
      body:
      //color:Color(0XFFF4EAEA),
        Wrap(
                  children: <Widget>[ Container(
                   color:Color(0XFFFFFF),
                   height: size.height,
                   width: size.width,
                  margin: EdgeInsets.all(15),

              child: Column(
                children: <Widget>[
           Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                 Image
                 (image: AssetImage("assets/snbizlogo.png"), 
                 height: 180,
                 width: 180),
                                  Padding(padding: EdgeInsets.only(top: 5),),
                                  
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 
                  Text(
                    "SN Business Solutions",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 18.0),
                  ),
                  Text(
                    "Pvt. Ltd",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 16.0),
                  ),
                  Text("Taking business to new heights", style: TextStyle(fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal, fontSize: 14,),),
                  
                ],
              ),
                ]),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
               
                  Text("Contact Information",
                  
                  
                   style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF665959),
                                    fontWeight: FontWeight.bold)),

                 Padding(
                  padding: EdgeInsets.all(10),
                ),

                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color:Color(0xFFFFBF4F4),
                    borderRadius: BorderRadius.circular(10)
                    
                  // boxShadow: [
                  //             BoxShadow(
                  //                    blurRadius: 4.0,
                  //                    color: Colors.black.withOpacity(0.5),
                  //                    offset: Offset(0.0, 0.5),
                  //                  ),
                  //                 ],
                  ),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.fromLTRB(15, 15, 10, 15),
                   child: Column(
                     //mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: <Widget>[
                     Text(
                                        "Address",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF989896)),
                                      ),
                      Text('5TH FLOOR, NEWA NUGA BUILDING', style:TextStyle(fontSize: 16,
                       color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal),),
                  
                    Text('OM BAHAL-23,KATHMANDU', style:TextStyle(fontSize: 16,
                     color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal)),  
                    Text('P.O. BOX 9893', style:TextStyle(fontSize: 16,
                     color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w500)),
                                            Padding(
                                              padding: EdgeInsets.all(5),
                                            ),
                                            Text(
                                        "Contact",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF989896)),
                                      ),
                                        InkWell(
                                      child: Text('+977 9801042730', style:TextStyle(fontSize: 16,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            color: const Color(0xFF9C38FF),)),
                      onTap: 
                      () => launch("tel:+977 9801042730" ), //auto call if user tap on the number
                    ),
                    Text('INFO@SNBIZNEPAL.COM', style:TextStyle(fontSize: 16,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black))
                    ]),
                    
                  
                    
                   

                ),
                
            
          
               
                 ]),
       ),
                  ]),
    );
  }




}

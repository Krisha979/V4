import 'package:flutter/material.dart';
import 'package:snbiz/src_code/Summary.dart';
import 'package:snbiz/src_code/allnotification.dart';
import 'package:snbiz/src_code/invoice.dart';
import 'package:snbiz/src_code/page.dart';

class Nav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NavBar();
}

class NavBar extends State<Nav> {
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(children: <Widget>[
        Container(
          height: size.height/2.96,
          width: size.width,
          child: DrawerHeader(

            
            decoration: BoxDecoration(
               color: Color(0xFFFAE8E8),

            ),

              child: Column(
               // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image(
                    image: new AssetImage("assets/logo.jpg"),
                    height: 120.0,
                    width: 120.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Text(
                    "SN Business Solutions",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18.0),
                  ),
                  Text(
                    "Pvt. Ltd",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                ],
              ),
            
          ),
        ),
       
        
        Container(
          padding: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
          child: ListTile(
              title: Row(
                children: <Widget>[
                    Image(
                  image: new AssetImage("assets/profile.png"),
                 
                ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                  ),
                  Text('Profile', style: TextStyle(fontSize: 17, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal),),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => MainPage()));
              }),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
          child: ListTile(
              title: Row(
                children: <Widget>[
                    Image(
                  image: new AssetImage("assets/snbiz.png"),
                 
                ),
                 
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text('About SN Business',style: TextStyle(fontSize: 17, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal)),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllNotification()));
              }),
        ),

        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
          child: ListTile(
              title: Row(
                children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 10),
                     child: Image(
                  image: new AssetImage("assets/logout.png"),
                 // height: 30.0,
                  //width: 30.0,
                ),
                   ),
                
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text('Logout',style: TextStyle(fontSize: 17, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal)),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Summary()));
              }),
        ),
       
       

        Row(
         // crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.start,
         
          children: <Widget>[
            
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
              child: InkWell(
                splashColor: Colors.red,
                onTap: () {},
                child: Image(
                  image: new AssetImage("assets/facebook.png"),
                  height: 30.0,
                  width: 30.0,
                ),
              ),
            ),
           
            Padding(
             padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: InkWell(
                splashColor: Colors.blue,
                onTap: () {},
                child: Image(
                  image: new AssetImage("assets/whatsapp.png"),
                  height: 35.0,
                  width: 35.0,
                ),
              ),
            ),
            Padding(
             padding: const EdgeInsets.fromLTRB(20,30, 0, 0),
              child: InkWell(
                splashColor: Colors.red,
                child: Image(
                  image: new AssetImage("assets/gmail.png"),
                  height: 35.0,
                  width: 35.0,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 30),
          
        ),
        
        Divider(
color: Color(0xFFC4C4C4),
        ),
Padding(
          padding: EdgeInsets.only(top: 20),
          
        ),
        
        Center(child: Text("Privacy Policy | Terms of Use"))
      ]
      ),
    );
  }
}
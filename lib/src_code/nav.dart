import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:snbiz/src_code/contact.dart';
import 'package:snbiz/src_code/login.dart';
import 'package:snbiz/src_code/privacy.dart';
import 'package:snbiz/src_code/profile.dart';
import 'package:snbiz/src_code/static.dart';
import 'package:snbiz/src_code/webview.dart' ;
import 'package:url_launcher/url_launcher.dart';


 

class Nav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NavBar();
}

class NavBar extends State<Nav> {
        final storage = new FlutterSecureStorage();
        removeStaticValue(){
  // StaticValue.orgId==null;
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
 //  StaticValue.meetingstatusId=3;
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
                Text("Taking business to new height", style: TextStyle(fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal, fontSize: 12,),),
                
              ],
            ),
              ])
          ),
        ),
       
       Center(
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: new BoxDecoration(
                          color: const Color(0xFF9C38FF),
                          
                           borderRadius: new BorderRadius.circular(5.0),
                  ),
                  
                child:Row(
                  children: <Widget>[
                 Expanded(
                                    child: Center(
                                      child: Text(StaticValue.orgName.toString(),
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal)),
                                    ),
                 ),
          
                  ])),
       ),
        
        Container(
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
          child: ListTile(
              title: Row(
                children: <Widget>[
                  
                
                    Icon(
      Icons.person,
      color: Colors.black,
      size: 24.0,
      
    ),
              
                Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                  
                    Text(
                      'Profile',
                      style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal),
                    ),
                  
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              }),
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
                   Text('About SN Business',
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal)),
                  
                ],
              ),
              onTap: () {
               
                //launch('https://snbiznepal.com');
                Navigator.push(context,
                   MaterialPageRoute(builder: (context) => WebView()));
    
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
                  
                    Text('Contact List',
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal)),
                  
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Contact()));
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
              onTap: () async {
                 await storage.delete(key: "Password"); 
                // storage.write(key:"Password",value: 
                 //'        ');
                 // await storage.delete(key: "Email");
                 removeStaticValue();
                 
               Navigator
        .of(context)
        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
      return new LoginPage();
    }));
                 
                //authenticationBloc.dispatch(LoggedOut()); Navigator.pop(context); Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
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
       
        Container(
           height: 1,
           margin: EdgeInsets.only(left: 20, right: 20),
            color: Colors.black,
          
        ),
        Padding(
          padding: EdgeInsets.only(top: 25),
        ),
        InkWell(
          onTap:(){
            Navigator.push(context,
                     MaterialPageRoute(builder: (context) => PrivacyWebView()));
          },child: Center(child: Text("Privacy Policy | Terms of Use")))
      ]),
        
      ])
    );
  }

  
}

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:snbiz/src_code/tutorial.dart';

import 'login.dart';
class Bridge extends StatefulWidget {
  @override
  BridgeState createState() => BridgeState();
}

class BridgeState extends State<Bridge> {
  final storage = new FlutterSecureStorage();
  void initState(){
  super.initState();
  getfromstorage();   //function call
   
}

// if user login for first time the tutorial page is open and firstlogin is set false
//while if the user is already logged in the login page in opened. 
Future<Null> getfromstorage() async {  
var firstlogin = await storage.read(key:"Login");
if(firstlogin == 'false'){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context)=> LoginPage()));
            }
else if(firstlogin == null){
              await storage.write(key: "Login", value: 'false');
            Navigator.push(context, 
            MaterialPageRoute(builder: (context)=> Tutorial()));

}
            else{
            await storage.write(key: "Login", value: 'false');
              Navigator.push(context, 
            MaterialPageRoute(builder: (context)=> Tutorial()));
            }
}
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width ,
                  height: size.height,
                  decoration:new BoxDecoration(
                    gradient: new LinearGradient(colors:[
                      const Color(0xFF9C38FF),
                      const Color(0xFF8551F8),
                    ],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    stops: [0.0,100.0],
                   ),
                  ),
        
      ),
      
      
    );
  }
}
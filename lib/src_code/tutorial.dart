import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snbiz/src_code/page.dart';

class Tutorial extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    
    return TutorialState();
  }


}

class TutorialState extends State<Tutorial>{
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

              child: FlatButton(
                child: Text("Skip"),
                onPressed: (){
                   Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => MainPage()));
                },
              ),

  ),


);
  }
}
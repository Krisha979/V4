import 'package:flutter/material.dart';

class Documents extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("All Documents"),
      ),
    body: SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,


        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8.0),
              width: size.width/5,
            height: size.height/5,


            ),

            Container(

            ),
            Container(

            ),
            Container(

            ),

            Container(
              
            )
          ],
        ),
        
      ),
    )
      
    );

  }

}
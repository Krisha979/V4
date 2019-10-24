import 'package:flutter/material.dart';
import 'package:snbiz/src_code/profile.dart';
import 'package:snbiz/src_code/static.dart';
import 'nav.dart';

import 'meeting.dart' as second;
import 'allnotification.dart' as third;
//import 'setting.dart' as fourth;
import 'home.dart' as first;

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(
      vsync: this,
      length: 3,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<bool> _onBackPressed(){
    return showDialog( 
      context: context,
       barrierDismissible: false,
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return AlertDialog(
          
          title: Center(
            child: Text(
              "Do you want to exit?", style: TextStyle(fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),
              )
              ),
          actions: <Widget>[
            Container(
             height: size.height/10,
              width: size.width/1.9,
             
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
            
            
               Container(
                height: 35,
                width: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                     color: Color(0xFFCEC0C0),
                     
                ),
           
                child: RaisedButton(
                  child: Text("Yes", style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal, 
                    fontStyle: FontStyle.normal,fontSize: 16),),

                  //onPressed: ()=>Navigator.pop(context,true), 
                  
                  onPressed: (){
                    Navigator.pop(context, true);
                    Navigator.pop(context, true);
                    
                  //  Navigator.pop(context);
                  },
                   
                  color:  Color(0xFFCEC0C0),
                    shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
                    ),
                ),
              ),
            
           
               Container(
                 height:35,
                width: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                     color: Color(0xFFCEC0C0),
                ),
                child: RaisedButton(
                  child: Text("No", style: TextStyle(color: Colors.black, fontSize: 16,
                   fontWeight: FontWeight.normal, fontStyle: FontStyle.normal),),
                   color:  Color(0xFFCEC0C0),
                   shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
        
),
                  onPressed: ()=>Navigator.pop(context,false)

                ),
              ),
          
            ],
            ),
            ),
             ],
        );
    }
    );
    }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(

      onWillPop: _onBackPressed,

          child: Scaffold(
        appBar: AppBar(
            //centerTitle: true,
            title: Text(StaticValue.orgName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
            backgroundColor: const Color(0xFF9C38FF),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      StaticValue.logo,
                    ),
                  ),
                ),
              )
            
            ]
            ),
        drawer: Nav(),
        body: new TabBarView(
          controller: controller,
          children: <Widget>[
            new first.Home(),
            new second.Meeting(),
            new third.AllNotification(),
           
          ],
        ),
        bottomNavigationBar: new Material(
          color: Color(0xFFBF9b38ff),
          child: Container(
            height: size.height / 13,
            child: TabBar(
              controller: controller,
              tabs: <Tab>[
                new Tab(
                  icon: new Icon(
                    Icons.home,
                    size: 25,
                  ),
                //  text: "Home",
                ),
                new Tab(
                  icon: new Icon(Icons.people, size: 25),
                  //text: "Meeting",
                ),
                new Tab(
                  icon: new Icon(Icons.notifications, size: 25),
                //  text: "Notification",
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'dart:io';

import 'package:SNBizz/src_code/profile.dart';
import 'package:SNBizz/src_code/static.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'nav.dart';
import 'meeting.dart' as second;
import 'allnotification.dart' as third;
import 'home.dart' as first;

class MainPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

//  static final myTabbedPageKey = new GlobalKey<MainPageState>();

  //tab controller
  @override
  void initState() {
    super.initState();
    StaticValue.controller = new  TabController(
      vsync: this,
      length: 3,
    );
  }

  @override
  void dispose() {
    StaticValue.controller.dispose();
    super.dispose();
  }
//back press handle
  Future<bool> _onBackPressed(){
    return showDialog( 
      context: context,
       barrierDismissible: false,
      builder: (BuildContext context) {
       // Size size = MediaQuery.of(context).size;
        return AlertDialog(
          
          title: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 15),
             child: Column(

                      children: <Widget>[


                Center(
                child: Text(
                  "Do you want to exit?", style: TextStyle(fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, fontSize: 17),
                  )
                  ),
            Padding(
              padding: EdgeInsets.only(top: 14,bottom: 0,right: 0,left: 0),
            ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                            height: 40,
                            width: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                                 color: Color(0xFFCEC0C0),

                            ),

                            child: RaisedButton(
                              child: Text("Yes", style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.normal,fontSize: 16),),

                      onPressed: (){
                                exit(0);
                      
                      },

                      color:  Color(0xFFCEC0C0),
                        shape: RoundedRectangleBorder(
             borderRadius: new BorderRadius.circular(10.0),
                        ),
                  ),
                ),
                    ),

                Padding(padding: EdgeInsets.all(15)),


                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                           height:40,
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
                    ),


                  ],
                  ),




                      ])),
          )
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
          
          // here the desired height
          
            appBar: AppBar(
      
              title: Text(StaticValue.orgName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
              backgroundColor: const Color(0xFF9C38FF),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                         CupertinoPageRoute(builder: (context) => Profile()));
                    },
                    child: CircleAvatar(
                      radius: 19,
                      backgroundImage: NetworkImage(
                        StaticValue.logo,
                      ),
                    ),
                  ),
                )
              
              ]
              
          
             ),
        drawer:  Nav(),//navigation drawer
        body: new TabBarView( 
          //tab bar view
          controller: StaticValue.controller,
          children: <Widget>[
            new first.Home(),
            new second.Meeting(),
            new third.AllNotification(),
           
          ],
        ),
        bottomNavigationBar: new Material(
          color: Color(0xFFBF9b38ff),
          child: Container(
            height: size.height / 14,
            child: TabBar(
              unselectedLabelColor: Colors.white70,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.all(1.0),
              indicatorColor: Colors.white,
              controller: StaticValue.controller,
              tabs: <Tab>[
                new Tab(
                  icon: new Icon(
                    Icons.home,
                    size: 30,
                  ),
             
                ),
                new Tab(
              
                  icon: new Icon(
                    Icons.alarm,
                    size: 30,
                  ),
                 
                ),
                StaticValue.shownotificationReceived == true ?
                new Tab(
                  icon: new Stack(
                      children: <Widget>[
                        new Icon(Icons.notifications),
                        new Positioned(
                          right: 0.0,
                          child: new Icon(Icons.brightness_1, size: 10,
                              color: Color(0xFFB50000)),
                        )
                      ]
                  ),
                ) : new Tab(
                  icon: new Icon(Icons.notifications,size: 30),),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
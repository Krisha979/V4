
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:snbiz/src_code/login.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:snbiz/src_code/page.dart';
import 'package:snbiz/src_code/static.dart';

class Tutorial extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TutorialState();
  }
}

class TutorialState extends State<Tutorial>  with SingleTickerProviderStateMixin {
  static List<Widget> imageList = [];
  static Size size;
   //bool tutorialFromNav=false;
   int _current=0;
     Future<bool> _onBackPressed() async {
        exit(0);
      }

static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }


//to create widget

 Future<List<Widget>> listwidget()async {
                  imageList.clear();
     
                  var widget1 =  Wrap(
                    children: <Widget>[
                    new Container(
                      padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
                     width: size.width,

             child: Column(
               children: <Widget>[

                                         Center(
                                           child: Image(image: AssetImage("assets/intro4.png"),

                     ),
                                         ),

               ]
             )
                    )
                    ]
                  );

                  var widget2 =  Wrap(
                      children: <Widget>[
                        new Container(

                            width: size.width,
                            padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),


                            child: Column(
                                children: <Widget>[

                                  Center(
                                    child: Image(image: AssetImage("assets/intro1.png"),

                                    ),
                                  ),

                                ]
                            )
                        )
                      ]
                  );
                  var widget3 =  Wrap(
                      children: <Widget>[
                        new Container(
                            width: size.width,
                            padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),

                            child: Column(
                                children: <Widget>[

                                  Center(
                                    child: Image(image: AssetImage("assets/transparent.png"),

                                    ),
                                  ),

                                ]
                            )
                        )
                      ]
                  );

                    var widget4 =  Wrap(
                      children: <Widget>[
                        new Container(
                            width: size.width,
                            padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),

                            child: Column(
                                children: <Widget>[

                                  Center(
                                    child: Image(image: AssetImage("assets/intro2.png"),

                                    ),
                                  ),

                                ]
                            )
                        )
                      ]
                  );

                    var widget5 =  Wrap(
                      children: <Widget>[
                        new Container(
                            width: size.width,
                            padding: EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),

                            child: Column(
                                children: <Widget>[

                                  Center(
                                    child: Image(image: AssetImage("assets/intro3.png"),

                                    ),
                                  ),

                                ]
                            )
                        )
                      ]
                  );

                  

      //adding widget to list
            imageList.add(widget1);
            imageList.add(widget2);
            imageList.add(widget3);
            imageList.add(widget4);
            imageList.add(widget5);
            

      

        return imageList;

        }

  @override
  Widget build(BuildContext context) {
    Size size1 = MediaQuery.of(context).size;
    size = size1;
 listwidget();
return WillPopScope(
   onWillPop: _onBackPressed,   
  child:   Scaffold(
  
    body: Stack(
  
      children: <Widget>[
  
         Container(
  
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
  
  
  
  child: Column(
  
  
  
                     crossAxisAlignment:CrossAxisAlignment.end,
  
                    children: <Widget>[
  
                      StaticValue.tutorialFromNav == false?
  
                      Padding(
  
                      padding: const EdgeInsets.only(top: 25, right: 15),
  
                     child: GestureDetector(
  
                       onTap: (){
  
                          Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => MainPage()));
  
                       },
  
                       child: Icon(Icons.close, color: Colors.white))
  
                    ) :
  
                    Container(),
  
              Column(
  
                    children: <Widget>[
  
                       Stack(
  
                        children: <Widget>[CarouselSlider( //carousel slider to slide the widget
  
                          items: imageList,
  
                          height:size.height-100,
  
                          aspectRatio: 16/9,
  
                          viewportFraction: 0.99,
  
                          initialPage: 0,
  
                          enableInfiniteScroll: true,
  
                          reverse: false,
  
                          autoPlay: true,
  
                          enlargeCenterPage: true,
  
                          autoPlayInterval: Duration(seconds: 5),
  
                          autoPlayAnimationDuration: Duration(milliseconds: 2000),
  
                          pauseAutoPlayOnTouch: Duration(seconds: 4),
  
                          scrollDirection: Axis.horizontal,
  
                          onPageChanged: (index) {
  
                            setState(() {
  
                              _current = index;
  
                            });
  
                          },
  
                        ),
  
                          Positioned(
  
                              bottom: 0.0,
  
                              left: 0.0,
  
                              right: 0.0,
  
                              child: Row(
  
                                mainAxisAlignment: MainAxisAlignment.center,
  
                                children: map<Widget>(imageList, (index, url) {
  
                                  return Container(
  
                                    width: 8.0,
  
                                    height: 8.0,
  
                                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
  
                                        decoration: BoxDecoration(
  
                                        shape: BoxShape.circle,
  
                                        color: _current == index ? Colors.white : Color.fromRGBO(0, 0, 0, 0.2)
  
                                    ),
  
                                  );
  
                                }),
  
                              )
  
                          )
  
                        ],
  
                      ),
  
  
  
  
  
                       Row(
  
                          mainAxisAlignment: MainAxisAlignment.end,
  
                          crossAxisAlignment: CrossAxisAlignment.end,
  
                          children: <Widget>[
  
                             
  
                            Column(
  
  
  
                              children: <Widget>[
  
                                  StaticValue.tutorialFromNav == true ?
  
                                GestureDetector(
  
                                  onTap: (){
  
                                  
  
                           Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginPage()));
  
                        
  
                                  },
  
                                                                child: Padding(
  
                                                                  padding: const EdgeInsets.only(right: 15, bottom: 10, top: 10),
  
                                                                  child: Text("Skip",style: TextStyle( fontWeight: FontWeight.bold,
  
                                      color: Colors.white,
  
                                      fontSize: 18.0),),
  
                                                                ),
  
                                ):Container()
  
                              ],
  
                            ),
  
                          ],
  
                        ),
  
                    ],
  
                  ),
  
                    ]
  
                    )
  
  
  
      ),
  
      ]),
  
  ),
);
}
}
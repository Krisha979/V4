
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snbiz/src_code/login.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Tutorial extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    
    return TutorialState();
  }


}

class TutorialState extends State<Tutorial>  with SingleTickerProviderStateMixin {


  static List<Widget> imageList = [];
  static Size size;
   // =  [
  //   //  "assets/tutorial1.png",
  //   //  "assets/tutorial2.png",
  //   //  "assets/tutorial3.png",
  //   //  "assets/tutorial4.png",
  //   //  "assets/tutorial5.png"
    
  // ];
int _current=0;

void initState(){
  super.initState();
  
   
}

static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }



// final List child = map<Widget>(
//   imageList,
//   (index, i) {
//     return Container(
//       margin: EdgeInsets.all(5.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(5.0)),
//         child: Stack(children: <Widget>[
//           Image.network(i, fit: BoxFit.cover, width: 1000.0),
//           Positioned(
//             bottom: 10.0,
//             left: 0.0,
//             right: 0.0,
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                 ),
//               ),
//               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//               child: Text(
//                 'No. $index image',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   },
// ).toList();

 Future<List<Widget>> listwidget()async {
     
                  var widget1 =  Wrap(
                    children: <Widget>[
                    new Container(
                     //height: size.height,
                     width: size.width,
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
               children: <Widget>[
                 
                                         Image(image: AssetImage("assets/transparent.png"),
                    height: size.height,
                    width: size.width
                     ),
                   
               ]
             )
                    )
                    ]
                  );

      


      
            imageList.add(widget1);
            
      

        return imageList;

        }

  @override
  Widget build(BuildContext context) {
    Size size1 = MediaQuery.of(context).size;
    size = size1;
 listwidget();
return Scaffold(
  
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


                  children: <Widget>[

                     
                    CarouselSlider(

                                    items: imageList,
                                   // child,
                                    height:size.height,
                                    //aspectRatio: 16/9,
                                    viewportFraction: 0.99,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    enlargeCenterPage: false,
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

                                        bottom: 10.0,
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
                                                  color: _current == index ? Color.fromRGBO(21, 0, 255, 0.7) : Color.fromRGBO(0, 0, 0, 0.2)
                                              ),
                                            );
                                          }),
                                        )
                                    ),

                    FlatButton(
                      child: Text("Skip"),

                      onPressed: (){
                         Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginPage()));
                      },
                    ),
                  ],
                ),

    ),
    ]),


);
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_pro/carousel_pro.dart';
import 'package:snbiz/Model_code/DashBoardData.dart';
import 'package:snbiz/src_code/createmeeting.dart';
import 'package:snbiz/src_code/invoice.dart';
import 'package:snbiz/src_code/static.dart';
import 'package:snbiz/src_code/task.dart';
import 'package:snbiz/src_code/documents.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:snbiz/src_code/multipleImage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:snbiz/src_code/imagePreview.dart';
import 'package:flutter/services.dart';
import 'file_picker.dart';


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {

  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension="";
  bool _loadingPath = true;
  bool _multiPick = true;
  bool _hasValidMime = true;
  FileType _pickingType=FileType.ANY;
  AnimationController controller;
  Animation<double> animation;
  bool showIndicator = false;
  static List<Widget> widgets = [];
  static Size size;
  
  Future<DashBoardData> getData() async{      
    try{           
      http.Response response = await http.get(
      Uri.encodeFull(StaticValue.baseUrl + "api/DashBoardData?Orgid=" + StaticValue.orgId.toString()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
              }
          );
           var jsonData = json.decode(response.body);
  
  
      var data = DashBoardData.fromJson(jsonData);

     return data;

      }
      catch(e){
        print(e);
        return null;
        }
    }

  void _openFileExplorer() async {
    if (_pickingType != FileType.CUSTOM || _hasValidMime) {
      setState(() => _loadingPath = true);
      try {
        if (_multiPick) {
          _path = null;
          _paths = await FilePicker.getMultiFilePath(
              type: _pickingType, fileExtension: _extension);

              image1();
        } else {
          _paths = null;
          var filePath = FilePicker.getFilePath(
              type: _pickingType, fileExtension: _extension);
          _path = await filePath;

              image1();        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;
      setState(() {
        _loadingPath = false;
        _fileName = _path != null
            ? _path.split('/').last
            : _paths != null ? _paths.keys.toString() : '...';

           //   image1();
                    });
    }
  }

 
 File imageFile;

 String img;

  openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    imageFile = picture;
    img = imageFile.path;
    StaticValue.imgfile = imageFile;
    call();
  }

  TextEditingController _controller = new TextEditingController();

   addpopup() {
     showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
           Size size = MediaQuery.of(context).size;

          return Dialog(
           // shape: RoundedRectangleBorder(
             //   borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: size.height/3.4,
             width: size.width/1.2,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xFFFBF4F4)),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                     // Container(height: 150.0),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        height: size.height/13,
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(5.0)),
                          color: const Color(0xFFFBF4F4),
                        ),
                        child: Center(
                          child: Text("UPLOAD OPTIONS", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)),
                      ),
                      
                    ],
                  ),
                
                 
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[

                       

                          
                       
                          
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                                          child: Image(
                                   image: new AssetImage("assets/file.png"),
                        height: size.height /8,
                        width: size.width/5),
                        
                        onTap: (){
                               _openFileExplorer();
                               Navigator.pop(context);
                               

                        },
                              ),
                              Text("Files"),
                            ],
                          ),

                           Column(
                             children: <Widget>[
                               GestureDetector(
                                                          child: Image(
                                   image: new AssetImage("assets/camera.png"),
                                    height: size.height /8,
                        width: size.width/5
                                   ),
                                   onTap: (){
                                      openCamera(context);
                                        Navigator.pop(context);
                                   },
                                 


                          ),
                          Text("Camera")
                             ],
                           ),
                          

                         

                         /* FloatingActionButton(
                            //child: Icon(Icons.sd_storage),
                            onPressed: () => _openFileExplorer(),
                          ),
                          FloatingActionButton(
                            child: Icon(Icons.camera_alt),
                            onPressed: () {
                              openCamera(context);
                              Navigator.of(context).pop();

                              // To close the dialog
                            },
                          ),*/

                        ],
                        ),
                  
                ],
              ),
            ),
          );
              
          
        
        },
      );
    }

    void image1(){
  if(_paths.isNotEmpty){
     findnames();
    
  }
}
  void findnames(){
      String names = _paths.toString();
      StaticValue.filenames= names.split(',');
                      Navigator.push(context,
    MaterialPageRoute(builder: (context) => MultipleImage(url:_paths )));
  }
  void call() {
    if (img.isNotEmpty) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PreviewImage(url:img)));
    }
  }

  Future<List<Widget>> listwidget()async {

        var widget1 = new Container(
             color:Color(0xffd6d6d6),
             child: Column(
               children: <Widget>[
                 Container(           
                          margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                   padding: EdgeInsets.fromLTRB(20, 25, 25, 25),
                           decoration: new BoxDecoration(
                          color: Colors.white,
                           borderRadius: new BorderRadius.circular(15.0),
                           boxShadow: [
//                           BoxShadow(
//                                  blurRadius: 4.0,
//                                  color: Colors.black.withOpacity(0.5),
//                                  offset: Offset(0.0, 0.5),
//                                ),
                              ],
                           ),

                           child: Column(
                             mainAxisSize: MainAxisSize.max,

                                children: <Widget>[ 
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("All Meetings"),
                                  Text("148"),
                                  Icon(Icons.file_upload),
                                  Text("17th august 2019"),

                                ],
                                

                              ),
                            Image(
                                      image: new AssetImage("assets/new_meeting.png"),
                                      fit: BoxFit.fill,
                            
                              height: size.height/13,
                                    ),
                            ],
                          )
               ],
             ),
        )
               ]
             )
        );
        var widget2 = new Container(

             color:Color(0xffd6d6d6),
             child: Column(
               children: <Widget>[
                 Container(
                   margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                   padding: EdgeInsets.fromLTRB(20, 25, 25, 25),
                           decoration: new BoxDecoration(
                          color: Colors.white,
                           borderRadius: new BorderRadius.circular(15.0),
                           boxShadow: [
//                           BoxShadow(
//                                  blurRadius: 4.0,
//                                  color: Colors.black.withOpacity(0.5),
//                                  offset: Offset(0.0, 0.5),
//                                ),
                              ],
                           ),

                           child: Column(
                             mainAxisSize: MainAxisSize.max,
                                children: <Widget>[ 
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("All Tasks"),
                                  Text("148"),
                                  Icon(Icons.file_upload),
                                  Text("3"),

                                ],
                                

                              ),
                            Image(
                                      image: new AssetImage("assets/new_meeting.png"),
                                      fit: BoxFit.fill,
                                     //width: size.width,
                              height: size.height/13,
                                    ),
                            ],
                          )
               ],
             ),
        )
               ]
             )
        );
        widgets.add(widget1);
        widgets.add(widget2);
        return widgets;
  }


  @override
  void initState() {
    super.initState();

     _controller.addListener(() => _extension = _controller.text);
    controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    animation = Tween(begin: 5.0, end: 18.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
   
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
      listwidget();
  }


final carousel1 = CarouselSlider(
  items: widgets,
   height:400,
  aspectRatio: 16/9,
   viewportFraction: 0.99,
   initialPage: 0,
   enableInfiniteScroll: true,
   reverse: false,
   autoPlay: true,
   enlargeCenterPage: false,
   autoPlayInterval: Duration(seconds: 3),
   autoPlayAnimationDuration: Duration(milliseconds: 2000),
   pauseAutoPlayOnTouch: Duration(seconds: 4),
   scrollDirection: Axis.horizontal,
);


  final carousel2 = Carousel(
    boxFit: BoxFit.cover,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 2000),
    dotSize: 2.0,
    dotIncreasedColor: Color(0xFFFFFFFF),
    dotBgColor: Colors.black.withOpacity(0),
    autoplayDuration: Duration(seconds: 5),
    images: [
      AssetImage(
        'assets/image1.png',
      ),
      AssetImage('assets/image2.png'),
      AssetImage('assets/image3.png'),
      AssetImage('assets/image4.png'),
    ],
    // dotBgColor: Colors.white.withOpacity(1),
  );


  
    
  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFd6d6d6),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white),
                child: Column(
                  children: <Widget>[
                    new Image(
                        image: new AssetImage("assets/img.png"),
                        height: size.height / 4.8,
                        fit: BoxFit.fill,
                        width: size.width),
                  ],
                ),
              ),
              Container(
                //color: Colors.black,

                child: Wrap(children: <Widget>[
                  Container(
                    height: size.height / 2.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    // color: Colors.white,
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                    //color: Colors.black,
                    // width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                InkWell(
                                  splashColor: Colors.red,
                                  onTap: () {
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage()));
                                  },
                                  child: Image(
                                    image: new AssetImage("assets/icon1.png"),
                                    height: size.height / 13,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Text("Tasks"),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                InkWell(
                                  splashColor: Colors.red,
                                  onTap: () {
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => Invoice()));
                                  },
                                  child: Image(
                                    image: new AssetImage("assets/invoice.png"),
                                    height: size.height / 13,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Text("Invoice"),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                InkWell(
                                  splashColor: Colors.red,
                                  onTap: () {
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => Documents()));
                                  },
                                  child: Image(
                                    image:
                                        new AssetImage("assets/Document.png"),
                                    height: size.height / 13,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Text("Documents"),
                                )
                              ],
                            ),
                          ],
                        ),

                        //  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        Divider(
                          color: Colors.grey,
                          height: 50.0,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                InkWell(
                                  splashColor: Colors.red,
                                  onTap: () {
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => Create()));
                                  },
                                  child: Image(
                                    image: new AssetImage("assets/time.png"),
                                    height: size.height / 13,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Text("Set Meetings"),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                InkWell(
                                  splashColor: Colors.red,
                                  onTap: () {
                                     addpopup();
                                  },
                                  child: Image(
                                    image: new AssetImage("assets/icon3.png"),
                                    height: size.height / 13,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Text("Upload"),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              GestureDetector(
                onTap: () {}, // code hack do nothing
                child: Wrap(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(2, 3, 2, 0),
                      height: size.height / 4.6,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: carousel1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    
  }
  
}
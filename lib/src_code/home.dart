import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_pro/carousel_pro.dart';
import 'package:intl/intl.dart';
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
  DashBoardData data;
  String uploadeddate,meetingtime,lastinvoicedate;
  
  
  Future<DashBoardData> getData() async{      
    try{           
      http.Response response = await http.get(
      Uri.encodeFull(StaticValue.baseUrl + "api/OrganizationDashboard?Orgid=" + StaticValue.orgId.toString()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
       // 'Cache-Control': 'no-cache,private,no-store,must-revalidate'

      }
          );
           var jsonData = json.decode(response.body);
  
  
      var data1 = DashBoardData.fromJson(jsonData);
      if(data1 != null){
          setState(() {
        data = data1;
        uploadeddate =  formatTime(data.uploadedDate.toString()) +" "+ formatDateTime(data.uploadedDate.toString()) ;
        lastinvoicedate = formatTime(data.lastInvoiceDate.toString())+" "+ formatDateTime(data.lastInvoiceDate.toString());
        meetingtime = formatTime(data.meetingTime.toString())+" "+ formatDateTime(data.meetingTime.toString());

        StaticValue.upcomingMeetingsCount = data.upcomingMeetingsCount.toString();
        StaticValue.meetingTime = meetingtime;
        StaticValue.activeTaskcount = data.activeTaskcount.toString();
        StaticValue.taskName = data.taskName;
        StaticValue.totalPaymentDue = data.totalPaymentDue.toString();
        StaticValue.lastInvoiceDate = lastinvoicedate;
        StaticValue.uploadsToday = data.uploadsToday.toString();
        StaticValue.uploadedDate = uploadeddate;



      });
      
      }
     return data1;

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
                          child: Text("UPLOAD OPTIONS", style: TextStyle(color: Color(0xFF665959), fontSize: 18, fontWeight: FontWeight.bold),)),
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
        if(StaticValue.upcomingMeetingsCount != null){
         setState(() {
           widgets.clear();
         });


                  var widget1 = new Container(
             color:Color(0xffd6d6d6),
             child: Column(
               children: <Widget>[
                 Container( 
                   height: size.height/4.8,          
                          margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                   padding: EdgeInsets.fromLTRB(20, 12, 25, 5),
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
                             mainAxisSize: MainAxisSize.min,

                                children: <Widget>[ 
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Upcoming Meetings",
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Color(0xFFA19F9F))
                                  ,),
                                  Text(StaticValue.upcomingMeetingsCount,
                                  style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold),),
                                  
                                  Text("Next Meeting",
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Color(0xFFA19F9F))),
                                  Text(StaticValue.meetingTime,
                                  style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold)),

                                ],
                                

                              ),
                            Image(
                                      image: new AssetImage("assets/snbizmeetings.png"),
                                      fit: BoxFit.fill,
                            
                              height: size.height/12,
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
                   height: size.height/4.8,
                   margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                   padding: EdgeInsets.fromLTRB(20, 12, 25, 5),
                           decoration: new BoxDecoration(
                          color: Colors.white,
                           borderRadius: new BorderRadius.circular(15.0),
                           ),

                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                                children: <Widget>[ 
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Active Tasks",
                                   style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Color(0xFFA19F9F))),
                                  Text(StaticValue.activeTaskcount,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  ),),
                                  
                                  Text("Latest Running Task",
                                   style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Color(0xFFA19F9F))),
                                  Text(StaticValue.taskName,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  )
                                  ),
                                ],
                                

                              ),
                            Image(
                                      image: new AssetImage("assets/snbiztasks.png"),
                                      fit: BoxFit.fill,
                                     //width: size.width,
                              height: size.height/12,
                                    ),
                            ],
                          )
               ],
             ),
        )
               ]
             )
        );

          var widget3 = new Container(

             color:Color(0xffd6d6d6),
             child: Column(
               children: <Widget>[
                 Container(
                   height: size.height/4.8,
                   margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                   padding: EdgeInsets.fromLTRB(20, 12, 25, 5),
                           decoration: new BoxDecoration(
                          color: Colors.white,
                           borderRadius: new BorderRadius.circular(15.0),
                           ),

                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                                children: <Widget>[ 
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              
                              Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Text("Uploads Today",
                                      style: TextStyle(fontWeight: FontWeight.bold,
                                          color: Color(0xFFA19F9F))),
                                  Text(StaticValue.uploadsToday.toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                        color: Colors.black),),
                                  Text("Uploaded Date",
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Color(0xFFA19F9F))),
                                  Text(StaticValue.uploadedDate.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.black),),
                                  

                                ],
                                

                              ),
                            Image(
                                      image: new AssetImage("assets/snbizuploads.png"),
                                      fit: BoxFit.fill,
                                     //width: size.width,
                              height: size.height/12,
                                    ),
                            ],
                          )
               ],
             ),
        )
               ]
             )
        );

          var widget4 = new Container(

             color:Color(0xffd6d6d6),
             child: Column(
               children: <Widget>[
                 Container(
                   height: size.height/4.8,
                   margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                   padding: EdgeInsets.fromLTRB(20, 15, 25, 5),
                           decoration: new BoxDecoration(
                          color: Colors.white,
                           borderRadius: new BorderRadius.circular(15.0),
                           ),

                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                                children: <Widget>[ 
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Column(
                               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Last Invoice date",
                                   style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Color(0xFFA19F9F))),
                                  Text(StaticValue.lastInvoiceDate,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                                  
                                  Text("Total Payment Due",
                                   style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Color(0xFFA19F9F))),
                                  Text(StaticValue.totalPaymentDue,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                                ],
                                

                              ),
                            Image(
                                      image: new AssetImage("assets/snbizinvoice.png"),
                                      fit: BoxFit.fill,
                                     //width: size.width,
                              height: size.height/12,
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
        widgets.add(widget3);
        widgets.add(widget4);

        return widgets;

        }
        else{
          setState(() {
            widgets.clear();
          });

            var widget =  Container(
                  child: Center(
                  
                  child: CircularProgressIndicator()

                  )
                );
                widgets.add(widget);
        return widgets;
        }
        
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
  void didChangeDependencies() async{
    super.didChangeDependencies();
     if(data ==null){
       widgets.clear();
       var widget =  Container(
                  child: Center(

                  child: CircularProgressIndicator()

                  )
                );
                widgets.add(widget);
     }
     if(StaticValue.wasloggedout == true || StaticValue.wasloggedout == null){
            data = await getData();
            StaticValue.wasloggedout = false;
     }
    
    size = MediaQuery.of(context).size;
    
    widgets.clear();
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
   autoPlayInterval: Duration(seconds: 5),
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

 String formatDateTime(String date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime format = (dateFormat.parse(date));
    DateFormat longdate = DateFormat("EEEE, MMM d, yyyy");
    date = longdate.format(format);
    return date;
  }
  String formatTime(String time) {
     DateFormat dateFormatremoveT = DateFormat("yyyy-MM-ddTHH:mm:ss");
    DateTime formattedtime = (dateFormatremoveT.parse(time));
    DateFormat longtme = DateFormat.jm();
    time = longtme.format(formattedtime);
    return time.toString();
  }

  
    
  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
           color: Color(0XFFF4EAEA),
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
                        image: new AssetImage("assets/new-dashboard.png"),
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
                    height: size.height / 2.27,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    // color: Colors.white,
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 28),
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
                                    image: new AssetImage("assets/snbiztasks.png"),
                                    height: size.height / 12,
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
                                    image: new AssetImage("assets/snbizinvoice.png"),
                                    height: size.height / 12,
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
                                        new AssetImage("assets/snbizcircledocument.png"),
                                    height: size.height / 12,
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
                                    image: new AssetImage("assets/snbizmeeting.png"),
                                    height: size.height / 12,
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
                                    image: new AssetImage("assets/snbizuploads.png"),
                                    height: size.height / 12,
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
                           height: size.height/4.8,
                        margin: EdgeInsets.fromLTRB(2, 3, 2, 0),
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
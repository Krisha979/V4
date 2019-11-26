import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:snbiz/Model_code/DashBoardData.dart';
import 'package:snbiz/src_code/createmeeting.dart';
import 'package:snbiz/src_code/send-notification.dart';
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

  DashBoardData data;
  String uploadeddate,meetingtime,lastinvoicedate;
  final RefreshController _refreshController = RefreshController();
  var date = DateTime.now().toString();

  //date time format method
  String formatDateTime12(String date) {
    DateFormat dateFormat = DateFormat("yyyy-MM");
    DateTime format = (dateFormat.parse(date));
    DateFormat longdate = DateFormat("MMMM, yyyy");
    date = longdate.format(format);
    return date;
  }

//function to call api
  Future<DashBoardData> getData() async{
    try{
      http.Response response = await http.get(
      Uri.encodeFull(StaticValue.baseUrl +StaticValue.home_url+ StaticValue.orgId.toString()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Cache-Control': 'no-cache,private,no-store,must-revalidate'
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
      //  StaticValue.vATCredit = data.totalPaymentDue.toString();
        StaticValue.lastInvoiceDate = lastinvoicedate;
        StaticValue.uploadsToday = data.uploadsToday.toString();
        StaticValue.uploadedDate = uploadeddate;
        //StaticValue.vATCredit = data.vatCredit;



      });

      }
     return data1;

      }
      catch(e){
        print(e);
        return null;
        }
    }

    //method to open file 

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


//method to open camera
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[

                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close, color: Color(0xFF665959))
                            )
                        ],
                      ),
                     // Container(height: 150.0),
                      Container(
                      //  margin: EdgeInsets.only(top: 15),
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
                                   onTap: ()  {
                                      // openCamera(context);
                                      //   Navigator.pop(context);


                     openCamera(context);


                              Navigator.pop(context);



                                   },



                          ),
                          Text("Camera")
                             ],
                           ),

                        ],
                        ),

                ],
              ),
            ),
          );



        },
      );
    }
//to check the image path is empty or not
    void image1(){
  if(_paths.isNotEmpty){
     findnames();

  }
}
//image uplaod then navigate to another page
  void findnames(){
      String names = _paths.toString();
      StaticValue.filenames= names.split(',');
                      Navigator.push(context,
    CupertinoPageRoute(builder: (context) => MultipleImage(url:_paths )));
  }
  void call() {
    if (img.isNotEmpty) {
      Navigator.push(context,
          CupertinoPageRoute(builder: (context) => PreviewImage(url:img)));
    }
  }


//funnction to create slider widget
  Future<List<Widget>> listwidget()async {

        if(StaticValue.upcomingMeetingsCount != null)  //condition to check meeting count

        {
             setState(() {
               widgets.clear();
             });
             Size staticsize = MediaQuery.of(context).size;

             var widget1 = new Container(
             color: Color(0XFFF4EAEA),
             child: Column(
               children: <Widget>[
                 Container(
                   height: staticsize.height/4.8,
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

                              Flexible(
                                                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Upcoming Meetings",
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,
                                    color: Color(0xFFA19F9F))
                                    ,),
                                    Text(StaticValue.upcomingMeetingsCount,
                                    style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.bold),),

                                    Text("Next Meeting",
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,
                                    color: Color(0xFFA19F9F))),
                                    Text(StaticValue.meetingTime,
                                    style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.bold)),

                                  ],


                                ),
                              ),
                            Image(
                                      image: new AssetImage("assets/snbizmeetings.png"),
                                      fit: BoxFit.fill,

                              height: staticsize.height/12,
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

              color: Color(0XFFF4EAEA),
             child: Column(
               children: <Widget>[
                 Container(
                   height: staticsize.height/4.8,
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

                              Flexible(
                                                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Active Tasks",
                                     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,
                                    color: Color(0xFFA19F9F))),
                                    Text(StaticValue.activeTaskcount,
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                    ),),

                                    Text("Latest Running Task",
                                     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,
                                    color: Color(0xFFA19F9F))),
                                    Text(StaticValue.taskName,
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                    )
                                    ),
                                  ],


                                ),
                              ),
                            Image(
                                      image: new AssetImage("assets/snbiztasks.png"),
                                      fit: BoxFit.fill,
                                    
                              height: staticsize.height/12,
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

              color: Color(0XFFF4EAEA),
             child: Column(
               children: <Widget>[
                 Container(
                   height: staticsize.height/4.8,
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

                              Flexible(
                                                              child: Column(
                              
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Text("Uploads Today",
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,
                                            color: Color(0xFFA19F9F))),
                                    Text(StaticValue.uploadsToday.toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold,
                                          color: Colors.black),),
                                    Text("Uploaded Date",
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,
                                    color: Color(0xFFA19F9F))),
                                    Text(StaticValue.uploadedDate.toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                    color: Colors.black),),


                                  ],


                                ),
                              ),
                            Image(
                                      image: new AssetImage("assets/snbizuploads.png"),
                                      fit: BoxFit.fill,
                                   
                              height: staticsize.height/12,
                                    ),
                            ],
                          )
               ],
             ),
        )
               ]
             )
        );
 String fmfamount ;

//conditioin to if vat credit is null
 if(StaticValue.vATCredit==null){
  fmfamount="0";
}
else{

var money = double.parse(StaticValue.vATCredit);


  FlutterMoneyFormatter fmf = new FlutterMoneyFormatter( //flutter money package for decimal seperator

    amount:money,
    settings: MoneyFormatterSettings(

        thousandSeparator: ',',
        decimalSeparator: '.',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 2,
       
    )
);
if(fmf.output.fractionDigitsOnly.toString().contains("00"))
{
fmfamount = fmf.output.withoutFractionDigits.toString();
}else{
fmfamount = fmf.output.nonSymbol.toString();

}
}
          var widget4 = new Container(

              color: Color(0XFFF4EAEA),
             child: Column(
               children: <Widget>[
                 Container(
                   height: staticsize.height/4.8,
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
                              
                         crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Vat Credit",
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,
                                          color: Color(0xFFFF0000))),
                                          Text(formatDateTime12(date),
                                   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,
                                  color: Color(0xFFA19F9F))),
                                  Text('Rs '+fmfamount,
                                      style: TextStyle(fontWeight: FontWeight.bold,
                                          color: Colors.black, fontSize: 18)),
                                  

                                ],
                              ),
                            Image(
                                      image: new AssetImage("assets/snbizvaticon.png"),
                                      fit: BoxFit.fill,
                                   
                              height: staticsize.height/12,
                                    ),
                            ],
                          )
               ],
             ),
        )
               ]
             )
        );

        widgets.clear();
        //adding widget to list
        widgets.add(widget1);
        widgets.add(widget2);
        widgets.add(widget3);
        widgets.add(widget4);

        return widgets;

        }
  }



//method for widget animation
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

//to check if the code changes evry time it should hit this method
  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
     if(data ==null){
       setState(() {
         widgets.clear();
       });

       var widget =  Container(
                  child: Center(

                 child: Theme(
                                        data: new ThemeData(
                                          hintColor: Colors.white,
                                        ),
                                       child: CircularProgressIndicator(

                                            strokeWidth: 3.0,
                                            backgroundColor: Colors.white
                                        ),

                                      ),

                  )
                );
                widgets.add(widget);
     }
     if(StaticValue.wasloggedout == true || StaticValue.wasloggedout == null){
            data = await getData();
            StaticValue.wasloggedout = false;
     }
   //   staticsize = MediaQuery.of(context).size;
    setState(() {
      widgets.clear();
    });
      listwidget();
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

//date time format
 String formatDateTime(String date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime format = (dateFormat.parse(date));
    DateFormat longdate = DateFormat("EEEE, MMM d, yyyy");
    date = longdate.format(format);
    return date;
  }
  //time format
  String formatTime(String time) {
     DateFormat dateFormatremoveT = DateFormat("yyyy-MM-ddTHH:mm:ss");
    DateTime formattedtime = (dateFormatremoveT.parse(time));
    DateFormat longtme = DateFormat.jm();
    time = longtme.format(formattedtime);
    return time.toString();
  }


  int _current=0;
  @override

  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
 //   staticsize = size;

    return Scaffold(

       body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        //page refresh
        onRefresh: () async {


      await Future.delayed(Duration(seconds: 2));
      setState(() async{
        await getData();
        _refreshController.refreshCompleted(); //page refresh
        listwidget();

    

      });



    },
         child: SingleChildScrollView(
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
                          image: new AssetImage("assets/bannerpicturehome.jpg"),
                          height: size.height / 4.8,
                          fit: BoxFit.cover,
                          width: size.width),
                    ],
                  ),
                ),
                Container(
                 child: Wrap(children: <Widget>[
                    Container(
                      height: size.height / 2.27,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                   
                      padding: EdgeInsets.fromLTRB(30, 30, 30, 28),
                     
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
                                      StaticValue.Tasknotification=false;
                                      Navigator.push(context, CupertinoPageRoute(builder: (context) => TaskPage()));
                                    },

                                    child:
                                    StaticValue.Tasknotification == true ?
                                    Image(

                                      image: new AssetImage("assets/snbiztasks_notification.png"),
                                      height: size.height / 12 ,


                                    ): Image(
                                      image: new AssetImage("assets/snbiztasks.png"),
                                      height: size.height / 12 ,
                                    ),
                                  ),

                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Text("Tasks",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black54)),
                                  )
                                ],
                              ),

                               Column(
                                children: <Widget>[
                                  InkWell(
                                    splashColor: Colors.red,
                                    onTap: () {
                                      StaticValue.Documentnotification=false;
                                       Navigator.push(context,CupertinoPageRoute(builder: (context) => Documents()));
                                    },
                                    child:
                                    StaticValue.Documentnotification == true ?
                                    Image(
                                      image:
                                          new AssetImage("assets/snbizcircledocument_notification.png"),
                                      height: size.height / 12,
                                    ): Image(
                                      image:
                                      new AssetImage("assets/snbizcircledocument.png"),
                                      height: size.height / 12,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Text("Documents",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black54)),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  InkWell(
                                    splashColor: Colors.red,
                                    onTap: () {
                                       Navigator.push(context, CupertinoPageRoute(builder: (context) => SendNotification()));
                                    },
                                    child: Image(
                                      image: new AssetImage("assets/snbiznotification.png"),
                                      height: size.height / 12,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Text("Send Notification",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black54)),
                                  )
                                ],
                              ),
                             
                            ],
                          ),
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
                                       Navigator.push(context, CupertinoPageRoute(builder: (context) => Create()));
                                    },
                                    child: Image(
                                      image: new AssetImage("assets/snbizmeeting.png"),
                                      height: size.height / 12,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Text("Set Meetings",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black54)),
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
                                    child: Text("Instant Upload", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black54),),
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
                              child: Stack(
                                children: <Widget>[CarouselSlider(
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
                                        children: map<Widget>(widgets, (index, url) {
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
                                  )
                                ],
                              )),
                        ),

                    ],
                  ),
                ),
              ],
            ),
          ),

      ),
       ),
    );
    
  }
  
}
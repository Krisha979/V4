import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snbiz/Model_code/createMeetings.dart';
import 'package:snbiz/src_code/static.dart';
//import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  DateTime meeting;
  var ctx;
  Future<bool> _onBackPressed() async {//function to handle on back press
   Navigator.pop(ctx);
   Navigator.pop(ctx);
  
 }
  final todayDate = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final meetingTime = TextEditingController();
  final meetingAgenda = TextEditingController();
  final meetingLocation = TextEditingController();
  final location = TextEditingController();
  final reminderTime = TextEditingController();


//function to call api
  Future<void> createMeeting() async {  
    CreateMeetings meeting = new CreateMeetings();

    meeting.meetingId = null;
    meeting.organizationId = StaticValue.orgId;
    meeting.meetingTime = meetingTime.text;
    meeting.location = meetingLocation.text;
    meeting.agenda = meetingAgenda.text.toString();
    meeting.statusId = StaticValue.meetingScheduledId;
    meeting.reminderTime =
        (DateTime.parse(meetingTime.text).add(new Duration(hours: -1))) //setting reminder time before  one hour of meeting time
            .toString();
    meeting.dateCreated = DateTime.now().toString();// current date time 
    meeting.createdBy = StaticValue.orgUserId;
    meeting.deleted = false;

    String jsonbody = jsonEncode(meeting);
     bool connection = await _checkConnectivity();  // internet connection function call

     //condition to check if connection is true or false
      if(connection == false){
                   showDialog(
                 context: context,
                 barrierDismissible: false,
                 builder: (BuildContext context){
                   return AlertDialog(
                     title: Text("Please, check your internet connection",
                  
                     style: TextStyle(color:Color(0xFFA19F9F,),
                     fontSize: 15,
                     fontWeight: FontWeight.normal),),
                     actions: <Widget>[
                       FlatButton(child: Text("OK"),
                       onPressed: (){
                        
                        Navigator.pop(context);
                        Navigator.pop(context);
                       

                       })
                     ],
                   );
                 }

               );


      }

      else{
    try {
<<<<<<< HEAD
      http.Response response = await http.post( Uri.encodeFull(StaticValue.baseUrl +StaticValue.createMeeting_url +
              StaticValue.orgId.toString()),
=======
      http.Response response = await http.post( Uri.encodeFull(StaticValue.baseUrl +"api/Meetings?sender=" +
              StaticValue.orgId.toString()),  //appi call to post the meeting
>>>>>>> 315b83066e57b742cfb9a04cc9706a7ca5041474
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },


          body: jsonbody);
      print(response);

      // condition to check if meeting is created then show dialog 

      if (response.statusCode == 201){  
        showGeneralDialog(
                barrierColor: Colors.black.withOpacity(0.5), 
                transitionBuilder: (context, a1, a2, widget) {
                  return Center(
                    child: Container(
                      height: 100.0 * a1.value,  
                      width: 100.0 * a1.value,
                      color: Colors.transparent,
                      child: Image(image: AssetImage("assets/acceptedtick-web.png"),),
                      

                    ),
                  );
                },
                transitionDuration: Duration(milliseconds: 700), 
                barrierDismissible: true,
                barrierLabel: 'LABEL',
                context: context,
                pageBuilder: (context, animation1, animation2) {
                  return Text('PAGE BUILDER');

                  
                });
                 Future.delayed(const Duration(milliseconds:1000),(){
                   setState(() {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                   });
               
                 });
                }
                } catch (e) {
       showDialog(
                 context: context,
                 barrierDismissible: false,
                 builder: (BuildContext context){
                   return AlertDialog(
                     title: Text("Pleasse, Check your internet connection",
                  
                     style: TextStyle(color:Color(0xFFA19F9F,),
                     fontSize: 15,
                     fontWeight: FontWeight.normal),),
                     actions: <Widget>[
                       FlatButton(child: Text("OK"),
                       onPressed: (){
                        
                        Navigator.pop(context);
                        Navigator.pop(context);

                       })
                     ],
                   );
                 }

               );


     
    }
  }}

Future<bool> _checkConnectivity()  async{ //internet connection function
                        var result =  await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.none){
             
                         return false;
                        }
                        }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Create Meeting",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
        backgroundColor: const Color(0xFF9C38FF),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Wrap(children: <Widget>[
            Container(
              constraints: new BoxConstraints(
                     ),
              color: Color(0xFFF4EAEA),
              child: Wrap(children: <Widget>[
                Container(
                  constraints: new BoxConstraints(
          
                      ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(0.5, 0.5),
                        ),
                      ],
                      color: Colors.white),
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 80),
                  child: Wrap(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Schedule a",
                                          style: TextStyle(
                                              color: Color(0xFF665959),
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "New Meeting",
                                          style: TextStyle(
                                              color: Color(0xFF665959),
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                  Image(
                                    image: new AssetImage(
                                        "assets/snbizmeetings.png"),
                                    height: size.height / 9,
                                  ),
                                ]),
                            Row(children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                  "Meeting Agenda",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Color(0XFFA19F9F),
                                  ),
                                ),
                              ),
                            ]),
                            new Theme(
                              data: new ThemeData(
                                hintColor: Color(0xFFFBF4F4),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 6,
                                  maxLength: 300,
                                  controller: meetingAgenda,
                                  decoration: new InputDecoration(
                                    fillColor: Color(0xFFFBF4F4),
                                    filled: true,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                      borderSide: new BorderSide(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                  "Meeting Location",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Color(0XFFA19F9F),
                                  ),
                                ),
                              ),
                            ]),
                            new Theme(
                              data: new ThemeData(
                                hintColor: Color(0xFFFBF4F4),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: TextFormField(
                                  maxLines: 3,
                                  maxLength: 150,
                                  keyboardType: TextInputType.multiline,

                                  controller: meetingLocation,
                                  decoration: new InputDecoration(
                                    fillColor: Color(0xFFFBF4F4),
                                    filled: true,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                      borderSide: new BorderSide(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                  " Meeting Date & Time",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Color(0XFFA19F9F),
                                  ),
                                ),
                              ),
                            ]),
                            new Theme(
                                data: new ThemeData(
                                  hintColor: Color(0xFFFBF4F4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: DateTimeField(
                                    controller: meetingTime,
                                    format: format,
                                    decoration: new InputDecoration(
                                      fillColor: Color(0xFFFBF4F4),
                                      filled: true,
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                        borderSide: new BorderSide(),
                                      ),
                                    ),
                                    onShowPicker:
                                        (context, currentValue) async {
                                      final date = await showDatePicker(   
                                          context: context,
                                          firstDate: DateTime.now(), 
                                          initialDate:
                                              currentValue ?? DateTime.now(),
                                          lastDate: DateTime(2100));
                                      if (date != null) {
                                        final time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(      
                                              currentValue ?? DateTime.now()),
                                        );
                                        return DateTimeField.combine(
                                            date, time);
                                      } else {
                                        return currentValue;
                                      }
                                    },
                                  ),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, bottom: 30),
                                    child: RaisedButton(

                                      //to check if field is empty or not
                                      onPressed: () async {
                                        if (meetingAgenda.text.isEmpty ||
                                            meetingLocation.text.isEmpty ||
                                            meetingLocation.text.isEmpty) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: new Text(
                                                      "Please enter all the values."),
                                                );
                                              });
                                        }
                    else if (DateTime.now().isAfter(DateTime.parse(meetingTime.text))){
                    showDialog(
                 context: context,
                 barrierDismissible: false,
                 builder: (BuildContext context){
                   return AlertDialog(
                     title: Text("please check your date time",
                  
                     style: TextStyle(color:Color(0xFFA19F9F,),
                     fontSize: 15,
                     fontWeight: FontWeight.normal),),
                     actions: <Widget>[
                       FlatButton(child: Text("OK"),
                       onPressed: (){
                        Navigator.pop(context);
                       
                       })
                     ],
                   );

                 }
                                );
                 } else {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                ctx = context;
                                    return new WillPopScope(  //to handle on back press

                                      onWillPop: _onBackPressed,
                                      child: Center(
                                      child: Theme(
                                        data: new ThemeData(
                                          hintColor: Colors.white,
                                        ),
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
                                       ))) );
                                              });
                                          createMeeting();
                                        
                                      
                                        }
                                      },
                                      textColor: Colors.white,
                                      padding: const EdgeInsets.all(0.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Container(
                                          decoration: const BoxDecoration(
                                              color: Color(0xFFB56AFF),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0))),
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 5),
                                          child: Center(
                                            child: Text('Set Meeting',
                                                style: TextStyle(fontSize: 18)),
                                          )),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, bottom: 30),
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      textColor: Colors.white,
                                      padding: const EdgeInsets.all(0.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: Container(
                                          decoration: const BoxDecoration(
                                              color: Color(0xFFB56AFF),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0))),
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 5),
                                          child: Center(
                                            child: Text('Cancel',
                                                style: TextStyle(fontSize: 18)),
                                          )),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ]),
                    ),
                  ]),
                ),
              ]),
            ),
          ])
        ],
      ),
    );
  }
}

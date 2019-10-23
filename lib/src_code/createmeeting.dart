import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snbiz/Model_code/createMeetings.dart';
import 'package:date_format/date_format.dart';
import 'package:snbiz/src_code/static.dart';
//import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  DateTime meeting;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final meetingTime = TextEditingController();
  final meetingAgenda = TextEditingController();
  final meetingLocation = TextEditingController();
  final location = TextEditingController();
  final reminderTime = TextEditingController();

  

  Future<void> createMeeting() async {
    // bool _validate = false;
    //  var agenda = meetingAgenda.text;
    //  var loc = location.text;

    
    CreateMeetings meeting = new CreateMeetings();

    meeting.meetingId = null;
    meeting.organizationId = StaticValue.orgId;
    meeting.meetingTime = meetingTime.text;
    meeting.location = meetingLocation.text;
    meeting.agenda = meetingAgenda.text.toString();
    meeting.statusId = StaticValue.meetingScheduledId;
    meeting.reminderTime = (DateTime.parse(meetingTime.text).add(new Duration(hours: -1))).toString();
    meeting.dateCreated = DateTime.now().toString();
    meeting.createdBy = StaticValue.orgId;
    meeting.deleted = false;


    String jsonbody = jsonEncode(meeting);
    try {
      http.Response response = await http.post(
          Uri.encodeFull(StaticValue.baseUrl + "api/Meetings?sender=" +
              StaticValue.orgId.toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonbody);
          print(response);

    } catch (e) {
      Text("Server error!!");

    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("create Meeting"),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
           height: size.height,
                    color: Color(0xFFd6d6d6),
                    child: Container(
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
              child: Column(
                mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                   Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Schedule a",
                                    style: TextStyle(
                                        color: Color(0xFF665959),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "New Meeting",
                                    style: TextStyle(
                                        color: Color(0xFF665959),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                                  Image(
                                    image: new AssetImage(
                                        "assets/new_meeting.png"),
                                    height: size.height / 9,
                                  ),
                                ]),
                                 Row(children: <Widget>[
                              Text(
                                "Meeting Agenda",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                  color: Color(0XFFA19F9F),
                                ),
                              ),
                            ]),
                            
                            new Theme(
                              data: new ThemeData(
                                hintColor: Color(0xFFFBF4F4),
                              ),
                              child: TextFormField(
                                
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
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
                            


                     Row(children: <Widget>[
                              Text(
                                "Meeting Location",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                  color: Color(0XFFA19F9F),
                                ),
                              ),
                            ]),
                            
                            new Theme(
                              data: new ThemeData(
                                hintColor: Color(0xFFFBF4F4),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
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


                  Row(children: <Widget>[
                              Text(
                                " Meeting Date & Time",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                  color: Color(0XFFA19F9F),
                                ),
                              ),
                            ]),
                            
                            new Theme(
                              data: new ThemeData(
                                hintColor: Color(0xFFFBF4F4),
                              ),
                             
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
                                onShowPicker: (context, currentValue) async {
                                  final date = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2100));
                                  if (date != null) {
                                    final time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          currentValue ?? DateTime.now()),
                                    );
                                    return DateTimeField.combine(date, time);
                                   
                                  } else {
                                    return currentValue;
                                  }
                                },
                              )),
                            

                  
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Center(
                                  child: RaisedButton(
                                     onPressed: () async{
                       if (meetingAgenda.text.isEmpty || meetingLocation.text.isEmpty ||
                                     meetingLocation.text.isEmpty){
                                         showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text("Please enter all the values."),);});
                                      
                                      }
                                      else{
                      showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return Center(child: CircularProgressIndicator(),);
                        });
                await createMeeting();
                      Navigator.pop(context);  
                        Navigator.pop(context); 
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
                                            28, 10, 28, 5),
                                        child: Center(
                                          child: Text('Set Meeting',
                                              style: TextStyle(fontSize: 18)),
                                        )),
                                  ),
                                ),
                                Center(
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
                                            28, 10, 28, 5),
                                        child: Center(
                                          child: Text('Cancel',
                                              style: TextStyle(fontSize: 18)),
                                        )),
                                  ),
                                )
                              ],
                            )
                ]
                ),
          ),
          )],
      ),
    );
  }
}

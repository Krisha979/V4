import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snbiz/Model_code/createMeetings.dart';
import 'package:snbiz/src_code/static.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final meetingTime = TextEditingController();
  final meetingAgenda = TextEditingController();
  final meetingLocation = TextEditingController();
  final location = TextEditingController();
  final reminderTime = TextEditingController();

  Future<void> createMeeting() async {

     var agenda = meetingAgenda.text;
     var loc = location.text;
    
    CreateMeetings meeting = new CreateMeetings();

    meeting.meetingId = null;
    meeting.organizationId = StaticValue.orgId;
    meeting.meetingTime = meetingTime.text;
    meeting.location = location.text;
    meeting.agenda = meetingAgenda.text.toString();
    meeting.statusId = 13;
    meeting.reminderTime = reminderTime.text;
    meeting.dateCreated = DateTime.now().toString();
    meeting.createdBy = 2;
    meeting.deleted = false;


    String jsonbody = jsonEncode(meeting);

    try {
      http.Response response = await http.post(
          Uri.encodeFull("https://s-nbiz.conveyor.cloud/api/Meetings?sender=" +
              StaticValue.orgId.toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonbody);
    } catch (e) {
      Text("Server error!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("create Meeting"),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15.0),
            child: Material(
              color: Colors.white,
              elevation: 2.0,
              borderRadius: BorderRadius.circular(5.0),
              shadowColor: Color(0x802196f3),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 195, top: 40.0),
                    child: Text(
                      'Date and Time',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.0),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Material(
                        elevation: 5.0,
                        shadowColor: Colors.black,
                        child: DateTimeField(
                          controller: meetingTime,
                          format: format,
                          onShowPicker: (context, currentValue) async {
                            final date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
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
                  ),
                   Padding(
                    padding: EdgeInsets.only(right: 195),
                    child: Text(
                      'Location',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Material(
                      elevation: 5.0,
                      shadowColor: Colors.black,
                      child: TextFormField(
                          controller: location,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 3.0)))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 195),
                    child: Text(
                      'Agenda',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Material(
                      elevation: 5.0,
                      shadowColor: Colors.black,
                      child: TextFormField(
                          controller: meetingAgenda,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 3.0)))),
                    ),
                  ),
                  /*
                  Padding(
                    padding: EdgeInsets.only(right: 195),
                    child: Text(
                      'Status Id',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Material(
                      elevation: 5.0,
                      shadowColor: Colors.black,
                      child: TextFormField(
                          controller: meetingstatus,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 3.0)))),
                    ),
                  ),
                  */
                  Padding(
                    padding: EdgeInsets.only(right: 195, top: 40.0),
                    child: Text(
                      'Reminder Time',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.0),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Material(
                        elevation: 5.0,
                        shadowColor: Colors.black,
                        child: DateTimeField(
                          controller: reminderTime,
                          format: format,
                          onShowPicker: (context, currentValue) async {
                            final date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.0),
                  ),
                  RaisedButton(
                    elevation: 5.0,
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(10.0),
                    splashColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0)),
                    onPressed: () {
                     // if(meetingAgenda.text.isNotEmpty){
                      createMeeting();
                   //   }
                      
                      
                    },
                    child: Text("Create"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

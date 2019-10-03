import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
//import 'package:intl/intl.dart';
import 'package:snbiz/Model_code/meetingsdetails.dart';
import 'package:snbiz/src_code/meeting.dart';

class MeetingDetail extends StatefulWidget {
  final MeetingInfo details;
  const MeetingDetail({Key key, this.details}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MeetingDetailState(this.details);
  }
}

class MeetingDetailState extends State<MeetingDetail> {
 final format = DateFormat("yyyy-MM-dd HH:mm");
  final MeetingInfo details;
  MeetingDetailState(this.details);
  TextEditingController meetingTime;
  TextEditingController meetingLocation;
  TextEditingController meetingAgenda;
  TextEditingController meetingreminderTime;

  // sending the edited values to API
  Future<void> editData() async {
    details.meetingTime = meetingTime.text;
    details.location = meetingLocation.text;
    details.agenda = meetingAgenda.text;
    details.reminderTime= meetingreminderTime.text;
    String jsonbody = jsonEncode(details);
    try {
                   // "https://s-nbiz.conveyor.cloud/api/Meetings?sender="+ (details.organizationId).toString()),

      http.Response data = await http.put(
          Uri.encodeFull(
              "https://s-nbiz.conveyor.cloud/api/Meetings/"+ details.meetingId.toString()+"?sender="+ (details.organizationId).toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonbody
          );
    } catch (e) {
      Text("Server error!!");
    }
  }
   String _time = "";
time(){
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                    print('confirm $time');
                    _time = '${time.hour} : ${time.minute}';
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
                
}

  @override
  void initState() {
    meetingTime = new TextEditingController(text: details.meetingTime);
    meetingLocation = new TextEditingController(text: details.location);
    meetingAgenda = new TextEditingController(text: details.agenda);
    meetingreminderTime = new TextEditingController(text:details.reminderTime);
  }
  

  Future<void> editPopup() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.all(0.0),
            title: Text("Edit Meeting"),
            content: SingleChildScrollView(
                child: ListBody(children: <Widget>[
              Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Text("Location"),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: meetingLocation,
                        decoration: InputDecoration(
                            fillColor: Colors.white, filled: true),
                      ),
                    )
                  ]),
                  Row(children: <Widget>[
                    Text("Agenda"),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: meetingAgenda,
                        decoration: InputDecoration(
                            fillColor: Colors.white, filled: true),
                      ),
                    )
                  ]),
                  
                  Row(
                  children: <Widget>[
                      Text(" Meeting Time"),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                    Expanded(
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
                       )
                    )
                  ]
                  ),
                   Row(
                  children: <Widget>[
                      Text("Reminder Time"),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                    Expanded(
                      child: DateTimeField(
                        controller: meetingreminderTime,
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
                       )
                    )
                  ]
                  ),
                  
                  FlatButton(
                      color: Colors.blue,
                      child: Text(
                        "Update Details",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: ()async {
                       await editData();
                       Navigator.pop(context);
                       Navigator.pop(context);

                         })
                ],
              )
            ]
                )
            )
          );
        });
  }
  
  String formatDateTime(String date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime format = (dateFormat.parse(date));
    DateFormat longdate = DateFormat("EEEE, MMM d, yyyy");
    date = longdate.format(format);
    return date;
  }
  @override
  Widget build(BuildContext context) {
    var date = formatDateTime(details.meetingTime);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Details"),
          actions: <Widget>[
            InkWell(
              onTap: () {
                editPopup();
              },
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Container(
                    width: size.width,
                    height: size.height,
                    color: Colors.blue,
                    margin: EdgeInsets.all(10.0),
                    child: Column(children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("Meeting Time"),
                          Text(details.meetingTime.toString()),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Meeting Date"),
                          Text(date),
                              //  child: Text( DateFormat("dd-MM-yyyy").format(details.meetingTime)), 
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Meeting Location"),
                             Text(details.location.toString()),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Meeting Agenda"),
                             Text(details.agenda.toString()),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Set Reminder"),
                          Text(details.reminderTime.toString()),
                        ]
                          ),
                          Row(
                        children: <Widget>[
                          Text("Status"),
                          Text(details.statusName.toString()),
                        ]
                          ),
                        ],
                      ),
                   )
                   )
                   )
                   );
  }
}

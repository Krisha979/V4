import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snbiz/Model_code/meetingStatus.dart';
import 'package:snbiz/Model_code/meetingsdetails.dart';
import 'package:http/http.dart' as http;
import 'package:snbiz/src_code/static.dart';

class AddEditDialog extends StatefulWidget {
  final MeetingInfo details;
  const AddEditDialog({Key key, this.details}) : super(key: key);
  @override
  AddEditDialogState createState() => new AddEditDialogState(this.details);
}

class AddEditDialogState extends State<AddEditDialog> {
   final MeetingInfo details;
  AddEditDialogState(this.details);
   final format = DateFormat("yyyy-MM-dd HH:mm");
  
  TextEditingController meetingTime;
  TextEditingController meetingLocation;
  TextEditingController meetingAgenda;
  TextEditingController meetingreminderTime;

  // List<MeetingStatus> statuslist = [];
  String _selectedvalue;

   int _statusid;
   Future<void> editData() async {
    details.meetingTime = meetingTime.text;
    details.location = meetingLocation.text;
    details.agenda = meetingAgenda.text;
    details.reminderTime = meetingreminderTime.text;
    details.statusId= _statusid;
    String jsonbody = jsonEncode(details);
    try {
      http.Response data = await http.put(
          Uri.encodeFull(StaticValue.baseUrl + "api/Meetings/" +
              details.meetingId.toString() +
              "?sender=" +
              (details.organizationId).toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonbody);
    } catch (e) {
      Text("Server error!!");
    }
  }

  // Future<void> status() async {
  //   try {
  //     http.Response data = await http.get(
  //         Uri.encodeFull("https://s-nbiz.conveyor.cloud/api/childstatus?id=" +
  //             StaticValue.meetingstatusId.toString()),
  //         headers: {
  //           'Content-type': 'application/json',
  //           'Accept': 'application/json'
  //         });

  //     var jsonData = json.decode(data.body);

  //     for (var u in jsonData) {
  //       var meetingstatus = MeetingStatus.fromJson(u);
  //       statuslist.add(meetingstatus);
  //     }
  //     //print(statuslist.length);
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    meetingTime = new TextEditingController(text: details.meetingTime);
    meetingLocation = new TextEditingController(text: details.location);
    meetingAgenda = new TextEditingController(text: details.agenda);
    meetingreminderTime = new TextEditingController(text: details.reminderTime);
    
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('New entry'),
        actions: [
          new FlatButton(
              onPressed: () {
              },
              child: new Text('SAVE',
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.white))),
        ],
      ),
      body: 
      
      SingleChildScrollView(
        
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
                    Row(children: <Widget>[
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
                      ))
                    ]),
                    Row(children: <Widget>[
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
                      ))
                    ]),
                    Row(children: <Widget>[
                      Text("Status"),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            new DropdownButton(
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                              ),
                              items: StaticValue.statuslist.map((list) {
                                return DropdownMenuItem<String>(
                                  value: list.statusName,
                                  child: Text(list.statusName),
                                );
                              }).toList(),
                              onChanged: (newvalue) {

                                setState(() {
                                _selectedvalue=newvalue.toString() ;
                                for(MeetingStatus items in StaticValue.statuslist){
                                if( items.statusName ==_selectedvalue){
                                  _statusid = items.statusId;
                                }
                                }
                                
                                //  _statusid = StaticValue.statuslist.indexOf(_selectedvalue);
                                  
                                 
                                });
                              },
                              value: _selectedvalue,
                            
                              hint: Text(details.statusName),
                            ),
                            
    
                          ]),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                    ]),
                    FlatButton(
                        color: Colors.blue,
                        child: Text(
                          "Update Details",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          await editData();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        })
                  ],
                )
              ]))
    );
  }
}

import 'dart:convert';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snbiz/Model_code/meetingStatus.dart';
import 'package:snbiz/Model_code/meetingsdetails.dart';
import 'package:http/http.dart' as http;
import 'package:snbiz/src_code/static.dart';
//import 'package:basic_utils/basic_utils.dart';

class AddEditDialog extends StatefulWidget {
  final MeetingInfo details;
  const AddEditDialog({Key key, this.details}) : super(key: key);
  @override
  AddEditDialogState createState() => new AddEditDialogState(this.details);
}

class AddEditDialogState extends State<AddEditDialog> {
  bool _validate = false;
  DateTime meetingdate;
  final MeetingInfo details;
  AddEditDialogState(this.details);
  final format = DateFormat("yyyy-MM-dd HH:mm:ss");

  TextEditingController meetingTime;
  TextEditingController meetingLocation;
  TextEditingController meetingAgenda;
  TextEditingController meetingreminderTime;
  String _selectedvalue;

  int _statusid;
  Future<void> editData() async {
    var mt = meetingreminderTime.text.replaceAll(new RegExp(r"\ "),"T");
    details.meetingTime = mt;
    details.location = meetingLocation.text;
    details.agenda = meetingAgenda.text;
    var time = meetingreminderTime.text.replaceAll(new RegExp(r"\ "),"T");
    details.reminderTime = time;
    details.statusId = _statusid;
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

  @override
  void initState() {
    super.initState();
    meetingTime = new TextEditingController(text: details.meetingTime);
    meetingLocation = new TextEditingController(text: details.location);
    meetingAgenda = new TextEditingController(text: details.agenda);
    meetingreminderTime = new TextEditingController(text: details.reminderTime);
    _selectedvalue = details.statusName;
    /*
     setState(() {
                                          _selectedvalue = newvalue.toString();
                                          for (MeetingStatus items
                                              in StaticValue.statuslist) {
                                            if (items.statusName ==
                                                _selectedvalue) {
                                              _statusid = items.statusId;
                                            }
                                          }
                                        }
*/
    
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('New entry'),
          actions: [
            new FlatButton(
                onPressed: () {},
                child: new Text('SAVE',
                    style: Theme.of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: Colors.white))),
          ],
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Container(
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
                        margin: EdgeInsets.fromLTRB(5, 8, 5, 5),
                        padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Edit Meeting",
                                    style: TextStyle(
                                        color: Color(0xFF665959),
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
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
                                   errorText: _validate ? 'Value Can\'t Be Empty' : null,
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
                            


                            
                            Row(children: <Widget>[
                              Text(
                                "Reminder Time",
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
                                controller: meetingreminderTime,
                                format: format,
                                decoration: new InputDecoration(
                                  fillColor: Color(0xFFFBF4F4),
                                  filled: true,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    'Status',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 50),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Color(0xFFFBF4F4),
                                    ),
                                    margin: EdgeInsets.fromLTRB(5, 5, 0, 5),
                                    padding: EdgeInsets.fromLTRB(35, 5, 35, 5),
                                    child: DropdownButton(
                                      icon: Icon(Icons.arrow_downward),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:
                                          TextStyle(color: Colors.deepPurple),
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
                                          _selectedvalue = newvalue.toString();
                                          for (MeetingStatus items
                                              in StaticValue.statuslist) {
                                            if (items.statusName ==
                                                _selectedvalue) {
                                              _statusid = items.statusId;
                                            }
                                          }
                                        });
                                      },
                                      value: _selectedvalue,
                                      //hint: Text(details.statusName),
                                    ),
                                  )
                                ]),


                           
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Center(
                                  child: RaisedButton(
                                    onPressed: () async {
                                      if (meetingAgenda.text.isEmpty || meetingLocation.text.isEmpty){
                                        showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text("Please enter all the values."),);});
                                      }
                                      else{
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          });
                                      await editData();
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
                                            28, 10, 28, 10),
                                        child: Center(
                                          child: Text('Update',
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
                                            28, 10, 28, 10),
                                        child: Center(
                                          child: Text('Cancel',
                                              style: TextStyle(fontSize: 18)),
                                        )),
                                  ),
                                )
                              ],
                            )
                          ],
                        ))))));
  }
}

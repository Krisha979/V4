import 'dart:convert';

//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:snbiz/Model_code/meetingStatus.dart';
import 'package:snbiz/Model_code/meetingsdetails.dart';
import 'package:snbiz/src_code/Editdialogs.dart';
import 'package:snbiz/src_code/static.dart';

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

  List<MeetingStatus> statuslist = [];
  String _selectedvalue;
  int _statusid;
  Future<void> editData() async {
    details.meetingTime = meetingTime.text;
    details.location = meetingLocation.text;
    details.agenda = meetingAgenda.text;
    details.reminderTime = meetingreminderTime.text;
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

  Future<void> status() async {
    try {
      http.Response data = await http.get(
          Uri.encodeFull("https://s-nbiz.conveyor.cloud/api/childstatus?id=" +
              StaticValue.meetingstatusId.toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });

      var jsonData = json.decode(data.body);

      for (var u in jsonData) {
        var meetingstatus = MeetingStatus.fromJson(u);
        statuslist.add(meetingstatus);
      }
      print(statuslist.length);
    } catch (e) {
      print(e);
      return null;
    }
  }
  @override
  void initState() {
    meetingTime = new TextEditingController(text: details.meetingTime);
    meetingLocation = new TextEditingController(text: details.location);
    meetingAgenda = new TextEditingController(text: details.agenda);
    meetingreminderTime = new TextEditingController(text: details.reminderTime);
    status();
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
              onTap: () async {
                 if(StaticValue.orgId==details.createdBy){        
                Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return new AddEditDialog(details: details);
                    },
                    fullscreenDialog: true));
              }
              else{
                   
              }
              
             /* if(StaticValue.orgId==details.createdBy){ 
          editPopup();
              }
              */
              },
                child:Icon(
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
          child: Column(
            children: <Widget>[
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
              Row(children: <Widget>[
                Text("Set Reminder"),
                Text(details.reminderTime.toString()),
              ]),
              Row(children: <Widget>[
                Text("Status"),
                Text(details.statusName.toString()),
              ]),
            ],
          ),
        ))));
  }
}

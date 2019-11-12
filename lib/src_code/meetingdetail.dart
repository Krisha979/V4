import 'dart:convert';
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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
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
    details.statusId = _statusid;
     _selectedvalue = details.statusName;
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
          if(data.statusCode == 500){

          }
    } catch (e) {
      Text("Server error!!");
    }
  }

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
    var date = formatDateTime(details.meetingTime);
    var time = formatTime(details.meetingTime);
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Details",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
            backgroundColor: const Color(0xFF9C38FF),
          actions: <Widget>[
            InkWell(
              onTap: () async {
                if (StaticValue.orgId == details.createdBy || details.statusName == "Concluded") {
                  Navigator.of(context).push(new CupertinoPageRoute<Null>(
                      builder: (BuildContext context) {
                        return new AddEditDialog(details: details);
                      },
                      fullscreenDialog: true));
                } else {
      
                    await _alert(context, "Information", "Sorry you cannot edit this meeting. Only meetings created by yourself can be edited.");
                }
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
            child: Wrap(
              children: <Widget>[
                           Container(
                              constraints:  new BoxConstraints(
 //   minHeight: size.height,
    
    maxHeight: size.height,
  
  ),
                
               // height: size.height,
                color: Color(0XFFF4EAEA),
                child: Wrap(
                                 children: <Widget>[  Container(

                                    constraints:  new BoxConstraints(
  //  minHeight: size.height,
    
    maxHeight: size.height,
  
  ),
                    //constraints: new BoxConstraints(minHeight: size.height),
                    
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
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                    child: Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8),
                      ),
                      Row(children: <Widget>[
                        Text(
                          "Meeting with SN Business",
                          style: TextStyle(
                              color: Color(0xFF665959),
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ]),
                      Padding(
                        padding: EdgeInsets.all(16),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            date,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 14),
                          ),
                          //  child: Text( DateFormat("dd-MM-yyyy").format(details.meetingTime)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                      ),
                      Row(
                        children: <Widget>[
                          Text(time,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                      ),
                      Row(
                        children: <Widget>[
                          Text(details.location.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Meeting Agenda',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF665959)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                      ),
                      Row(children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              
                              borderRadius: BorderRadius.circular(10.0),
                              color: Color(0xFFFBF4F4),
                            ),
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                            child: Text(details.agenda.toString()),
                          ),
                        ),
                      ]),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Status',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 35),
                            ),
                            
                          
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFFBF4F4),
                              ),
                              margin: EdgeInsets.fromLTRB(0, 0, 0,0),
                              padding: EdgeInsets.fromLTRB(35, 5, 35, 5),
                              

                              child: Center(
                                child: DropdownButton(
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
                                      _selectedvalue = newvalue.toString();
                                      for (MeetingStatus items
                                          in StaticValue.statuslist) {
                                        if (items.statusName == _selectedvalue) {
                                          _statusid = items.statusId;
                                        }
                                      }
                                    });
                                  },
                                  value: _selectedvalue,
                                  hint: Text(details.statusName),
                                ),
                              ),
                            )
                          ]),
                      Padding(
                        padding: EdgeInsets.all(20),
                      ),
                      
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                                              children:<Widget>[ RaisedButton(
                            onPressed: () async{
                                          
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
                                          },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFFB56AFF),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0))),
                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Center(
                                  child:
                                      Text('Respond', style: TextStyle(fontSize: 18)),
                                )),
                          
                                              ),]),
                    ])
              ),
                                 ])),
              ]),
              ),
            ),
          );
        
  }
  Future<void> _alert(BuildContext context, String header, String body) {
                          
                        return showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text(header),
                            content: Text(body),
                        
                                actions: <Widget>[
                          
                                  FlatButton(
                                          child: Text('Ok', style: TextStyle(color: Colors.blue, fontSize: 12.0)),
                                          
                                          onPressed: () {
                                                     Navigator.of(context).pop();
                                    },
                                  ),
                               ],
                             );
                            },
                          );
                        }
}

import 'dart:convert';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:snbiz/Model_code/meetingsdetails.dart';
import 'package:snbiz/src_code/meetingdetail.dart';
import 'package:snbiz/src_code/static.dart';


class Meeting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MeetingState();
  }
}

class MeetingState extends State<Meeting> {
  int counts;
  String switchText;
  bool isSwitched = false;
  bool isLoading = false;
 final _scaffoldKey = GlobalKey<ScaffoldState>();
  final RefreshController _refreshController = RefreshController();
  static List<MeetingInfo> meetinglist = [];

  Future<List<MeetingInfo>> _future;

  Future<void> _onSwitchChanged(bool value) async {
    var list = meetinglist;
    if (value == true) {
      isSwitched = true;
      StaticValue.togglestate = true;

      _future = upcomingsortedlist(list);
    } else {
      isSwitched = false;
      StaticValue.togglestate = false;
      _future = _meeting();
    }
    setState(() {});
  }

  Future<bool> _checkConnectivity()  async{
                        var result =  await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.none){
             
                         return false;
                        }
                        }
  @override
  void initState() {
    super.initState();
    switchText = "Meetings";
    counts = 0;
    setState(() {
      _future = _meeting();
    });
    //var mt = StaticValue.meetingTime.replaceAll(new RegExp(r", "),"\n\n");
  }
  Future<List<MeetingInfo>> _meeting() async {
    bool connection = await _checkConnectivity();
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
                       StaticValue.controller.animateTo(0);
                        Navigator.pop(context);
                       })
                     ],
                   );
                 }

               );
      }else {
    try {
      http.Response data = await http.get(
          Uri.encodeFull(StaticValue.baseUrl +
              "api/OrgMeetings?Orgid=" +
              StaticValue.orgId.toString() +
              "&Page=1&RecordsPerPage=15"),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      var jsonData = json.decode(data.body);
      List<MeetingInfo> meeting = [];
      for (var u in jsonData) {
        var meetinginfo = MeetingInfo.fromJson(u);
        meeting.add(meetinginfo);
      }
      meetinglist = meeting;
     // _future = meetinglist as Future<List<MeetingInfo>>;
      print(meeting.length);
      setState(() {
        counts = meeting.length;
      });
//counts = meeting.length;
      if (StaticValue.togglestate == true) {
        isSwitched = true;

        switchText = 'Upcoming Meetings';
        var sorted = await upcomingsortedlist(meeting);
        return sorted;
      } else {
        isSwitched = false;
        switchText = 'All Meetings';
        return meeting;
      }
    } catch (e) {
      print(e);
      return null;
    }
                                          }
                                         
                                           
  }

  Future<List<MeetingInfo>> upcomingsortedlist(
      List<MeetingInfo> meetinginfo) async {
    var filteredmeetings = meetinginfo;
    filteredmeetings.removeWhere(
        (a) => DateTime.parse(a.meetingTime).isBefore(DateTime.now()));
    filteredmeetings.sort((a, b) =>
        DateTime.parse(a.meetingTime).compareTo(DateTime.parse(b.meetingTime)));
    print(filteredmeetings);
    return filteredmeetings;
  }

  Future<List<MeetingInfo>> latestsortedlist(
      List<MeetingInfo> meetinginfo) async {
    meetinginfo.sort((a, b) =>
        DateTime.parse(a.dateCreated).compareTo(DateTime.parse(b.dateCreated)));
    print(meetinginfo);
    return meetinginfo;
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

    return Scaffold(
        body: SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2));
        await _meeting();
        _refreshController.refreshCompleted();

      },
      child: Container(
        color: Color(0XFFF4EAEA),
        child: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(9, 7, 9, 7),
              padding: EdgeInsets.fromLTRB(20, 10, 25, 5),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(0.5, 0.5),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                       

                        children: <Widget>[
                          
                          Text("Upcoming Meetings",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFFA19F9F),
                                  fontWeight: FontWeight.bold)),

                          Text(          
                            (StaticValue.upcomingMeetingsCount.toString()== null)?'not found':
                            StaticValue.upcomingMeetingsCount.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),

                          Text("Next Meetings",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(
                                    0xFFA19F9F,
                                  ),
                                  fontWeight: FontWeight.w600)),
                          //Text( StaticValue.meetingTime, style: TextStyle(fontSize: 14),),
                          Text(
                           ( StaticValue.meetingTime== null)?'not found':
                           StaticValue.meetingTime,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Image(
                      image: new AssetImage("assets/snbizmeetings.png"),
                      height: size.height / 10,
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.fromLTRB(14, 8, 12, 2),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('$switchText'),
                        Transform.scale(
                          scale: 1.0,
                          child: Switch(
                            onChanged: _onSwitchChanged,
                            value: isSwitched,
                          ),
                        ),
                      ]),
                ),
              ])),
          Container(
              child: FutureBuilder(
                  future: _future,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    //counts= meetinglist.length;
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Container(
                            child: Center(
                          child: Flexible(
                              child: Row(
                                                              children:<Widget>[ Text("Try Loading Again.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                                        Icon(Icons.refresh,
                                        color:Colors.black),
                                        ]
                              )),
                        ));
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return Container(
                            child: Center(child: CircularProgressIndicator()));
                      case ConnectionState.done:
                    
                      
                      
                        if (snapshot.data == null) {
            
             
                          return Container(
                              child: Center(
                            child: Container(     
                                child: Text("No records Available.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal))),
                          ));
           
                        } else {
                          return Flexible(
                            child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int meetingId) {
                                  var date = formatDateTime(
                                      snapshot.data[meetingId].meetingTime);
                                  var formattedtime = formatTime(
                                      snapshot.data[meetingId].meetingTime);

                                       
                                      var icon = "assets/snbizmeetings.png";
                                      if(snapshot.data[meetingId].statusName.contains("Schedule")){
                                       icon = "assets/snbizscheduled.png";
                                       }
                                          else if(snapshot.data[meetingId].statusName.contains("Postponned")){
                                            icon = "assets/snbizspostponed.png";
                                          }else if(snapshot.data[meetingId].statusName.contains("Accepted")){
                                            icon = "assets/acceptedtick-web.png";
                                          }else if(snapshot.data[meetingId].statusName.contains("Cancelled")){
                                            icon = "assets/acceptedtick-web.png";
                                          }else if(snapshot.data[meetingId].statusName.contains("Concluded")){
                                            icon = "assets/acceptedtick-web.png";
                                          } else if(snapshot.data[meetingId].statusName.contains("Declined")){
                                            icon = "assets/snbizdeclinedicon.png";
                                          }else if(snapshot.data[meetingId].statusName.contains("Rescheduled")){
                                            icon = "assets/acceptedtick-web.png";
                                          }    

                                     


                                  return ListTile(
                                    //  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                                    title: InkWell(
                                      child: new Theme(
                                          data: new ThemeData(
                                            hintColor: Colors.white,
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                15, 10, 15, 10),
                                            constraints: new BoxConstraints(
                                                minWidth: size.width),
                                            width: size.width,
                                            height: size.height / 5.5,
                                            decoration: new BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      15.0),
                                            ),
                                            child: new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Column( crossAxisAlignment: CrossAxisAlignment .start,
                                                    children: <Widget>[
                                                      Text(
                                                        formattedtime,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Flexible(
                                                          child: Text(
                                                        date,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      )),
                                                      Flexible(
                                                          child: Text(
                                                              snapshot
                                                                  .data[
                                                                      meetingId]
                                                                  .location,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal))),
                                                      Flexible(
                                                          child: Text(
                                                              snapshot
                                                                  .data[
                                                                      meetingId]
                                                                  .statusName,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal))),
                                                    ],
                                                  ),
                                                ),

                                                // button color
                                                InkWell(
                                                  child: Image(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    image: new AssetImage(
                                                        icon),
                                                    height: size.height / 12,
                                                  ),
                                                  splashColor: Colors
                                                      .red, // inkwell color
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MeetingDetail(
                                                                    details: snapshot
                                                                            .data[
                                                                        meetingId])));
                                                  },
                                                ),
                                              ],
                                            ),
                                          )),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeetingDetail(
                                                        details: snapshot
                                                            .data[meetingId])));
                                      },
                                    ),
                                  );
                                }),
                          );
                        
                      }}
                    
                    return Container(
                        child: Center(
                      child: Container(
                          child: Text("Try Loading Again.",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal))),
                    ));
                  }))
        ]),
      ),
    ));
  }
}

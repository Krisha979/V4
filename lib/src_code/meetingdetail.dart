import 'dart:convert';
import 'package:SNBizz/Model_code/meetingStatus.dart';
import 'package:SNBizz/Model_code/meetingsdetails.dart';
import 'package:SNBizz/src_code/static.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:connectivity/connectivity.dart';

import 'Editdialogs.dart';

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
  var ctx;
  // ignore: missing_return
  Future<bool> _onBackPressed() async {
   Navigator.pop(ctx);
   Navigator.pop(ctx);
   
 }



  // ignore: missing_return
  Future<bool> _checkConnectivity()  async{
                        var result =  await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.none){
             
                         return false;
                        }
                        }

 Future<void> editData() async {
    details.statusId = _statusid;
     _selectedvalue = details.statusName;
    String jsonbody = jsonEncode(details);

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
                          Navigator.pop(context);
                        

                       })
                     ],
                   );
                 }

               );
      }else{
      
    try {
      http.Response data = await http.put(
          Uri.encodeFull(StaticValue.baseUrl + StaticValue.meeeetingDetails_url+
              details.meetingId.toString() +
              "?sender=" +
              (details.organizationId).toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
             "apikey" : StaticValue.apikey
          },
          body: jsonbody);
          if(data.statusCode == 500){

            Navigator.pop(context);
            Navigator.pop(context);
          }
//meeting detail  respond check
      if (data.statusCode == 204){
        showGeneralDialog(
            barrierColor: Colors.black.withOpacity(0.5), //SHADOW EFFECT
            transitionBuilder: (context, a1, a2, widget) {
              return Center(
                child: Container(
                  height: 100.0 * a1.value,  // USE PROVIDED ANIMATION
                  width: 100.0 * a1.value,
                  color: Colors.transparent,
                  child: Image(image: AssetImage("assets/acceptedtick-web.png"),),


                ),
              );
            },
            transitionDuration: Duration(milliseconds: 700), // DURATION FOR ANIMATION
            barrierDismissible: false,
            barrierLabel: 'LABEL',
            context: context,
            pageBuilder: (context, animation1, animation2) {
              return Text('PAGE BUILDER');


            });
        Future.delayed(const Duration(milliseconds:1000),(){

            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);


        });


      }
    } catch (e) {
      Text("Server error!!");
    }

      }
  }

   


//format date time
  String formatDateTime(String date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime format = (dateFormat.parse(date));
    DateFormat longdate = DateFormat("EEEE, MMM d, yyyy");
    date = longdate.format(format);
    return date;
  }
//format time
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Details",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
            backgroundColor: const Color(0xFF9C38FF),
          actions: <Widget>[
             StaticValue.orgUserId == details.createdBy ? 
             InkWell(onTap:() async{
               if (StaticValue.orgUserId == details.createdBy || details.statusName == "Concluded"){

               Navigator.of(context).push(new CupertinoPageRoute<Null>(
                       builder: (BuildContext context) {
                       return new AddEditDialog(details: details);
                      },
                      fullscreenDialog: true));

             }},child:Padding(
               padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
               child: Icon(Icons.edit, color: Colors.white),
             )):  Container()
         
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Wrap(
              children: <Widget>[
                           Container(
                              constraints:  new BoxConstraints(

    
    //minHeight: size.height,
  
  ),
                
                color: Color(0XFFF4EAEA),
                child: Wrap(
                                 children: <Widget>[  Container(
                                   
constraints:  new BoxConstraints(

    
    minHeight: size.height,
  
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
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
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
                          Flexible(
                                                      child: Text(details.location.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14)),
                          ),
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
                              if(_selectedvalue==null){
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("You need to first change the status for update..",

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
                              }else{
                                if(_selectedvalue.toString().toLowerCase().contains("accepted")&&(details.createdBy==StaticValue.orgUserId)){
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                          title: Text("The metting created by you cannot be accepted by self...",

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
                                }
                                else{
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        ctx = context;
                                        return new WillPopScope(

                                            onWillPop: _onBackPressed,
                                            child: Center(
                                                child: Theme(
                                                    data: new ThemeData(
                                                      hintColor: Colors.white,
                                                    ),

                                                    child: Center(
                                                      child:
                                                      CircularProgressIndicator(
                                                          strokeWidth: 3.0,
                                                          backgroundColor: Colors.white
                                                      ),
                                                    ) ) )  );
                                      });
                                  editData();
                                }
                              }



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
  // ignore: unused_element
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

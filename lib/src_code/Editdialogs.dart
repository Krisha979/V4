import 'dart:convert';
import 'package:SNBizz/Model_code/meetingStatus.dart';
import 'package:SNBizz/Model_code/meetingsdetails.dart';
import 'package:SNBizz/src_code/static.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

class AddEditDialog extends StatefulWidget {
  final MeetingInfo details;
  const AddEditDialog({Key key, this.details}) : super(key: key);
  @override
  AddEditDialogState createState() => new AddEditDialogState(this.details);
}

class AddEditDialogState extends State<AddEditDialog> {
   var ctx;
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

  //edit meeting function api call to put the edited meeting

   Future<bool> _checkConnectivity()  async{
                        var result =  await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.none){
             
                         return false;
                        }
                        
                        }


  Future<void> editData() async {
    var mt = meetingTime.text.replaceAll(new RegExp(r"\ "),"T");
    details.meetingTime = mt;
    details.location = meetingLocation.text;
    details.agenda = meetingAgenda.text;
    var time = meetingreminderTime.text.replaceAll(new RegExp(r"\ "),"T");
    details.reminderTime = time;
    details.statusId = _statusid;
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
      }else {
    try {
      http.Response data = await http.put(
          Uri.encodeFull(StaticValue.baseUrl + StaticValue.createMeeting +
              details.meetingId.toString() +
              "?sender=" +
              (details.organizationId).toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "apikey" : StaticValue.apikey
          },
          body: jsonbody);
          if(data.statusCode == 204){  //condition to check if meeting is edited then show check dialog message
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
                   setState(() {
                Navigator.pop(context);
                Navigator.pop(context);
                 Navigator.pop(context);
                  Navigator.pop(context);
                
                   });
               
                 });

          }
    } catch (e) 
    {
    }
      } 
  }
Future<bool> _onBackPressed() async { //handle on back press
   Navigator.pop(ctx);
   Navigator.pop(ctx);
   Navigator.pop(ctx);
  
 }


  


//initializing textform field data
  @override
  void initState() {
    super.initState();
    meetingTime = new TextEditingController(text: details.meetingTime);
    meetingLocation = new TextEditingController(text: details.location);
    meetingAgenda = new TextEditingController(text: details.agenda);
    meetingreminderTime = new TextEditingController(text: details.reminderTime);
    _selectedvalue = details.statusName;
    _statusid = details.statusId;

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
       appBar: AppBar(
          title: Text("Details",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),
           backgroundColor: const Color(0xFF9C38FF),
       ),
        body: SingleChildScrollView(
            child: Center(
                child: Container(
                    color: Color(0xFFF4EAEA),
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
                      
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                     Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Edit Meeting",
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
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  child: TextFormField(
                                  
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 6,
                                    maxLength: 150,
                                  
                                    controller: meetingAgenda,
                                    decoration: new InputDecoration(   //empty field validation
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
                              ),
                              


                              Row(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 3,
                                    maxLength: 35,
                                  
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
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                                          firstDate: DateTime.now(), 
                                          
                                          initialDate:
                                              currentValue ?? DateTime.now(),
                                          lastDate: DateTime(2100));
                                      if (date != null) {
                                        final time = await showTimePicker(
                                          context: context,
                                          
                                          initialTime: TimeOfDay.now(),
                                          
                                        );

                                        
                                        return DateTimeField.combine(date, time);
                                       
                                      } else {
                                        return currentValue;
                                      }
                                  },
                                ),
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
                                      padding: EdgeInsets.only(left: 30),
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

                                        //drop down selection change
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
                                      ),
                                    )
                                  ]),


                             
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: RaisedButton(
                                        onPressed: () async {
                                          //to check text field empty
                                          if (meetingAgenda.text.isEmpty || meetingLocation.text.isEmpty ||
                                          meetingreminderTime.text.isEmpty || meetingLocation.text.isEmpty)
                                            {
                                            }
                                          else if(_selectedvalue.toString().toLowerCase().contains("accepted")&&(details.createdBy==StaticValue.orgId)){
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

                                           else if (details.meetingTime == meetingTime.text && details.location == meetingLocation.text
                                            && details.agenda == meetingAgenda.text && details.statusName == _selectedvalue){

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
                                           }

                                            else{

                                          showDialog(
                                              context: context,
                                              barrierDismissible:false ,
                                              builder: (BuildContext context) {
                                                 ctx = context;
                                    return new WillPopScope(
//handle on back press
                                      onWillPop: _onBackPressed,
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
                                       ) );
                                              });
                                           editData(); //function call
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
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
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
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ))))));
  }
}

import 'dart:convert';
//import 'dart:math';
//import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snbiz/Model_code/meetingsdetails.dart';
import 'package:snbiz/src_code/meetingdetail.dart';
import 'package:snbiz/src_code/static.dart';

class Meeting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MeetingState();
  }

}

class MeetingState extends State<Meeting>{
  String switchText = 'Latest Meeting';
  bool isSwitched = false;
  bool isLoading = false;
   List <MeetingInfo> meetinglist =[];
  Future<void>_onSwitchChanged(bool value) async {
    
      
    if(value == true){
            isSwitched = true;
            StaticValue.togglestate = true;
    }
    else{
      isSwitched = false;
      StaticValue.togglestate = false;
    }
    setState(() {
      
    });
    
    
    }
  
@override
  void initState() {
    super.initState();
  }
Future<List<MeetingInfo>>_meeting()async{
  try{
  http.Response data = await http.get(
          Uri.encodeFull(StaticValue.baseUrl + "api/OrgMeetings?Orgid=" + StaticValue.orgId.toString()), 
          headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json' 
        }
      );
  var jsonData = json.decode(data.body);
  List <MeetingInfo> meeting = [];
  for (var u in jsonData){
      var meetinginfo = MeetingInfo.fromJson(u);
    meeting.add(meetinginfo);
  }
print(meeting.length);
if(StaticValue.togglestate == true){
    isSwitched = true;
    
    switchText = 'Latest Meeting';
    var sorted = await upcomingsortedlist(meeting);
    return sorted;
}
else{
  isSwitched = false;
  switchText = 'Upcomming Meeting';
  return meeting;
}

 
}
catch(e){
  print(e);
  return null;

}
}

Future<List<MeetingInfo>> upcomingsortedlist(List<MeetingInfo> meetinginfo) async{


    meetinginfo.sort((a,b) => DateTime.now().compareTo(DateTime.parse(a.meetingTime)));
    print(meetinginfo);
    return meetinginfo;
}

Future<List<MeetingInfo>> latestsortedlist(List<MeetingInfo> meetinginfo) async{
    meetinginfo.sort((a,b) => DateTime.parse(b.dateCreated).compareTo(DateTime.parse(a.dateCreated)));
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
      body:Container(
               color:Color(0XFFF4EAEA),
        child: Column(
              children: <Widget>[
               
                Container(           
                          margin: EdgeInsets.fromLTRB(9, 7, 9, 7),
                         padding: EdgeInsets.fromLTRB(20, 20, 25, 15),
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
                              
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("All Meetings"),
                                  Text("148"),
                                  Icon(Icons.file_upload),
                                  Text("17th august 2019"),

                                ],
                                

                              ),
                            Image(
                                      image: new AssetImage("assets/new_meeting.png"),
                                      height: size.height / 9,
                                    ),
                            ],
                          ),

                        
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.fromLTRB(14, 8, 12, 5),

                        child:  Row(
                          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                                children:<Widget>[
                                                Text('$switchText'),
                                                   Transform.scale(
              scale: 1.0,
              child: Switch(
                onChanged: _onSwitchChanged,
                value: isSwitched,
              ),
            ),
                                                ]),
                ),])),
          Container( 
              child:FutureBuilder(
              future: _meeting(),
              builder:(BuildContext context, AsyncSnapshot snapshot){
                meetinglist = snapshot.data;
                print(snapshot.data);
                if(snapshot.data==null){
                  return Container(
                    child: Center(
                      
                    child: CircularProgressIndicator()
                   
                    )
                  );
                }else{
                  return Flexible(
                                    child: ListView.builder(

                                    
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int meetingId){
                         var date = formatDateTime(meetinglist[meetingId].meetingTime);
                         var formattedtime = formatTime(meetinglist[meetingId].meetingTime);
                        return ListTile(
                        //  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          
                          title: InkWell(
                           child: new Theme(
                              data: new ThemeData(
                                hintColor: Colors.white,
                              ),
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                                  constraints: new BoxConstraints(minWidth: size.width),
                            width: size.width,
                            height: size.height/5.5,
                          
                             decoration: new BoxDecoration(
                             color: Colors.white,
                             borderRadius: new BorderRadius.circular(15.0),
                            // boxShadow: [
                            //  BoxShadow(
                            //         blurRadius: 2.0,
                            //         color: Colors.black.withOpacity(0.5),
                            //         offset: Offset(0.0, 0.0),
                            //       ),
                            //     ],
                             ),
                             child: new Row(
                               
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                               
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  
                                  children: <Widget>[

                                    
                                    Text(formattedtime, textAlign: TextAlign.left, 
                                    style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold) ,),
                                   Flexible(child: Text(date, textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
                                   
                                    Flexible(child: Text(meetinglist[meetingId].location, textAlign:TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
                                     Flexible(child: Text(meetinglist[meetingId].statusName, textAlign:TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
                                  ],

                                ),
                      
                               // button color
                                    InkWell(
                                      
                                      child: Image(
                                  alignment: Alignment.centerRight,
                                      image: new AssetImage("assets/new_meeting.png"),
                                     height: size.height /12,
                                    ),
                                      splashColor: Colors.red, // inkwell color
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MeetingDetail(details:                        
                                        meetinglist[meetingId])));
                                      },
                                    ),
                                  
                               
                              ],
                            ),
                             )  ),
                                                onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MeetingDetail(details:                        
                                        meetinglist[meetingId])));
                                      },

                          ),
             );
                      }
                        ),
                  );
                }
              } 
             )
              
          )
              ]),
      )
    );
    }
  }

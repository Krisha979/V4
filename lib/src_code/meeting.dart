import 'dart:convert';
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

@override
  void initState() {
    super.initState();
    container();
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
return meeting;
 
}
catch(e){
  print(e);
  return null;

}
}
container(){
  Container(           
                      width: 350.0,
                      height: 125.0,
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
                       child:  Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                         ClipOval(
                          child: Material(
                            color: Colors.blue, // button color
                            child: InkWell(
                              splashColor: Colors.red, // inkwell color
                              child: SizedBox(width: 56, height: 56, child: Icon(Icons.picture_as_pdf)),
                              onTap: () {},
                            ),
                          ),
                        )
                        ],
                      ),

                    );
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
   // DateFormat dateFormat = DateFormat.yMd().add_jm();
    DateTime formattedtime = (dateFormatremoveT.parse(time));
    DateFormat longtme = DateFormat.jm();
    time = longtme.format(formattedtime);
    print(time);
   // DateTime timee = (dateFormat.parse(DateTime.now().toString()));
    return time.toString();
  }
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
   
    return Scaffold(
      body:Column(
         children: <Widget>[
            Container(           
                      width: 350.0,
                      height: 125.0,
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
                       child:  Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                         ClipOval(
                          child: Material(
                            color: Colors.blue, // button color
                            child: InkWell(
                              splashColor: Colors.red, // inkwell color
                              child: SizedBox(width: 56, height: 56, child: Icon(Icons.picture_as_pdf)),
                              onTap: () {},
                            ),
                          ),
                        )
                        ],
                      ),

                    ),

      Container(   child:
          FutureBuilder(
          future: _meeting(),
          builder:(BuildContext context, AsyncSnapshot snapshot){
            print(snapshot.data);
            if(snapshot.data==null){
              return Container(
                child: Center(
                  
                child: CircularProgressIndicator()
               
                )
              );
            }else{
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int meetingId){
                   var date = formatDateTime(snapshot.data[meetingId].meetingTime);
                   var formattedtime = formatTime(snapshot.data[meetingId].meetingTime);
                  return ListTile(
                    title: Container(
                    width: 315.0,
                    height: 125.0,
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
                     child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                           Text(date),
                           Text(formattedtime),
                            Flexible(child: Text(snapshot.data[meetingId].location)),
                          ],

                        ),
                  
                       ClipOval(
                          child: Material(
                            color: Colors.blue, // button color
                            child: InkWell(
                              splashColor: Colors.red, // inkwell color
                              child: SizedBox(width: 56, height: 56,
                               child: Icon(
                                 Icons.picture_as_pdf,
                                 color: Colors.white,
                                 )),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> MeetingDetail(details:                        
                                snapshot.data[meetingId])));
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    ),
         );
                }
                  );
            }
          } 
         )
      )]
      )
      );
    }
  }

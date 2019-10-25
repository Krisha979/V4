import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snbiz/Model_code/OrgTask.dart';
import 'package:snbiz/Model_code/Task.dart';
import 'package:snbiz/src_code/static.dart';
import 'package:http/http.dart' as http;

class TaskDetailsPage extends StatefulWidget {
  final OrgTask details;
  const TaskDetailsPage({Key key, this.details}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return TaskDetailsState(this.details);
  }
}

class TaskDetailsState extends State<TaskDetailsPage> {
final OrgTask details;
  TaskDetailsState(this.details);

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

Future<List<Task>> getTask()async{
  var orgTaskId = details.parentTask.organizationTaskId;
  try{
  http.Response data = await http.get(
          Uri.encodeFull(StaticValue.baseUrl + "api/OrgChildTasks?Orgid=" + StaticValue.orgId.toString()+"&OrgTaskId=" + orgTaskId.toString() ), 
          headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json' 
        }
      );

  var jsonData = json.decode(data.body);
  List <Task> task = [];
  for (var u in jsonData){
      var tasks = Task.fromJson(u);
    task.add(tasks);
  }
print(task.length);
return task;

}
catch(e){
  print(e);
  return null;

}
}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   
    return Scaffold(
      appBar: AppBar(title: Text('Task'),),
      body: 
      Container(     
        color:  Color(0XFFF4EAEA),    
         
              child: Container(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                         //padding: EdgeInsets.fromLTRB(20, 20, 25, 15),
                           decoration: new BoxDecoration(
                          color: Colors.white,
                           borderRadius: new BorderRadius.circular(10.0),
                           boxShadow: [
                           BoxShadow(
                                  blurRadius: 4.0,
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(0.5, 0.5),
                                ),
                              ],
                           ),

                child: ListView.builder(
                  
                  itemCount: details.childTask.length,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        
                                              child: ListTile(
                          title: Container(
                             
                           child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                 Text(details.childTask[index].taskName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),),
                                
                                ],

                              ),
                        
                             ClipOval(
                                child: Material(
                                  color: Colors.blue, // button color
                                  child: InkWell(
                                    splashColor: Colors.red, // inkwell color
                                    child: SizedBox(
                                      height: size.height/15,
                                      width: size.width/8,
                                      
                                     child: Icon(
                                       Icons.picture_as_pdf,
                                       
                                       color: Colors.white,
                                       )),
                                    
                                  ),
                                ),
                              )
                            ],
                          ),
                          ),
         ),
                      ),
                    );
                  }
                
                    ),
              )
            
      )
         );     




            }
  
}
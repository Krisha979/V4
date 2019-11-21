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
    DateTime formattedtime = (dateFormatremoveT.parse(time));
    DateFormat longtme = DateFormat.jm();
    time = longtme.format(formattedtime);
    print(time);
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
      appBar: AppBar(title: Text('Task',  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
       backgroundColor: const Color(0xFF9C38FF),),
      body: 
      Container(     
         color: Color(0XFFF4EAEA),    
         
              child: Container(
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
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
                    var statusname = details.childTask[index].statusName;
                    var icon = "assets/snbiztasks.png";
                                      if(statusname.contains("Running")){
                                       icon = "assets/snbizrunning-web.png";
                                          }
                                          else if(statusname.contains("Started")){
                                            icon = "assets/snbizrunning-web.png";
                                          }
                                          else if(statusname.contains("Completed")){
                                            icon = "assets/acceptedtick-web.png";
                                          }else{
                                            icon = "assets/snbizrunning-web.png";
                                          }  
                    return Container(
                      child: Card(
                        elevation: 5,
                        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        
                                              child: ListTile(
                          title: Container(
                             
                           child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                                              child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                   Text(details.childTask[index].taskName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),),
                                    Text(statusname,style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
                                  ],

                                ),
                              ),
                        
                             ClipOval(
                                child: Material(
                                  color: Colors.blue, // button color
                                  child: InkWell(
                                    splashColor: Colors.red, // inkwell color
                                    child: SizedBox(
                                      height: size.width/8,
                                      width: size.width/8,
                                      
                                      
                                      
                                     child:Image(
                        image: new AssetImage(icon),
                        height: size.width / 8,
                        width: size.width/8
                      ),
                       ),
                                    
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
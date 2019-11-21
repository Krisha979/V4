import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:snbiz/Model_code/OrgTask.dart';
import 'package:snbiz/src_code/TaskDetails.dart';
import 'package:snbiz/src_code/static.dart';
import 'package:http/http.dart' as http;

class TaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskState();
  }
}

class TaskState extends State<TaskPage> {
  int count;
  final RefreshController _refreshController = RefreshController();

  Future<List<OrgTask>> _future;
//date time format
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
    print(time);
   
    return time.toString();
  }

  //internet connection  check
   Future<bool> _checkConnectivity()  async{
                        var result =  await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.none){
             
                         return false;
                        }
                        }


//api call to get task task details

Future<List<OrgTask>> getTask()async{
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
                       
                        Navigator.pop(context);
                         Navigator.pop(context);

                       })
                     ],
                   );
                 }

               );
      }else {
  try{
  http.Response data = await http.get(
          Uri.encodeFull(StaticValue.baseUrl + StaticValue.taskurl + StaticValue.orgId.toString()), 
          headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Cache-Control': 'no-cache,private,no-store,must-revalidate'

  }
      );

  var jsonData = json.decode(data.body);
  List <OrgTask> task = [];
  for (var u in jsonData){
      var tasks = OrgTask.fromJson(u);
    task.add(tasks);
  }
print(task.length);
setState(() {
  count = task.length;
});
return task;

}
catch(e){
  print(e);
  return null;

}
      }
}
//initializing the data 
 @override
  void initState() {
    super.initState();
    _future = getTask();
       
  }

String value;
String formatPercent(String fmfamount){
    
  var time = double.parse(fmfamount);
  FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(

    amount:time,
    
    settings: MoneyFormatterSettings( //money format package to separate decimal 
        
        thousandSeparator: ',',
        decimalSeparator: '.',
        symbolAndNumberSeparator: ' ',
    )
);
value = fmf.output.withoutFractionDigits.toString();

}


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

     
    return Scaffold(
      appBar: AppBar(title: Text('Task',  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
       backgroundColor: const Color(0xFF9C38FF),),
    body: SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      onRefresh: () async { //page refresh
        await Future.delayed(Duration(seconds: 2));
        _future = getTask();
        _refreshController.refreshCompleted();
      },
      child: Container(
                 color: Color(0XFFF4EAEA),
          child: Column(
                children: <Widget>[

                  Container(
                width: size.width,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(0.0, 0.5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text("Active TASKS",
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xFFA19F9F),
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(StaticValue.activeTaskcount.toString(),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              'Latest Running Task',
                              style: TextStyle(color: Color(0xFFA19F9F),
                              fontWeight: FontWeight.bold,
                                                        )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              StaticValue.taskName,
                              style: TextStyle(color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                         
                          )],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image(
                        image: new AssetImage("assets/snbiztasks.png"),
                        height: size.height / 10,
                      ),
                    ),
                  ],
                ),
              ),
            Container(
           child: FutureBuilder(
            future: _future,
            builder:(BuildContext context, AsyncSnapshot snapshot){
              switch (snapshot.connectionState) {
              case ConnectionState.none:
                  return Container(
                  child: Center(
                      child:Flexible(child: Text("Try Loading Again.", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal))),
                  )  
                );
              case ConnectionState.active:
              case ConnectionState.waiting:
                    return Container(
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

                  )
                );
              case ConnectionState.done:
              
              if (!snapshot.hasData) {
                          return Container(
                            child: Center(
                              child: Text("Try Loading Again.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)
                                        )
                        )
                        );
                        } else {
                          if(snapshot.data.length == 0){
                            return Container(
                            child: Center(
                              child: Text("No Records Available.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)
                                        )
                        )
                        );}
                return Flexible(
                                child: ListView.builder(
                                  physics: const AlwaysScrollableScrollPhysics(),
                     shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      var firstName = snapshot.data[index].parentTask.fullName  == null ? "-" :
                      snapshot.data[index].parentTask.fullName;
                       var contact = snapshot.data[index].parentTask.contactNumber == null ? "-":
                       snapshot.data[index].parentTask.contactNumber;
                       var startdate = formatDateTime(snapshot.data[index].parentTask.startDate);
                       var name = snapshot.data[index].parentTask.taskName;
                       formatPercent(snapshot.data[index].percentageComplete.toString());
                       var icon = "assets/snbizrunning-web.png";
                       if(snapshot.data[index].percentageComplete == 100){
                         icon = "assets/acceptedtick-web.png";
                         }

                      return ListTile(
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

                           ),
                           child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //showing data in listtile
                                 Flexible(child: Text(startdate, textAlign: TextAlign.left, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)),
                                Flexible(child: Text(name, textAlign: TextAlign.left, style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),)),
                                 Flexible(child: Text(firstName, textAlign: TextAlign.left, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)),
                                  Flexible(child: Text(contact, textAlign: TextAlign.left, style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),)),
                                Flexible(child: Text(snapshot.data[index].parentTask.statusName, textAlign: TextAlign.left, style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal))),
                                Flexible(child: Text(value+ "% Completed", textAlign: TextAlign.left, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
                                color: Color(0xFFA19F9F)
                                ))),

                                ],

                              ),

                             ClipOval(
                                child: Material(
                                  color: Colors.blue, // button color
                                  child: InkWell(
                                    splashColor: Colors.red, // inkwell color
                                    child: SizedBox(width: 56, height: 56,
                                     child: Image(
                        image: new AssetImage(icon),
                        height: size.height / 12,
                      ),),
                                    onTap: () {
                                      Navigator.push(context, CupertinoPageRoute(builder: (context)=> TaskDetailsPage(details:
                                      snapshot.data[index])));
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          ),
                                                ),
                                                onTap: () {
                                          Navigator.push(context, CupertinoPageRoute(builder: (context)=> TaskDetailsPage(details:
                                      snapshot.data[index])));
                                        },
                        ),
           );
                    }
                      ),
                );
              }
            }
            }
           )
        )


                ]),
        ),
    )
         );     




            }
  
}

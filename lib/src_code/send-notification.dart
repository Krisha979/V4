import 'dart:convert';

import 'package:SNBizz/Model_code/Notification.dart';
import 'package:SNBizz/src_code/static.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http ;

class SendNotification extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SendState();
  }
}
class SendState extends State<SendNotification>{
   var ctx;

   //handling back press
  Future<bool> _onBackPressed() async {
   Navigator.pop(ctx);
   Navigator.pop(ctx);
 }
  NotificationModel notification = new NotificationModel();

final notificationbody = TextEditingController();

NotificationModel details;
String lastNotifications = "-";


//api call to get recent sent notification
 Future<List<NotificationModel>> getNotifications() async {
  notification.dateCreated = DateTime.now().toString();
  notification.createdBy = StaticValue.orgId;
  notification.notificationBody = notificationbody.text;
  notification.organizationName = StaticValue.orgName;
  notification.notificationId = 00;
 
   String jsonbody = jsonEncode(notification);

 bool connection = await _checkConnectivity(); //cheeck internet connection
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


      }

      else{

    try {
      http.Response post = await http.post(
            Uri.encodeFull(StaticValue.baseUrl +
                "api/notifications"),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'SentBy': StaticValue.orgUserId.toString(),
              "apikey" : StaticValue.apikey,

             
            },
            
          body: jsonbody);
       print(post);

//check notification check
      if (post.statusCode == 201){
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
                barrierDismissible: true,
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
               
                   });
               
                 });

      }
     
    } catch (e) {
       showDialog(
                 context: context,
                 barrierDismissible: false,
                 builder: (BuildContext context){
                   return AlertDialog(
                     title: Text("Pleasse, Check your internet connection",
                  
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
    }
  }}
  //iinitilizing last notification function
@override
  void initState()  {
    super.initState();  
    lastNotification();
  }

//api call to get last sent notification
Future<List<NotificationModel>> lastNotification() async {

   try {
      http.Response post = await http.get(
            Uri.encodeFull(StaticValue.baseUrl +
               StaticValue.sendNotification)+StaticValue.orgUserId.toString(),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              "apikey" : StaticValue.apikey,

            },);
      if(post.statusCode==404){

        setState(() {
          lastNotifications = null;

        });
      }
      else {
        var jsondata = json.decode(post.body);

        NotificationModel _notification;

        _notification = NotificationModel.fromJson(jsondata);

        setState(() {
          details = _notification;
          lastNotifications = details.notificationBody;
        });
      }
        print(post);
   } catch(e){
     print(e);
   }
}

// internet connection 
Future<bool> _checkConnectivity()  async{
                        var result =  await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.none){
             
                         return false;
                        }
                        }

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(title: Text("Send Notification",  style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
              fontSize: 20),),
               backgroundColor: Color(0xFF9C38FF),
      ),
      body: SingleChildScrollView(
              child: Wrap(
          children: <Widget>[
                Container(
                  color: Color(0XFFE0CECE),
                  width: size.width,
                  height: size.height,

                  child: Container(
                     height: size.height,
                  width: size.width,
                  margin: EdgeInsets.all(8.0),
                  
                  decoration: BoxDecoration(
                    color: Colors.white,
                     borderRadius: new BorderRadius.circular(10.0),

                  ),


                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 35, left: 20),
                            child: Text("Previous Notification Sent", style:
                                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xFF665959)),),
                          ),
                        Expanded(
                                                  child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 15,),
                                child:
                                  lastNotifications == "-" ?
                                  Text("Loading"): lastNotifications == null?
                                  Text("No Recent Notification"):
                                  Text( lastNotifications.toString(),style: TextStyle(fontSize: 16)),
                                  
                              ),
                      width: size.width,
                      //height: size.height/5,
                      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                    ),
                          ),
                        ),

                     Padding(
                            padding: const EdgeInsets.only(top: 30, left: 20),
                            child: Text("Create New Notification", style:
                                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xFF665959)),),
                          ),
                         new Theme(
                                    data: new ThemeData(
                                      hintColor: Color(0xFFF4EAEA),
                                    ),
                                    child: Flexible(
                                                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16, bottom: 0, left: 16, right: 16),
                                        child: TextFormField(
                                          
                                          controller: notificationbody,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 8,
                                          maxLength: 150,
                                         
                                          decoration: new InputDecoration(

                                            hintText: 'Please enter new notificaton', hintStyle: TextStyle(color: Colors.black45, fontSize: 18),
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
                                  ),

                                  Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 60,),
                                          child: RaisedButton(
                                            color: Color(0xFFB56AFF),
                                            onPressed: () {

                         if (notificationbody.text == ""){ // to check empty field
                        showDialog(
                       context: context,
                       barrierDismissible: false,
                       builder: (BuildContext context){
                         return AlertDialog(
                           title: Text("Please enter some message",
                        
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
                                              else
                                              {
                                               showDialog( //loading while uploading 
                                               context: context,
                                                    barrierDismissible: false,
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
                                                        child: Theme(
                                              data: new ThemeData(
                                                hintColor: Colors.white,
                                              ),
                                             child: CircularProgressIndicator(

                                                  strokeWidth: 3.0,
                                                  backgroundColor: Colors.white
                                              ),

                                            ),
                                             )))
                                              );
                                                    });


                                              getNotifications();
                                             
                                            }},
                                            padding: const EdgeInsets.all(0.0),
                                             shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0)),
                                            child: Container(
                                              width: 200,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFFB56AFF),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(8.0))),
                                                padding: const EdgeInsets.fromLTRB(
                                                    20, 10, 20, 5),
                                            child: Center(child: Text("Send",style: TextStyle(color: Colors.white, fontSize: 18))),
                                          ),
                                        ),
                                      )
                                  )
                      ]
                    ),
                  )
                
          ),
        
          ]),
      )
    
    );
  }
}
import 'dart:io';
import 'package:SNBizz/Model_code/meetingStatus.dart';
import 'package:SNBizz/Model_code/model.dart';
import 'package:SNBizz/src_code/page.dart';
import 'package:SNBizz/src_code/static.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:connectivity/connectivity.dart';

import 'package:firebase_messaging/firebase_messaging.dart';


class LoginPage extends StatefulWidget{
        @override
        State createState()=> new LoginPageState();
    }
    bool isLoading = false;
    class LoginPageState extends State<LoginPage> {
      String message;
      final _formKey = GlobalKey<FormState>();
      final emailcontroller = TextEditingController();
      final passwordcontroller = TextEditingController();
      final storage = new FlutterSecureStorage();
      final _scaffoldKey = GlobalKey<ScaffoldState>();
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

      //method to set message according to time
      @override
      void initState() {
      super.initState();
          var currenttime = DateTime.now();
              int hours = currenttime.hour;
              if(hours<=12){
                  message = "Good Morning!";
              }else if(hours<=16){
                  message = "Good Afternoon!";
              }else if(hours<=21){
                  message = "Good Evening!";
              }else if(hours<=24){
                  message = "Good Night!";
              }
      getfromstorage();  
      }

      //function to store email and password on storage
      Future<Null> getfromstorage() async {
      var email = await storage.read(key:"Email");
      var password = await storage.read(key: "Password");
          if(email != null){
              emailcontroller.text = email;
            }
          if(password != null){
            passwordcontroller.text = password;
          }
          if(email!= null && password!=null){
             bool connection = await _checkConnectivity();
             if(connection == true){
              setState(() {
                           isLoading = true; 
                        });
            checkCredentials(email, password);
             }
          }
      }

      //api call to check status

      Future<void> status() async {


    try {

      http.Response data = await http.get(
          Uri.encodeFull(StaticValue.baseUrl + "api/childstatus?id=" +
              StaticValue.meetingstatusId.toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });

      var jsonData = json.decode(data.body);

      for (var u in jsonData) {
        
        var meetingstatus = MeetingStatus.fromJson(u);
        if(!meetingstatus.statusName.contains("Concluded"))
        {
         StaticValue.statuslist.add(meetingstatus);

          }
        
      }

    } catch (e) {
      print(e);
      return null;
    }

  }
// to register device

  Future<bool> registerDevice(String fcmtoken) async{                 
      http.Response response = await http.get(
      Uri.encodeFull(StaticValue.baseUrl + "api/RegisterDevice"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "fcmtoken": fcmtoken,
        "deviceId" : StaticValue.orgRowstamp
              }
              
          );
          if(response.statusCode == 200){
            return true;
          }
          return false;
      }

//api call to get user mail and password for user user authentication
  Future<void> checkCredentials(String email, String password) async{
    var client = new http.Client();

      http.Response response = await client.get(
      Uri.encodeFull(StaticValue.baseUrl + StaticValue.loginurl),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "email": email,
        "password" : password,
        'Cache-Control': 'no-cache,private,no-store,must-revalidate'

      }
      );



      if(response.statusCode == 200){
          print(response.body);
          Map data = await json.decode(response.body);
          var user = UserData.fromJson(data);
          if(user != null){
                if(user.isValidated){
                      StaticValue.orgId= user.organizationId;
                      StaticValue.orgName = user.organizationName;
                      StaticValue.logo = user.logo;
                      StaticValue.userRowstamp=user.userRowstamp;
                      StaticValue.orgUserId=user.userAccountId;
                      StaticValue.orgRowstamp = user.orgRowstamp;
                      StaticValue.vATCredit = user.vatCredit;
                      await storage.write(key: "Email", value: email);
                      await storage.write(key: "Password", value: password);
                      var fcmtoken = await storage.read(key:"fcmtoken");
                      var token = await _firebaseMessaging.getToken();
                      print(token);
                      print(fcmtoken);
                          if(fcmtoken != token){
                          var status = await registerDevice(token);
                          if(status == true){
                              await storage.delete(key: "fcmtoken"); 
                              await storage.write(key: "fcmtoken", value: token);
                          }
                      }
                      setState(() {
                        if(StaticValue.statuslist.isEmpty){
                          status();
                          client.close();
                        }

                       

                                      isLoading = false; 
                                  });
                      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => MainPage()));
                  }
                  else{
                    setState(() {
                                      isLoading = false; 
                                  });
                    await _alert(context, "Opps","You are not validated. Please Validate yourself.");
               }
          }
      }
      else if(response.statusCode == 401){
          setState(() {
                          isLoading = false; 
                      });
          await _alert(context, "Invalid Credentials","Password did not match.");
      }
      else if(response.statusCode == 404){
            setState(() {
                            isLoading = false; 
                        });
            await _alert(context, "Invalid Credentials","Email not found.");
         }
      else{
        setState(() {
                      isLoading = false; 
                  });

        await _alert(context, "Error","Server Error. Connection timed Out.");
      }
    }  
      bool _obscureText = true;
      void _toggle() {
          setState(() {
             _obscureText = !_obscureText;
              }
          );
      }

      //handle on back press
      Future<bool> _onBackPressed() async {
        exit(0);
      }

      @override
      Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
          return WillPopScope(
             onWillPop: _onBackPressed,            

                      child: Scaffold(  
              key: _scaffoldKey,
              body: SingleChildScrollView(
                child:Container(
                    width: size.width ,
                    height: size.height,
                    decoration:new BoxDecoration(
                      gradient: new LinearGradient(colors:[
                        const Color(0xFF9C38FF),
                        const Color(0xFF8551F8),
                      ],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.0,100.0],
                     ),
                    ),
                          
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Image(
                                image: new AssetImage("assets/snbizlogo.png"),
                                height: 140.0,
                                width: 140.0,
                              ),

                            Padding(
                              padding: EdgeInsets.only(top: 4.0),
                            ),
                            Text(
                             "Log In", 
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 30.0
                                ),
                            ),

                            
                                
                            Padding(
                              padding: EdgeInsets.only(top: 40.0),
                            ),
                                  
                            Form(
                              key: _formKey,
                              child:  Wrap(
                                children:<Widget>[
                                  new Container(
                                    margin: EdgeInsets.only(left: 45, right: 45, top: 40),
                                    decoration: new BoxDecoration(
                                      borderRadius: new BorderRadius.all(Radius.circular(10.0),)      
                                    ),                                      
                                    child: isLoading? Center(
                                      child:Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 15),
                                                child: Text(message,textWidthBasis: TextWidthBasis.parent,style: TextStyle(color: Colors.white, fontSize: 15)),
                                              ),
                                             Theme(
                                            data: new ThemeData(
                                              hintColor: Colors.white,
                                            ),
                                           child: CircularProgressIndicator(

                                                strokeWidth: 3.0,
                                                backgroundColor: Colors.white
                                            ),

                                          ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Text("Logging In...",style: TextStyle(color: Colors.white, fontSize: 15)),

                                      )
                                         ],
                                      )
                                    ):

                                  new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                  
                                  Theme(
                                   data: new ThemeData(
                                     hintColor: Colors.white
                                   ),
                                                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white, fontSize: 15),
                                      
                                     enableInteractiveSelection: false,
                                      controller: emailcontroller,
                                      validator: (value) {
                                        // field valdation code here
                                      if (value.isEmpty) {
                                      return 'Please enter some text';
                                      
                                      }
                                      if(!value.contains("@")){
                                      return 'please enter valid email';
                                      }
                                      return null;
                                      },
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                      
                                        
                                        contentPadding: EdgeInsets.only(bottom: 10),
                                        enabledBorder: UnderlineInputBorder(      
                        borderSide: BorderSide(color: Colors.white),   
                        ),  
                focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                     ),  
                                        
                                        labelText: 'Email',  labelStyle: TextStyle(color: Colors.white, fontSize: 17),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.only(left: 0, right: 20),
                                          child: const Icon(
                                            Icons.person,
                                            
                                            color: Colors.white, 
                                            size: 20.0,
                                          ),
                                        ),   
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                     style: TextStyle(color: Colors.white, fontSize: 15),
                                     
                                    
                                    controller: passwordcontroller,
                                      validator: (value) {
                                    if (value.isEmpty) {
                                    return 'Please enter some text';
                                    }
                                  
                                    return null;
                                    },
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(      
                        borderSide: BorderSide(color: Colors.white),   
                        ),  
                focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                     ),  
                                      labelText: 'Password',
                                      labelStyle: TextStyle(color: Colors.white, fontSize: 17),
                                      prefixIcon: Padding(
                                         padding: const EdgeInsets.only(left: 0, right: 20),
                                        child: const Icon(Icons.lock, color: Colors.white, size: 20.0),
                                      ),
                                      suffixIcon: new GestureDetector(
                                        child: new FlatButton(
                                          onPressed: _toggle,
                                            child: new Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.white,),
                                        ),
                                      )

                                    ),
                                    obscureText: _obscureText,
                                  ),
                                 
                                  Padding(
                                    padding: const EdgeInsets.only(top: 80),
                                    child: SizedBox(
                                      height: 40,
                                      width: 170,
                                      child: FlatButton(
                                        color: Colors.white,
                                        textColor: Colors.black,
                                        disabledColor: Colors.grey,
                                        disabledTextColor: Colors.black,
                                        padding: EdgeInsets.all(9.0),
                                        splashColor: Colors.blueAccent,
                                        shape:RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0)
                                        ),
                                        
                                        onPressed: () async {
                                            if (_formKey.currentState.validate())
                                             {
                                          
                                                bool connection = await _checkConnectivity();
                                                if(connection == true)
                                                {
                                                    setState(() {
                                                    isLoading = true; 
                                                    });
                                                    
                                                    var useremail = emailcontroller.text;
                                                    var password = passwordcontroller.text;
                                                      try{
                                                          await storage.write(key: "Email", value: useremail);
                                                          await storage.write(key: "Password", value: password);
                                                    }catch(e)
                                                    {
                                                        print(e.toString());
                                                    }
                                                    await checkCredentials(useremail,password);
                                                }  
                                              }
                                         },
                                        child: Text("Sign In", 
                                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal)),
                                     ),
                                    ),
                                  ),   
                                  ]
                                  ),
                                  ), 
                                  ]  
                                   ),
                                   ),
                                   ],
                                   ),
                                   ],
                                   ),
                 ) 
                
                                
                                 ),
                                 ),
          ); 
                                    
                           }
                       //internet connection check
                       Future<bool> _checkConnectivity() async{
                        var result = await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.none){
                         _scaffoldKey.currentState.showSnackBar(
                          new SnackBar(
                            content: new Text('No Internet Access,Turn on Wifi or connect over mobile data'),
                            duration: Duration(seconds: 3),
                             backgroundColor: Color.fromARGB(80,255, 0, 0)
                          )
                         );
                         return false;
                        }else if (result == ConnectivityResult.mobile){
                        _scaffoldKey.currentState.showSnackBar(
                          new SnackBar(
                            content: new Text('Internet Access, Connected over mobile data'),
                            duration: Duration(seconds: 3),
                             backgroundColor: Color.fromARGB(80,0, 255, 0)
                          )
                        );
                          return true;
                        }else if (result == ConnectivityResult.wifi){
                        // _showDialog("Internet access", "You are connected over wifi");
                        _scaffoldKey.currentState.showSnackBar(
                          new SnackBar(
                            content: new Text('Internet Access, Connected over Wifi'),
                            duration: Duration(seconds: 3),
                             backgroundColor: Color.fromARGB(80,0, 255, 0)
                          )
                          );
                          return true;
                          }
                          return false;
                        }
                        
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
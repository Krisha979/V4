import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:snbiz/Model_code/UserAccount.dart';
import 'package:snbiz/Model_code/profile.dart';
//import 'package:snbiz/Model_code/profilemodel.dart';
import 'package:snbiz/src_code/static.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
 final ProfileModel detail;
 const Profile({Key key, this.detail}):super(key:key);
  
  @override
  ProfileState createState() => new ProfileState(this.detail);

}

String url;

class ProfileState extends State<Profile> {
  

  final ProfileModel details;
  ProfileState(this.details);
  TextEditingController userName;
  final userEmail = TextEditingController();
  final userContact = TextEditingController();
  File _image;
  Future<ProfileModel> profile() async {
    try {
      http.Response data = await http.get(
          Uri.encodeFull(StaticValue.baseUrl +
              "api/OrganizationUserDetails?Orgid=" +
              StaticValue.orgId.toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });

      var jsonData = json.decode(data.body);
      ProfileModel _profile;
      
      


      _profile = ProfileModel.fromJson(jsonData);

      print(_profile);
      return _profile;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserAccount> UpdateDetails () async{

     UserAccount userAccount;
     userAccount.userAccountId = details.userAccountId;
     userAccount.fullName = details.fullName;
     userAccount.contactNumber = details.contactNumber;
     userAccount.email = details.email;
     userAccount.organizationId = details.organizationId;
     userAccount.requestTime = details.requestTime;
     userAccount.changeRequest= details.changeRequest;
     userAccount.dateCreated = details.dateCreated;
     userAccount.rowstamp = details.rowstamp;
     userAccount.isValidated = details.isValidated;
     userAccount.userTypeId = details.userTypeId;
     userAccount.password = details.password;
     userAccount.deleted = details.deleted;
     
    String jsonbody = jsonEncode(userAccount);

    try {
      http.Response data = await http.put(
          Uri.encodeFull(StaticValue.baseUrl + "api/UserAccoounts/" +
             details.userAccountId.toString() 
              ),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonbody);
          if(data.statusCode == 500){
            
          }
    } catch (e) {
      Text("Server error!!");
    }
  }

 @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
        backgroundColor: const Color(0xFF9C38FF),
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(8.0),
              width: size.width,
              color: Color(0xFFF4EAEA),
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.all(8.0),
                  height: size.height / 1.7,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFFFFFFFF)),
                  child: Column(

                      // crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 15),
                          child: InkWell(
                            splashColor: Colors.yellow,
                            
                            child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.blueGrey,
                                child: ClipOval(
                                    child: SizedBox(
                                  height: size.height / 4,
                                  width: size.width / 4,
                                  // child: Image.network(StaticValue.logo),
                                  child: StaticValue.logo == null
                                      ? Icon(
                                          Icons.person,
                                          size: 70,
                                          color: Colors.white,
                                        )
                                      : StaticValue.logo != null
                                          ? Image.network(StaticValue.logo,
                                              fit: BoxFit.cover)
                                          : (Image.file(
                                              _image,
                                              fit: BoxFit.cover,
                                            )),
                                ))),
                          ),
                        ),
                        Text("kathmandu codes pvt.ltd",
                            style: TextStyle(fontSize: 18)),
                        FutureBuilder(
                            future: profile(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              print(snapshot.data);
                             ProfileModel details = snapshot.data;
                              if (details== null) {
                                return Container(
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              } else {
                                if(userName == null){
                                    userName = new TextEditingController(text:details.fullName);
                                    userEmail.text = details.email;
                                  userContact.text = details.contactNumber;
                                }
                                else{
                                   details.email = userEmail.text;
                                   details.contactNumber = userContact.text;
                                  details.fullName = userName.text;
                                }
                        
                                return Container(
//color: Colors.blueGrey,

                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 15, 0, 0),
                                    child: Text(
                                      "ORGANIZATION PROFILE",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 15, 0, 0),
                                    child: Text("Organization Name"),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                    child: Text(
                                      details.organizationName,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 28),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text("Vat/Pan number"),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                    10, 5, 10, 5),
                                                ),
                                                Text(details.taXPAN),
                                              ]),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text("Organization phone"),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                ),
                                                Text(
                                                    details.organizationNumber),
                                              ])
                                        ]),
                                  )
                                ],
                              ));
                            }
                          })
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  height: size.height / 1.9,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFFFFFFFF)),
                  child: FutureBuilder(
                      future: profile(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        print(snapshot.data);
                        
                        ProfileModel details = snapshot.data;
                        
                        if (details == null) {
                          return Container(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        } else {
                        
                          return Container(

                            
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 15, 0, 0),
                                  child: Text(
                                    "User Name",
                                    
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Container(
                                    height: size.height / 20,
                                    width: size.width,
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    // color: Colors.white,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Color(0xFFd6d6d6)),
                                    child: TextFormField(
                                      
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 11,
                                            top: 11,
                                            right: 15),
                                      ),
                                      controller: userName,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 15, 0, 0),
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: size.height / 20,
                                  width: size.width,
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  // color: Colors.white,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Color(0xFFd6d6d6)),
                                  child: TextFormField(
                                    controller: userEmail,
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                    ),
                                   // controller: userContact,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 15, 0, 0),
                                  child: Container(
                                    child: Text(
                                      "Contact Number",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: size.height / 20,
                                  width: size.width,
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  // color: Colors.white,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Color(0xFFd6d6d6)),
                                  child: TextFormField(
                                    
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                    ),
                                    controller: userContact,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 15, right: 15),
                                  child: MaterialButton(
                                      height: 40,
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            });

                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      textColor: Colors.white,
                                      color: Color(0xFFB56AFF),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Center(
                                        child: Text('save',
                                            style: TextStyle(fontSize: 16)),
                                      )),
                                ),
                              ]));
                        }
                      }),
                )
              ]))),
    );
  }
  

}



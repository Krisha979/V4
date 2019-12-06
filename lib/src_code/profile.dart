import 'dart:convert';
import 'package:SNBizz/Model_code/UserAccount.dart';
import 'package:SNBizz/Model_code/profile.dart';
import 'package:SNBizz/src_code/static.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => new ProfileState();
}

class ProfileState extends State<Profile> {
  ProfileModel details;
  final RefreshController _refreshController = RefreshController();
  TextEditingController userName;
  TextEditingController userEmail;
  TextEditingController userContact;

//api call to get organization details
  Future<ProfileModel> profile() async {
    try {
      http.Response data = await http.get(
          Uri.encodeFull(StaticValue.baseUrl +
            StaticValue.profile_modelurl +
              StaticValue.orgId.toString()),

          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "apikey" : StaticValue.apikey,
            'Cache-Control': 'no-cache,private,no-store,must-revalidate'
          });

      var jsonData = json.decode(data.body);
      ProfileModel _profile;

      _profile = ProfileModel.fromJson(jsonData);
      setState(() {
        details = _profile;
        userName = new TextEditingController(text: details.fullName);
        userEmail = new TextEditingController(text: details.email);
        userContact = new TextEditingController(text: details.contactNumber);
      });
      print(_profile);
      return _profile;
    } catch (e) {
      print(e);
      return null;
    }
  }


//api call to put users details
  // ignore: non_constant_identifier_names
  Future<bool> UpdateDetails() async {
    UserAccount userAccount = new UserAccount();
    userAccount.userAccountId = details.userAccountId;
    userAccount.fullName = userName.text == null ? "--" : userName.text;
    userAccount.contactNumber = userContact.text == null ? "--" :userContact.text;
    userAccount.email = userEmail.text == null ? "--" : userEmail.text;
    userAccount.organizationId = details.organizationId;
    userAccount.requestTime = details.requestTime;
    userAccount.changeRequest = details.changeRequest;
    userAccount.dateCreated = details.dateCreated;
    userAccount.rowstamp = details.rowstamp;
    userAccount.isValidated = details.isValidated;
    userAccount.userTypeId = details.userTypeId;
    userAccount.password = details.password;
    userAccount.deleted = details.deleted;

    String jsonbody = jsonEncode(userAccount);

    try {
      http.Response data = await http.put(
          Uri.encodeFull(StaticValue.baseUrl +
              StaticValue.profilePerson_url +
              details.userAccountId.toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonbody);
      if (data.statusCode == 500) {
        return false;
      }
      return true;
    } catch (e) {
      Text("Server error!!");
      return false;
    }
  }



  @override
  void initState() {
    super.initState();
    profile();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (details != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Profile",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
          backgroundColor: const Color(0xFF9C38FF),
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: () async { //page refresh
            await Future.delayed(Duration(seconds: 2));
            profile();
            _refreshController.refreshCompleted();
          },
          child: SingleChildScrollView(
            child: Container(
              width: size.width,
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Color(0xFFF4EAEA),
              ),
              child: Column(
                children: <Widget>[
                  Wrap(
                    children: <Widget>[
                                       Container(
                      margin: EdgeInsets.all(8.0),
                   
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 15),
                            child: InkWell(
                              splashColor: Colors.yellow,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor:  Color(0xFFFBF4F4),
                                child: ClipOval(
                                  child: SizedBox(
                                    height: size.height / 4,
                                    width: size.height / 4,
                                    child: StaticValue.logo == null
                                        ? Icon(
                                            Icons.person,
                                            size: 70,
                                            color: Colors.white
                                          )
                                        : StaticValue.logo != null
                                            ? Image.network(StaticValue.logo,
                                                fit: BoxFit.cover)
                                            : Icon(Icons.person)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(StaticValue.orgName,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold)),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 100),
                                  child: Text(
                                    "ORGANIZATION PROFILE",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF665959)),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 40),
                                  child: Text(
                                    "Organization Name",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFFA19F9F)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5, right: 40),
                                  child: Text(
                                    details.organizationName == null ? "--" : details.organizationName,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 40),
                                  child: Text(
                                    "Vat/Pan number",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFFA19F9F)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5, right: 40),
                                  child: Text(
                                    details.taXPAN == null ? "--" : details.taXPAN,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 60),
                                  child: Text(
                                    "Organization phone",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFFA19F9F)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5, right: 60),
                                  child: Text(
                                    details.organizationNumber == null ? "--" : details.organizationNumber ,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ])
                        ],
                      ),
                    ),
                    ]),
                  Wrap(
                    children: <Widget>[
                                      Container(
                      margin:
                          EdgeInsets.only(top: 2, left: 8, right: 8.0, bottom: 8),
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                            child: Text(
                              "USER DETAILS",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF665959)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                            child: Text(
                              "User Name",
                              style:
                                  TextStyle(fontSize: 14, color: Color(0xFFA19F9F)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              height: size.height / 20,
                              width: size.width,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color(0xFFFBF4F4)),
                                  
                              child: TextFormField(
                                
                               // maxLength: 30,
                                decoration: new InputDecoration(
                                
                                  
                                  border: InputBorder.none,
                                  
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 10, left: 10)

                                    ,
                                ),
                                controller: userName,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                            child: Text(
                              "Email",
                              style:
                                  TextStyle(fontSize: 14, color: Color(0xFFA19F9F)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              //height: size.height / 18,
                              width: size.width,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color(0xFFFBF4F4)),
                              child: Wrap(
                                children: <Widget>[
                                                              TextFormField(
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10)
                                  ),
                                 controller: userEmail,
                                ),
                                ]),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                            child: Container(
                              child: Text(
                                "Contact Number",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xFFA19F9F)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: size.height / 20,
                              width: size.width,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color(0xFFFBF4F4)),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10)
                                ),
                                controller: userContact,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10, left: 15, right: 15),
                            child: MaterialButton(
                                height: 40,
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return Center(
                                          child: Theme(
                                        data: new ThemeData(
                                          hintColor: Colors.white,
                                        ),
                                       child: CircularProgressIndicator(

                                            strokeWidth: 3.0,
                                            backgroundColor: Colors.white
                                        ),

                                      ),
                                        );
                                      });

                                      //to check user dtails update
                                  bool success = await UpdateDetails();
                                  if (success == true) {
                                    await _showDialog(
                                        "Details Updated Successfully!");
                                  } else {
                                    await _showDialog(
                                        "Sorry! Could not update details");
                                  }

                                  Navigator.pop(context);
                                },
                                textColor: Colors.white,
                                color: Color(0xFFB56AFF),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Center(
                                  child: Text('save',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal)),
                                )),
                          ),
                        ],
                      ),
                    ),
                    ])
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text("Profile",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
            backgroundColor: const Color(0xFF9C38FF),
          ),
          body: Container(
            child:Theme(
                                        data: new ThemeData(
                                          hintColor: Colors.white,
                                        ),
                                       child: Center(
                                         child: CircularProgressIndicator(

                                              strokeWidth: 3.0,
                                              backgroundColor: Colors.white
                                          ),
                                       ),

                                      ),),
          );
    }
  }

  Future _showDialog(String message) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
            actions: <Widget>[
              FlatButton(
                  child: Text("Ok"),
                  onPressed: () => Navigator.pop(context, true))
            ],
          );
        });
  }
}

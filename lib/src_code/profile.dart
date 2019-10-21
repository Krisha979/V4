import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:snbiz/Model_code/profile.dart';
//import 'package:snbiz/Model_code/profilemodel.dart';
import 'package:snbiz/src_code/static.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

String url;

class ProfileState extends State<Profile> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    // var image2 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      url = image.path;
      //  _image= image2;
    });
  }

  Future getImage2() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // var image2 = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      //  _image= image2;
    });
  }

  Future<ProfileModel> profile() async {
    try {
      http.Response data = await http.get(
          Uri.encodeFull(StaticValue.baseUrl +
              "api/OrganizationDetails/" +
              StaticValue.orgId.toString()),
          headers: {
            'Content-type': 'application/json', 'Accept': 'application/json'
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
        backgroundColor: const Color(0xFF9C38FF),
      ),

      /*body: Container(
        
               
                      child: Column(
                        children: <Widget>[

                        Text(profileDetails.organizationName),
                       
                          
                                  //Flexible(
                                    //  child: Text()),
                                 
                        ]  
                              ),
                            
                          )*/

      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(8.0),
              height: size.height,
              width: size.width,
              color: Color(0xFFF4EAEA),
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.all(8.0),
                  height: size.height / 2.2,
                  width: size.width,

                  // margin: EdgeInsets.all(8),
                  // color: Colors.red,
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
                            onLongPress: () {
                              _showDialog();
                            },
                            child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.blueGrey,
                                child: ClipOval(
                                    child: SizedBox(
                                  height: size.height / 4,
                                  width: size.width / 4,
                                  // child: Image.network(StaticValue.logo),
                                  child: _image == null
                                      ? Icon(
                                          Icons.person,
                                          size: 70,
                                          color: Colors.white,
                                        )
                                      :
                                       _image != null ?  Image.network(StaticValue.logo, fit: BoxFit.fill):

                                      (Image.file(
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
                              if (snapshot.data == null) {
                                return Container(
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              } else {
                                return Container(
//color: Colors.blueGrey,

                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          65, 15, 0, 0),
                                      child: Text(
                                        "ORGANIZATION PROFILE",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          65, 15, 0, 0),
                                      child: Text("Organization Name"),

                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          65, 10, 0, 0),
                                      child: Text(
                                        details.organizationName,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25),
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
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 5, 10, 5),
                                                  ),
                                                  Text(details.taXPAN),
                                                ]),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text("Organization phone"),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 5, 10, 0),
                                                  ),
                                                  Text(details
                                                     .organizationNumber),
                                                ])
                                          ]),
                                    )
                                  ],
                                ));
                              }
                            }),
                      ]),
                ),
                
                 Container(
                   color: Colors.red,
                   child: FutureBuilder(
                      future: profile(),
                      builder:
                                  (BuildContext context, AsyncSnapshot snapshot) {

                                     print(snapshot.data);
                                ProfileModel details = snapshot.data;
                                if (snapshot.data == null) {
                                  return Container(
                                      child: Center(
                                          child: CircularProgressIndicator()));
                                } else {
                                    return Container(
                                   child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            65, 15, 0, 0),
                                        child: Text(
                                          "User Name",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                        Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            65, 10, 0, 0),
                                        child: Text(
                                          details.contactNumber,
                                        ),
                                      ),
                     
                                      ]
                                      )  );}              }
                   ),
                 )
              ]))),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Center(child: new Text("Change Profile Photo")),
          content: Container(
         
            height: 50,
            width: 50,
            child: ListView(
              children: <Widget>[
                Column(children: <Widget>[
                  InkWell(
                      onTap: () {
                        getImage2();
                        Navigator.pop(context);
                      },
                      child: new Text("Upload from gallery")),
                  Divider(),
                  InkWell(
                      onTap: () {
                        getImage();
                        Navigator.pop(context);
                      },
                      child: new Text("Upload from Camera"))
                ])
              ],
            ),
          ),
        );
      },
    );
  }
}

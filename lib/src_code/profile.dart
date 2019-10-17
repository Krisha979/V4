import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:snbiz/Model_code/profilemodel.dart';
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

  Future<CreateProfile> profile() async {
    try {
      http.Response data = await http.get(
          Uri.encodeFull(StaticValue.baseUrl +
              "api/OrganizationDetails/" +
              StaticValue.orgId.toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });

      var jsonData = json.decode(data.body);
      CreateProfile _profile;

      _profile = CreateProfile.fromJson(jsonData);

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
          color: Color(0xFFd6d6d6),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(8.0),
                height: size.height / 2,
                width: size.width,

                // margin: EdgeInsets.all(8),
                // color: Colors.red,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white),
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
                                    // _image != null ?  Image.network(StaticValue.logo, fit: BoxFit.fill):

                                    (Image.file(
                                        _image,
                                        fit: BoxFit.cover,
                                      )),
                              ))),
                        ),
                      ),
                      Text("kathmandu codes pvt.ltd",
                          style: TextStyle(fontSize: 20)),
                     
                         
                          
                             FutureBuilder(
                                future: profile(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  print(snapshot.data);
                                  CreateProfile details = snapshot.data;
                                  if (snapshot.data == null) {
                                    return Container(
                                        child: Center(
                                            child:
                                                CircularProgressIndicator()));
                                  } else {
                                    return Container(
//color: Colors.blueGrey,

                                        child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                         Padding(
                                            padding: const EdgeInsets.fromLTRB(35, 15, 0, 0),
                                           child: Text(
                            "ORGANIZATION PROFILE",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                                         ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(35, 15, 0, 0),
                                          child: Text("Organization Name"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(35, 10, 0, 0),
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                  Text("organization email"),
                                                  Padding(
                                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                  ),
                                                  Text(details.organizationEmail),
                                                ]),

                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                  Text("Organization phone"),
                                                  Padding(
                                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                  ),
                                                  Text(
                                                      details.organizationNumber),
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
                margin: EdgeInsets.all(8.0),
                height: size.height / 2.2,
                width: size.width,
                // color: Colors.yellow,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 0, 10),
                      child: Text(
                        "User Details",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                      child: Text("User Name"),
                    ),
                    Center(
                      child: Container(
                        height: size.height / 16,
                        width: size.width,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        // color: Colors.white,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Color(0xFFd6d6d6)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Center(
                      child: RaisedButton(
                        onPressed: () {},
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Container(
                            height: size.height / 16,
                            width: size.width / 1.3,
                            decoration: const BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Center(
                              child:
                                  Text('Save', style: TextStyle(fontSize: 18)),
                            )),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )));
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Change Profile Photo"),
          content: Container(
            height: 100,
            width: 100,
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

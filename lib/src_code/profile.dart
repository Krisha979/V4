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
          Uri.encodeFull(
              "https://s-nbiz.conveyor.cloud/api/OrganizationDetails/" +
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
          title: Text("Profile"),
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
            
            InkWell(
                splashColor: Colors.yellow,
                onLongPress: () {
                  _showDialog();
                },
               
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      
                      child: SizedBox(
                            height: size.height/4,
                            width: size.width/4,
                     // child: Image.network(StaticValue.logo),      
                    child: _image == null

                        ? Icon(Icons.people) : 
                       // _image != null ?  Image.network(StaticValue.logo, fit: BoxFit.fill):

                       (Image.file(
                            _image,fit: BoxFit.fill,
                           
                          )), 

                          

                          

                      )
                    )

                          
                  ),
                ),
            FutureBuilder(
                future: profile(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  CreateProfile details = snapshot.data;
                  if (snapshot.data == null) {
                    return Container(
                        child: Center(child: CircularProgressIndicator()));
                  } else {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Text(details.organizationName),
                          Text(details.organizationEmail),
                          Text(details.organizationNumber),
                        ],
                      ),
                    );
                  }
                })
          ]),
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

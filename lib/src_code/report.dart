import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Report extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   
    return ReportState();
  }

}

class ReportState extends State<Report>{
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("Report",style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
          backgroundColor: const Color(0xFF9C38FF),),);
  }

}
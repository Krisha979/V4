import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class PrivacyWebView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    
    return PrivacyWebViewState();
  }


}

class PrivacyWebViewState extends State<PrivacyWebView>{
  @override
  Widget build(BuildContext context) {
   
    return  WebviewScaffold(   //package to view web 
      url: 'http://snbiznepal.com/wp-content/uploads/2019/08',
      hidden: true,
      appBar: AppBar(title: Text("Privacy Policy", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
      backgroundColor: const Color(0xFF9C38FF),),
    );
  }

}
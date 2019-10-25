import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class WebView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    
    return WebViewState();
  }


}

class WebViewState extends State<WebView>{
  @override
  Widget build(BuildContext context) {
   
    return  WebviewScaffold(
      url: 'https://snbiznepal.com',
      hidden: true,
      appBar: AppBar(title: Text("About SN Business", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
      backgroundColor: const Color(0xFF9C38FF),),
    );
  }

}
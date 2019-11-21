import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:snbiz/src_code/static.dart';


class WebView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    
    return WebViewState();
  }


}

class WebViewState extends State<WebView>{
  @override
  Widget build(BuildContext context) {
   
<<<<<<< HEAD
    return  WebviewScaffold( 
      url: 'https://snbiznepal.com', 
=======
    return  WebviewScaffold(
      url: StaticValue.webviewUrl,
>>>>>>> fdb6595fb3a1e9f4165b3522c86139c9aa3670a4
      hidden: true,
      appBar: AppBar(title: Text("About SN Business", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
      backgroundColor: const Color(0xFF9C38FF),),
    );
  }

}
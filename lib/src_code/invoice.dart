import 'package:flutter/material.dart';
//import 'menu.dart';
//import 'page.dart';

class Invoice extends StatefulWidget{
  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
//    Future<List<NotificationModel>> getNotifications()async{
//   try{
//   http.Response data = await http.get(
//           Uri.encodeFull("https://s-nbiz.conveyor.cloud/" + "api/RecentNotifications?Orgid=" + StaticValue.orgId.toString()), 
//           headers: {
//         'Content-type': 'application/json',
//         'Accept': 'application/json' 
//         }
//       );
//   var jsonData = json.decode(data.body);
//   List <NotificationModel> notifications = [];
//   for (var u in jsonData){
//       var notification = NotificationModel.fromJson(u);
//     notifications.add(notification);
//   }
// print(notifications.length);
// latestid = notifications[0].notificationId; 
// print(latestid);
// StaticValue.latestNotificationId = int.parse(await storage.read(key:"LatestNotificationId"));
// print(StaticValue.latestNotificationId);
// return notifications;
 
// }
// catch(e){
//   print(e);
//   return null;

// }
// }
  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
            backgroundColor: const Color(0xFF9C38FF),),
    

    body: SingleChildScrollView(
      child: Container(
        height: size.height,
        width: size.width,
        color: Color(0xFFd6d6d6),

        child: Column(
          children: <Widget>[
            Card(
                          child: Container(
                height: size.height/8,
                width: size.width,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Text("All Invoices"),
                  ],
                ),
              ),
            ),

            Card(
                child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("dfbfbdf"),
                    Icon(Icons.picture_as_pdf)
                  ],
                ),
              ),
            ),

            
          ],
        ),
        
      ),
    )
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:snbiz/Model_code/InvoiceModel.dart';
import 'package:snbiz/src_code/static.dart';

class Invoice extends StatefulWidget {
  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  int invoicenumber;

  Future<List<InvoiceModel>> getInovoices() async {
    try {
      http.Response data = await http.get(
          Uri.encodeFull(StaticValue.baseUrl +
              "api/OrgInvoices?Orgid=" +
              StaticValue.orgId.toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      var jsonData = json.decode(data.body);
      List<InvoiceModel> invoices = [];
      for (var u in jsonData) {
        var notification = InvoiceModel.fromJson(u);
        invoices.add(notification);
      }
      print(invoices.length);

      setState(() {
        invoicenumber = invoices.length;
      });
      return invoices;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: (AppBar(
        title: Text(
          'Invoice',
          style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
              fontSize: 19),
        ),
        backgroundColor: Color(0xFF9C38FF),
      )),
      body: Container(
        height: size.height,
        width: size.width,
        color: Color(0xFFE0CECE),
        child: Column(
          children: <Widget>[
            Container(
              height: size.height / 4.6,
              width: size.width,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("All Invoices"),
                                  Text('$invoicenumber'),
                                 Row(
                                   children: <Widget>[
                                     Image(image: new AssetImage("assets/due.png"),),
                                     Text("due remaining")
                                   ],
                                 ),
                                  

                                ],
                                

                              ),
                            Image(
                                      image: new AssetImage("assets/invoice.png"),
                                      height: size.height / 9,
                                    ),
                            ],
                          ),

            ),
            Container(
              height: size.height / 1.7,
              width: size.width,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                //  borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      child: FutureBuilder(
                          future: getInovoices(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            print(snapshot.data);
                            if (snapshot.data == null) {
                              return Container(
                                  child: Center(
                                      child: CircularProgressIndicator()));
                            } else {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var name = snapshot.data[index].invoiceName;
                                    return Container(
                                      child: Card(
                                        elevation: 5,
                                        margin: EdgeInsets.fromLTRB(
                                            10.0, 10.0, 10.0, 0.0),
                                        child: ListTile(
                                          title: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      "bhawana",
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            20, 10, 0, 0),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20),
                                                    child: new Image(
                                                        image: new AssetImage(
                                                            "assets/invoice1.png"),
                                                        height:
                                                            size.height / 12,
                                                        width: size.width / 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                          })),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
//import 'package:intl/intl.dart';
import 'package:snbiz/Model_code/InvoiceModel.dart';
import 'package:snbiz/src_code/static.dart';

class Invoice extends StatefulWidget {
  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  int invoicenumber;

  Future<List<InvoiceModel>> _future;
  Future<bool> _checkConnectivity()  async{
                        var result =  await Connectivity().checkConnectivity();
                        if (result == ConnectivityResult.none){
             
                         return false;
                        }
                        }

  Future<List<InvoiceModel>> getInovoices() async {
    bool connection = await _checkConnectivity();
      if(connection == false){
                   showDialog(
                 context: context,
                 barrierDismissible: false,
                 builder: (BuildContext context){
                   return AlertDialog(
                     title: Text("Please, check your internet connection",
                  
                     style: TextStyle(color:Color(0xFFA19F9F,),
                     fontSize: 15,
                     fontWeight: FontWeight.normal),),
                     actions: <Widget>[
                       FlatButton(child: Text("OK"),
                       onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                       })
                     ],
                   );
                 }

               );
      }else {
    try {
      http.Response data = await http.get(
          Uri.encodeFull(StaticValue.baseUrl +
             StaticValue.create_invoiceurl +
              StaticValue.orgId.toString()),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Cache-Control': 'no-cache,private,no-store,must-revalidate'

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
  }

  @override
  void initState() {
    super.initState();
    _future = getInovoices();
       
  }

  @override 
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //Size size = MediaQuery.of(context).size;
    
    String fmfamount ;
    if(StaticValue.totalPaymentDue.contains('-')){
fmfamount="0";
}
else{
  var time = double.parse(StaticValue.totalPaymentDue);
  FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(

    amount:time,
    settings: MoneyFormatterSettings(
        
        thousandSeparator: ',',
        decimalSeparator: '.',
        symbolAndNumberSeparator: ' ',
        fractionDigits: 2,
        //compactFormatType: CompactFormatType.sort
    )
);
if(fmf.output.fractionDigitsOnly.toString().contains("00"))
{
fmfamount = fmf.output.withoutFractionDigits.toString();
}else{
fmfamount = fmf.output.nonSymbol.toString();

}
}
//print(fmf);

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
          color: Color(0XFFF4EAEA),
        child: Column(
          children: <Widget>[
            Container(
             width: size.width,
              margin: EdgeInsets.fromLTRB(10,10,10,0),
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              decoration: new BoxDecoration(
                            color: Colors.white,
                             borderRadius: new BorderRadius.circular(10.0),
                             boxShadow: [
                             BoxShadow(
                                    blurRadius: 4.0,
                                    color: Colors.black.withOpacity(0.5),
                                    offset: Offset(0.0, 0.5),
                                  ),
                                ],
                             ),
           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              
                              Flexible(
                                                              child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Text("Last invoice date",style: TextStyle(
                                      fontSize: 18, color: Color(0xFFA19F9F),
                                      fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Text(StaticValue.lastInvoiceDate,style: TextStyle(
                                      fontSize: 14, color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                                    ),

                                       Padding(
                                         padding: const EdgeInsets.only(left: 30),
                                         child: Text("Due Remaining",style: TextStyle(
                                      fontSize: 14, color: Color(0xFFA19F9F),
                                      fontWeight: FontWeight.bold)),
                                       ),
                                       
                                    
                                   
                                   Padding(
                                         padding: const EdgeInsets.only(left: 30),
                                         child: Text('Rs '+ fmfamount ,style: TextStyle(
                                      fontSize: 14, color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                                       )
                                    

                                  ],
                                  

                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Image(
                                        image: new AssetImage("assets/snbizinvoice.png"),
                                        height: size.height / 10,
                                      ),
                            ),
                            ],
                          ),

            ),
            Flexible(
              child: Container(
                width: size.width,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                        child: FutureBuilder(
                            future: _future,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              switch (snapshot.connectionState) {
              case ConnectionState.none:
                  return Container(
                  child: Center(
                      child:Flexible(child: Text("Try Loading Again.", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal))),
                  )  
                );
              case ConnectionState.active:
              case ConnectionState.waiting:
                    return Container(
                  child: Center(

                   child: Theme(
                                        data: new ThemeData(
                                          hintColor: Colors.white,
                                        ),
                                       child: CircularProgressIndicator(

                                            strokeWidth: 3.0,
                                            backgroundColor: Colors.white
                                        ),

                                      ),

                  )
                );
              case ConnectionState.done:
             if (!snapshot.hasData) {
                          return Container(
                            child: Center(
                              child: Text("Try Loading Again.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)
                                        )
                        )
                        );
                        } else {
                          if(snapshot.data.length == 0){
                            return Container(
                            child: Center(
                              child: Text("No Records Available.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)
                                        )
                        )
                        );}
                                return ListView.builder(
                                  physics: const AlwaysScrollableScrollPhysics(),
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
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        name,
                                                        style: TextStyle(
                                                            fontStyle:
                                                                FontStyle.normal,
                                                            fontSize: 17,
                                                            fontWeight: FontWeight
                                                                .normal),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 20, 0, 20),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: new Image(
                                                          image: new AssetImage(
                                                              "assets/snbizinvoice.png"),
                                                          height: 60,
                                                              
                                                          width: 60),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              
                              }}
                              return Container(
                  child: Center(
                      child:Flexible(child: Text("Try Loading Again.", textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal))),
                  )  
                );
                            })),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

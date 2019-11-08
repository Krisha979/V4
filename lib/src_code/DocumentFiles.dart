import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:snbiz/Model_code/DocumentModel.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentFilesPage extends StatefulWidget {
  final DocumentModel details;
  const DocumentFilesPage({Key key, this.details}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DocumentFilesState(this.details);
  }
}

class DocumentFilesState extends State<DocumentFilesPage> {
  final DocumentModel details;
  DocumentFilesState(this.details);
  String documentUrl;
  String formatDateTime(String date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime format = (dateFormat.parse(date));
    DateFormat longdate = DateFormat("EEEE, MMM d, yyyy");
    date = longdate.format(format);
    return date;
  }

  String formatTime(String time) {
    DateFormat dateFormatremoveT = DateFormat("yyyy-MM-ddTHH:mm:ss");
    
    DateTime formattedtime = (dateFormatremoveT.parse(time));
    DateFormat longtme = DateFormat.jm();
    time = longtme.format(formattedtime);
    print(time);
    
    return time.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
  return Scaffold(
        appBar: AppBar(
        backgroundColor: Color(0xFF9C38FF),
          title: Text('Documents', style: TextStyle(
          color: Colors.white, fontStyle: FontStyle.normal,
           fontWeight: FontWeight.normal, fontSize: 19),),
        ),
        body: Container(
          color: Color(0XFFE0CECE),
            child: ListView.builder(
              
                itemCount: details.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  var url = details.documents[index].documentURL;
                  return GestureDetector(
                    onTap: (){
                       launch('$url');

                    },
                                      child: Container(
                     // padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Card(
                            elevation: 5,
                            margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),

                            child: ListTile(
                              title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    // Padding(
                                    //   padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                                    // ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                        InkWell(
                                          child: Text(
                                         ( details.documents[index].fileName == null)?details.documents[index].documentURL.substring(details.documents[index].documentURL.lastIndexOf('/')+1):
                                         details.documents[index].fileName,

                                          
                                            textAlign: TextAlign.left,
                                          style: TextStyle(
                                                 fontStyle: FontStyle.normal,
                                                 fontSize: 14,
                                                 fontWeight: FontWeight.normal),
                                           ),
                                          onTap: () {
                                            launch('$url');
                                          },
                                        ),
                                        Text(formatDateTime(details.documents[index].dateCreated),
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFFA19F9F),
                                          fontSize: 14
                                        ),),
                                   
                                          ]),
                                      ),
                                        Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                  height: size.height / 12,
                                  width: size.height / 12,
                                  

                          child: url.contains(".jpeg") 
                                          ? Image.network(details.documents[index].documentURL,
                                             fit: BoxFit.cover,
                                             ): url.contains(".webp") 
                                          ? Image.network(details.documents[index].documentURL,
                                             fit: BoxFit.cover,
                                             )
                                             :  Image(
                        image: new AssetImage("assets/pdf.png"),
                        height: size.height / 10,
                      ),

                                      
                                        

                                     )
                                    
                                        
                                      ]
                                      )
                                      ]
                                      )
                                  ),
                        ),
                              ),
                  ); 
                }
            )
            )
                          );
  
  }
}

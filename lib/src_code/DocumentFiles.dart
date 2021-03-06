import 'package:SNBizz/Model_code/DocumentModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
  return Scaffold(
        appBar: AppBar(
        backgroundColor: Color(0xFF9C38FF),
          title: Text(details.documents[0].fileTypeName, style: TextStyle(
          color: Colors.white, fontStyle: FontStyle.normal,
           fontWeight: FontWeight.normal, fontSize: 20),),
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
                                         ( details.documents[index].fileName == null)? //to check if file name is null then show the last index of filename
                                         details.documents[index].documentURL.substring(details.documents[index].documentURL.lastIndexOf('/')+1):
                                         details.documents[index].fileName,

                                          
                                            textAlign: TextAlign.left,
                                          style: TextStyle(
                                                 fontStyle: FontStyle.normal,
                                                 fontSize: 16,
                                                 fontWeight: FontWeight.normal),
                                           ),
                                          onTap: () {
                                            launch('$url');  // to open uploaded document
                                          },
                                        ),
                                   //     Text(formatDateTime(details.documents[index].dateCreated),
                                     //   style: TextStyle(
                                   //       fontWeight: FontWeight.normal,
                                     //     color: Color(0xFFA19F9F),
                                      //    fontSize: 14
                                       // ),),
                                   
                                          ]),
                                      ),
                                        Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                  height: size.height / 12,
                                  width: size.height / 12,
                                  

                                  //to check the extension of image and show the icon as per the extension
                                  //pdf then pdf icon other wise generic icon 


                          child: url.contains(".jpeg") 
                                          ? Image.network(details.documents[index].documentURL,
                                             fit: BoxFit.cover,
                                             ): url.contains(".webp") 
                                          ? Image.network(details.documents[index].documentURL,
                                             fit: BoxFit.cover,
                                             ): url.contains(".mp4")
                                             ? Image(
                        image: new AssetImage("assets/mp4-icon.jpg"),
                        height: size.height / 10,
                      ): url.contains(".mp3")
                                             ? Image(
                        image: new AssetImage("assets/mp4-icon.jpg"),
                        height: size.height / 10,
                      ) : url.contains(".pdf") ?
                       Image(
                         image: new AssetImage("assets/pdf.png"),
                         height: size.height / 10,
                       ): Image( 
                         image: new AssetImage("assets/docnew.png"),height: size.height/10,)
                     
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
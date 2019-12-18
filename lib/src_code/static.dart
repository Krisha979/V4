import 'dart:io';

import 'package:SNBizz/Model_code/meetingStatus.dart';
import 'package:flutter/material.dart';

class StaticValue
{
//mainpage
  static bool shownotificationReceived = true;
  static bool Tasknotification = false;
  static bool Documentnotification = false;
  //login
  static int orgId;
  static String orgName;
  static String logo;
  static int orgUserId;
  static String userRowstamp;
  static String orgRowstamp;
  static List<MeetingStatus> statuslist = [];
   static final String loginurl = "api/UserAuthentication";

  //home baseurl
  static final String home_url="api/OrganizationDashboard?Orgid=" ;

  //image previewurl
  static final String previewurl = "api/UploadDocuments?Orgid=" ;

  static final String baseUrl = "https://s-nbiz.conveyor.cloud/";
  //static final String baseUrl = "http://snbizadmin.azurewebsites.net/";

  //notification
  static final String notification_url = "api/RecentOrgNotifications?Orgid=";
  static int latestNotificationId;

  //meeting details
   static final String meeeetingDetails_url = "api/Meetings/" ;

   //multiple image_picker
   static final String multipleimage_url =  "api/UploadDocuments?Orgid=";
  
  //create invoiceurl
  static final String create_invoiceurl =  "api/OrgInvoices?Orgid=";

  //apikey
  static final String apikey = "41V3av8BbTKA98Vv8Er/i20UTT3jZHLisRY2g7RqnIF7h8J55O9o/M2AwZ/zBHLR";



  //meeting
  static final String meeting_url = "api/OrgMeetings?Orgid=";
  static int meetingScheduledId = 4;
  static int meetingstatusId=3;
  static bool togglestate;

  //create meeting
  static final String createMeeting = "api/Meetings/";

  //image preview
  static File imgfile;

  //contact
  static String contact="+977 9801042730";

  //create meeting
  static final String createMeeting_url = "api/Meetings?sender=";

  //privacy 
  static final String privacy_url='http://snbiznepal.com/wp-content/uploads/2019/08';

  //profile
  static final String profile_modelurl = "api/OrganizationUserDetails?Orgid="; 
   static final String profilePerson_url = "api/UserAccounts/";

  //document
  static final String document ="api/OrgDocumentsList?Orgid=" ;

  //multiple image
  static List<String> filenames;

  //navigation
  static String facebookurl = "http://www.facebook.com";
  static String whatsapp="http://api.whatsapp.com/send?phone=+977-9803373555";

  //task
  static final String taskurl="api/AllOrgTasks?Orgid=";

  //send notification
  static final String sendNotification= "api/lastsentnotification?Userid=";

  //task details
  static final String taskDetails_url= "api/OrgChildTasks?Orgid=";
  //trems
  static final String termsurl = 'https://snbiznepal.com' ;
  //carousal datas
  static String upcomingMeetingsCount='-';
  static String meetingTime='-';
  static String activeTaskcount='-';
  static String taskName='-';
  static String totalPaymentDue='-';
  static String lastInvoiceDate='-';
  static String uploadsToday='-';
  static String uploadedDate='-';
  static String vATCredit="-";

  //tabcontroller
  static TabController controller;

  //logout
  static bool wasloggedout;

  //webview
  static final String webviewUrl='https://snbiznepal.com';

  //tutorial
  static bool tutorialFromNav = false;

  //report
   static final String reportUrl ="api/OrgReportDocs?OrgId=" ;

}

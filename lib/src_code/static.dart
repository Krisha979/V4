import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snbiz/Model_code/meetingStatus.dart';

class StaticValue
{

  //login
  static int orgId;
  static String orgName;
  static String logo;
  static int orgUserId;
  static String userRowstamp;
  static String orgRowstamp;

  static int meetingstatusId=3;
  static List<MeetingStatus> statuslist = [];

  //baseurl

  //static final String baseUrl = "https://s-nbiz.conveyor.cloud/";
  static final String baseUrl = "http://snbizadmin.azurewebsites.net/";

  //notification
  static int latestNotificationId;

  //meeting
  static int meetingScheduledId = 4;
  static bool togglestate;

  //image preview
  static File imgfile;

  //multiple image
  static List<String> filenames;

  //navigation
  static String facebookurl = "http://www.facebook.com";
  static String whatsapp="http://api.whatsapp.com/send?phone=+977-9803373555";

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

}

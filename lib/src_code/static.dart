import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snbiz/Model_code/meetingStatus.dart';

class StaticValue{
  static String vATCredit;
  static int orgId;
  static String orgName;
  static String logo;
  static int orgUserId;
  static String userRowstamp;
  static String orgRowstamp;
  static int meetingstatusId=3;
  static List<MeetingStatus> statuslist = [];
 static final String baseUrl = "https://s-nbiz.conveyor.cloud/";
 // static final String baseUrl = "http://snbizadmin.azurewebsites.net/";
  static List<String> filenames;
  static int latestNotificationId;
  static int meetingScheduledId = 4;
  static bool togglestate;
  static File imgfile;
  static String facebookurl = "http://www.facebook.com";
  static String whatsapp="http://api.whatsapp.com/send?phone=+977-9803373555";
  static String upcomingMeetingsCount='-';
  static String meetingTime='-';
  static String activeTaskcount='-';
  static String taskName='-';
  static String totalPaymentDue='-';
  static String lastInvoiceDate='-';
  static String uploadsToday='-';
  static String uploadedDate='-';
  static TabController controller;
  static bool wasloggedout;
}

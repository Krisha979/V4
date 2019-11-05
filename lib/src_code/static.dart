import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snbiz/Model_code/meetingStatus.dart';

class StaticValue{
  static int orgId;
  static String orgName;
  static String logo;
  static String userRowstamp;
  static String orgRowstamp;
  static int meetingstatusId=3;
  static List<MeetingStatus> statuslist = [];
  //static final String baseUrl = "https://s-nbiz.conveyor.cloud/";
  static final String baseUrl = "http://snbizadmin.azurewebsites.net/";
  static List<String> filenames;
  static int latestNotificationId;
  static int meetingScheduledId = 4;
  static bool togglestate;
  static File imgfile;
  static String facebookurl = "http://www.facebook.com";
  static String whatsapp="http://www.facebook.com";
  static int upcomingMeetingsCount;
  static String meetingTime='not found';
  static int activeTaskcount;
  static String taskName='not found';
  static int totalPaymentDue;
  static String lastInvoiceDate='not found';
  static int uploadsToday;
  static String uploadedDate='not found';
  static TabController controller;
  static bool wasloggedout;
}

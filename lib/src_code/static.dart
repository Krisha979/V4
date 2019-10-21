import 'dart:io';

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
}

class DashBoardData {
  int upcomingMeetingsCount;
  String meetingTime;
  int activeTaskcount;
  String taskName;
  int totalPaymentDue;
  String lastInvoiceDate;
  int uploadsToday;
  String uploadedDate;

  DashBoardData(
      {this.upcomingMeetingsCount,
      this.meetingTime,
      this.activeTaskcount,
      this.taskName,
      this.totalPaymentDue,
      this.lastInvoiceDate,
      this.uploadsToday,
      this.uploadedDate});

  DashBoardData.fromJson(Map<String, dynamic> json) {
    upcomingMeetingsCount = json['upcomingMeetingsCount'];
    meetingTime = json['meetingTime'];
    activeTaskcount = json['activeTaskcount'];
    taskName = json['taskName'];
    totalPaymentDue = json['totalPaymentDue'];
    lastInvoiceDate = json['lastInvoiceDate'];
    uploadsToday = json['uploadsToday'];
    uploadedDate = json['uploadedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['upcomingMeetingsCount'] = this.upcomingMeetingsCount;
    data['meetingTime'] = this.meetingTime;
    data['activeTaskcount'] = this.activeTaskcount;
    data['taskName'] = this.taskName;
    data['totalPaymentDue'] = this.totalPaymentDue;
    data['lastInvoiceDate'] = this.lastInvoiceDate;
    data['uploadsToday'] = this.uploadsToday;
    data['uploadedDate'] = this.uploadedDate;
    return data;
  }
}
class NotificationModel {
  String dateCreated;
  int createdBy;
  String notificationBody;
  String organizationName;
  int notificationId;
  //int sendTo;

  NotificationModel(
      {this.dateCreated,
      this.createdBy,
      this.notificationBody,
      this.organizationName,
      this.notificationId,
     // this.sendTo
      });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    dateCreated = json['dateCreated'];
    createdBy = json['createdBy'];
    notificationBody = json['notificationBody'];
    organizationName = json['organizationName'];
    notificationId = json['notificationId'];
    //sendTo = json['sendTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateCreated'] = this.dateCreated;
    data['createdBy'] = this.createdBy;
    data['notificationBody'] = this.notificationBody;
    data['organizationName'] = this.organizationName;
    data['notificationId'] = this.notificationId;
   // data['sendTo'] = this.sendTo;
    return data;
  }
}
class NotificationModel {
  String dateCreated;
  int createdBy;
  String notificationBody;
  String organizationName;
  int notificationId;

  NotificationModel(
      {this.dateCreated,
      this.createdBy,
      this.notificationBody,
      this.organizationName,
      this.notificationId});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    dateCreated = json['dateCreated'];
    createdBy = json['createdBy'];
    notificationBody = json['notificationBody'];
    organizationName = json['organizationName'];
    notificationId = json['notificationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateCreated'] = this.dateCreated;
    data['createdBy'] = this.createdBy;
    data['notificationBody'] = this.notificationBody;
    data['organizationName'] = this.organizationName;
    data['notificationId'] = this.notificationId;
    return data;
  }
}
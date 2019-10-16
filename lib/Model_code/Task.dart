class Task {
  int organizationTaskId;
  int taskId;
  int organizationId;
  String dateCreated;
  bool deleted;
  String rowstamp;
  int statusId;
  String taskName;
  String statusName;
  String startDate;
  String endDate;

  Task(
      {this.organizationTaskId,
      this.taskId,
      this.organizationId,
      this.dateCreated,
      this.deleted,
      this.rowstamp,
      this.statusId,
      this.taskName,
      this.statusName,
      this.startDate,
      this.endDate});

  Task.fromJson(Map<String, dynamic> json) {
    organizationTaskId = json['organizationTaskId'];
    taskId = json['taskId'];
    organizationId = json['organizationId'];
    dateCreated = json['dateCreated'];
    deleted = json['deleted'];
    rowstamp = json['rowstamp'];
    statusId = json['statusId'];
    taskName = json['taskName'];
    statusName = json['statusName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organizationTaskId'] = this.organizationTaskId;
    data['taskId'] = this.taskId;
    data['organizationId'] = this.organizationId;
    data['dateCreated'] = this.dateCreated;
    data['deleted'] = this.deleted;
    data['rowstamp'] = this.rowstamp;
    data['statusId'] = this.statusId;
    data['taskName'] = this.taskName;
    data['statusName'] = this.statusName;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}
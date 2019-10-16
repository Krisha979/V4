class CreateMeetings {
  int meetingId;
  String meetingTime;
  String agenda;
  String location;
  int statusId;
  int organizationId;
  String reminderTime;
  int createdBy;
  String dateCreated;
  bool deleted;
  
  String rowstamp;

  CreateMeetings(
      {this.meetingId,
      this.meetingTime,
      this.agenda,
      this.location,
      this.statusId,
      this.organizationId,
      this.reminderTime,
      this.createdBy,
      this.dateCreated,
      this.deleted,
      this.rowstamp});

  CreateMeetings.fromJson(Map<String, dynamic> json) {
    meetingId = json['meetingId'];
    meetingTime = json['meetingTime'];
    agenda = json['agenda'];
    location = json['location'];
    statusId = json['statusId'];
    organizationId = json['organizationId'];
    reminderTime = json['reminderTime'];
    createdBy = json['createdBy'];
    dateCreated = json['dateCreated'];
    deleted = json['deleted'];
    rowstamp = json['rowstamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meetingId'] = this.meetingId;
    data['meetingTime'] = this.meetingTime;
    data['agenda'] = this.agenda;
    data['location'] = this.location;
    data['statusId'] = this.statusId;
    data['organizationId'] = this.organizationId;
    data['reminderTime'] = this.reminderTime;
    data['createdBy'] = this.createdBy;
    data['dateCreated'] = this.dateCreated;
    data['deleted'] = this.deleted;
    data['rowstamp'] = this.rowstamp;
    return data;
  }
}
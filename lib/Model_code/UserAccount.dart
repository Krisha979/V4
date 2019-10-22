class UserAccount {
  int userAccountId;
  String fullName;
  String email;
  String password;
  String contactNumber;
  int userTypeId;
  int organizationId;
  String changeRequest;
  String requestTime;
  bool isValidated;
  String dateCreated;
  bool deleted;
  String rowstamp;

  UserAccount(
      {this.userAccountId,
      this.fullName,
      this.email,
      this.password,
      this.contactNumber,
      this.userTypeId,
      this.organizationId,
      this.changeRequest,
      this.requestTime,
      this.isValidated,
      this.dateCreated,
      this.deleted,
      this.rowstamp});

  UserAccount.fromJson(Map<String, dynamic> json) {
    userAccountId = json['userAccountId'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    contactNumber = json['contactNumber'];
    userTypeId = json['userTypeId'];
    organizationId = json['organizationId'];
    changeRequest = json['changeRequest'];
    requestTime = json['requestTime'];
    isValidated = json['isValidated'];
    dateCreated = json['dateCreated'];
    deleted = json['deleted'];
    rowstamp = json['rowstamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userAccountId'] = this.userAccountId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['contactNumber'] = this.contactNumber;
    data['userTypeId'] = this.userTypeId;
    data['organizationId'] = this.organizationId;
    data['changeRequest'] = this.changeRequest;
    data['requestTime'] = this.requestTime;
    data['isValidated'] = this.isValidated;
    data['dateCreated'] = this.dateCreated;
    data['deleted'] = this.deleted;
    data['rowstamp'] = this.rowstamp;
    return data;
  }
}
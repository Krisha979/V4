class ProfileModel {
  int organizationId;
  String organizationEmail;
  String organizationName;
  String logo;
  String organizationNumber;
  String taXPAN;
  String url;
  int userAccountId;
  String email;
  String contactNumber;
  int userTypeId;
  String fullName;
  String password;
  bool isValidated;
  String requestTime;
  Null changeRequest;
  bool deleted;
  String rowstamp;
  String dateCreated;

  ProfileModel(
      {this.organizationId,
      this.organizationEmail,
      this.organizationName,
      this.logo,
      this.organizationNumber,
      this.taXPAN,
      this.url,
      this.userAccountId,
      this.email,
      this.contactNumber,
      this.userTypeId,
      this.fullName,
      this.password,
      this.isValidated,
      this.requestTime,
      this.changeRequest,
      this.deleted,
      this.rowstamp,
      this.dateCreated});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    organizationId = json['organizationId'];
    organizationEmail = json['organizationEmail'];
    organizationName = json['organizationName'];
    logo = json['logo'];
    organizationNumber = json['organizationNumber'];
    taXPAN = json['taX_PAN'];
    url = json['url'];
    userAccountId = json['userAccountId'];
    email = json['email'];
    contactNumber = json['contactNumber'];
    userTypeId = json['userTypeId'];
    fullName = json['fullName'];
    password = json['password'];
    isValidated = json['isValidated'];
    requestTime = json['requestTime'];
    changeRequest = json['changeRequest'];
    deleted = json['deleted'];
    rowstamp = json['rowstamp'];
    dateCreated = json['dateCreated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organizationId'] = this.organizationId;
    data['organizationEmail'] = this.organizationEmail;
    data['organizationName'] = this.organizationName;
    data['logo'] = this.logo;
    data['organizationNumber'] = this.organizationNumber;
    data['taX_PAN'] = this.taXPAN;
    data['url'] = this.url;
    data['userAccountId'] = this.userAccountId;
    data['email'] = this.email;
    data['contactNumber'] = this.contactNumber;
    data['userTypeId'] = this.userTypeId;
    data['fullName'] = this.fullName;
    data['password'] = this.password;
    data['isValidated'] = this.isValidated;
    data['requestTime'] = this.requestTime;
    data['changeRequest'] = this.changeRequest;
    data['deleted'] = this.deleted;
    data['rowstamp'] = this.rowstamp;
    data['dateCreated'] = this.dateCreated;
    return data;
  }
}
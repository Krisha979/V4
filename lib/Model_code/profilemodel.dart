class CreateProfile {
  int organizationId;
  String organizationName;
  String url;
  String taXPAN;
  String logo;
  String address;
  String description;
  String contactPerson;
  String organizationEmail;
  String organizationNumber;
  String dateCreated;
  bool deleted;
  String rowstamp;

  CreateProfile(
      {this.organizationId,
      this.organizationName,
      this.url,
      this.taXPAN,
      this.logo,
      this.address,
      this.description,
      this.contactPerson,
      this.organizationEmail,
      this.organizationNumber,
      this.dateCreated,
      this.deleted,
      this.rowstamp});

  CreateProfile.fromJson(Map<String, dynamic> json) {
    organizationId = json['organizationId'];
    organizationName = json['organizationName'];
    url = json['url'];
    taXPAN = json['taX_PAN'];
    logo = json['logo'];
    address = json['address'];
    description = json['description'];
    contactPerson = json['contactPerson'];
    organizationEmail = json['organizationEmail'];
    organizationNumber = json['organizationNumber'];
    dateCreated = json['dateCreated'];
    deleted = json['deleted'];
    rowstamp = json['rowstamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organizationId'] = this.organizationId;
    data['organizationName'] = this.organizationName;
    data['url'] = this.url;
    data['taX_PAN'] = this.taXPAN;
    data['logo'] = this.logo;
    data['address'] = this.address;
    data['description'] = this.description;
    data['contactPerson'] = this.contactPerson;
    data['organizationEmail'] = this.organizationEmail;
    data['organizationNumber'] = this.organizationNumber;
    data['dateCreated'] = this.dateCreated;
    data['deleted'] = this.deleted;
    data['rowstamp'] = this.rowstamp;
    return data;
  }
}
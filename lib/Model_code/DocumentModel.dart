class DocumentModel {
  int fileTypeId;
  List<Documents> documents;

  DocumentModel({this.fileTypeId, this.documents});

  DocumentModel.fromJson(Map<String, dynamic> json) {
    fileTypeId = json['fileTypeId'];
    if (json['documents'] != null) {
      documents = new List<Documents>();
      json['documents'].forEach((v) {
        documents.add(new Documents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileTypeId'] = this.fileTypeId;
    if (this.documents != null) {
      data['documents'] = this.documents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Documents {
  int documentId;
  String fileName;
  int fileTypeId;
  String documentURL;
  String expiryDate;
  String docDate;
  int organizationId;
  String dateCreated;
  bool deleted;
  String rowstamp;
  String fileTypeName;

  Documents(
      {this.documentId,
      this.fileName,
      this.fileTypeId,
      this.documentURL,
      this.expiryDate,
      this.docDate,
      this.organizationId,
      this.dateCreated,
      this.deleted,
      this.rowstamp,
      this.fileTypeName});

  Documents.fromJson(Map<String, dynamic> json) {
    documentId = json['documentId'];
    fileName = json['fileName'];
    fileTypeId = json['fileTypeId'];
    documentURL = json['documentURL'];
    expiryDate = json['expiryDate'];
    docDate = json['docDate'];
    organizationId = json['organizationId'];
    dateCreated = json['dateCreated'];
    deleted = json['deleted'];
    rowstamp = json['rowstamp'];
    fileTypeName = json['fileTypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['fileName'] = this.fileName;
    data['fileTypeId'] = this.fileTypeId;
    data['documentURL'] = this.documentURL;
    data['expiryDate'] = this.expiryDate;
    data['docDate'] = this.docDate;
    data['organizationId'] = this.organizationId;
    data['dateCreated'] = this.dateCreated;
    data['deleted'] = this.deleted;
    data['rowstamp'] = this.rowstamp;
    data['fileTypeName'] = this.fileTypeName;
    return data;
  }
}
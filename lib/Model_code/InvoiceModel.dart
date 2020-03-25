class InvoiceModel {
  int invoiceId;
  String invoiceName;
  String invoiceAmount;
  String dateCreated;
  String paidAmount;
  String statusName;

  InvoiceModel(
      {this.invoiceId,
      this.invoiceName,
      this.invoiceAmount,
      this.dateCreated,
      this.paidAmount,
      this.statusName});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoiceId'];
    invoiceName = json['invoiceName'];
    invoiceAmount = json['invoiceAmount'];
    dateCreated = json['dateCreated'];
    paidAmount = json['paidAmount'];
    statusName = json['statusName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoiceId'] = this.invoiceId;
    data['invoiceName'] = this.invoiceName;
    data['invoiceAmount'] = this.invoiceAmount;
    data['dateCreated'] = this.dateCreated;
    data['paidAmount'] = this.paidAmount;
    data['statusName'] = this.statusName;
    return data;
  }
}
class InvoiceDocument {
  int documentId;
  String documentURL;
  String expiryDate;
  String fileName;
  int fileTypeId;
  String docDate;
  int organizationId;
  String dateCreated;
  bool deleted;
  String rowstamp;

  InvoiceDocument(
      {this.documentId,
        this.documentURL,
        this.expiryDate,
        this.fileName,
        this.fileTypeId,
        this.docDate,
        this.organizationId,
        this.dateCreated,
        this.deleted,
        this.rowstamp});

  InvoiceDocument.fromJson(Map<String, dynamic> json) {
    documentId = json['documentId'];
    documentURL = json['documentURL'];
    expiryDate = json['expiryDate'];
    fileName = json['fileName'];
    fileTypeId = json['fileTypeId'];
    docDate = json['docDate'];
    organizationId = json['organizationId'];
    dateCreated = json['dateCreated'];
    deleted = json['deleted'];
    rowstamp = json['rowstamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['documentURL'] = this.documentURL;
    data['expiryDate'] = this.expiryDate;
    data['fileName'] = this.fileName;
    data['fileTypeId'] = this.fileTypeId;
    data['docDate'] = this.docDate;
    data['organizationId'] = this.organizationId;
    data['dateCreated'] = this.dateCreated;
    data['deleted'] = this.deleted;
    data['rowstamp'] = this.rowstamp;
    return data;
  }
}
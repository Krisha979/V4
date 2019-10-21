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
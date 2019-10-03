class FileType {
  int fileTypeId;
  String fileTypeName;
  String dateCreated;
  bool deleted;
  String rowstamp;

  FileType(
      {this.fileTypeId,
      this.fileTypeName,
      this.dateCreated,
      this.deleted,
      this.rowstamp});

  FileType.fromJson(Map<String, dynamic> json) {
    fileTypeId = json['fileTypeId'];
    fileTypeName = json['fileTypeName'];
    dateCreated = json['dateCreated'];
    deleted = json['deleted'];
    rowstamp = json['rowstamp'];
  }

  String get fileType => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileTypeId'] = this.fileTypeId;
    data['fileTypeName'] = this.fileTypeName;
    data['dateCreated'] = this.dateCreated;
    data['deleted'] = this.deleted;
    data['rowstamp'] = this.rowstamp;
    return data;
  }

  static List<FileType> getFileType() {}
}
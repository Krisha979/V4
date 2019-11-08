import 'package:snbiz/Model_code/Task.dart';

class OrgTask {
  Task parentTask;
  List<Task> childTask;
  double percentageComplete;

  OrgTask({this.parentTask, this.childTask, this.percentageComplete});

  OrgTask.fromJson(Map<String, dynamic> json) {
    parentTask = json['parentTask'] != null
        ? new Task.fromJson(json['parentTask'])
        : null;
    if (json['childTask'] != null) {
      childTask = new List<Task>();
      json['childTask'].forEach((v) {
        childTask.add(new Task.fromJson(v));
      });
    }
    percentageComplete = json['percentageComplete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.parentTask != null) {
      data['parentTask'] = this.parentTask.toJson();
    }
    if (this.childTask != null) {
      data['childTask'] = this.childTask.map((v) => v.toJson()).toList();
    }
    data['percentageComplete'] = this.percentageComplete;
    return data;
  }
}

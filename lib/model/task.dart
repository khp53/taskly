class Task {
  String? name;
  String? category;
  bool? isCompleted;

  Task({this.name, this.category, this.isCompleted});

  Task.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['category'] = category;
    data['isCompleted'] = isCompleted;
    return data;
  }
}
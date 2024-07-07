class Task {
  int? id;
  String name;
  String type;
  String date;
  bool isDone;

  Task(
      {this.id,
      required this.name,
      required this.type,
      required this.date,
      required this.isDone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'date': date,
      'isDone': isDone ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      date: map['date'],
      isDone: map['isDone'] == 1,
    );
  }
}

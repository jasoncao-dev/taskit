import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String? id;
  final String? name;
  final String? note;
  final String? tag;
  final String? date;
  final String? startTime;
  final String? endTime;

  Task(
      {this.id,
      this.name,
      this.note,
      this.tag,
      this.date,
      this.startTime,
      this.endTime});

  factory Task.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Task(
        id: data?['id'],
        name: data?['name'],
        note: data?['note'],
        tag: data?['tag'],
        date: data?['date'],
        startTime: data?['startTime'],
        endTime: data?['endTime']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (name != null) "name": name,
      if (note != null) "note": note,
      if (tag != null) "tag": tag,
      if (date != null) "date": date,
      if (startTime != null) "startTime": startTime,
      if (endTime != null) "endTime": endTime,
    };
  }
}

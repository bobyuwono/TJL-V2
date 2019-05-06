import 'package:firebase_database/firebase_database.dart';
///
///
///
///
///GAGALLL
///
///
///
class Schedule {
  String key;
  String subject;
  bool completed;
  String timestamp;
  String userId;

  Schedule(this.subject, this.userId,this.timestamp, this.completed, );

  Schedule.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    userId = snapshot.value["userId"],
    subject = snapshot.value["subject"],
    completed = snapshot.value["completed"];

  toJson() {
    return {
      "userId": userId,
      "subject": subject,
      "completed": completed,
      "timestamp": timestamp,
    };
  }
}
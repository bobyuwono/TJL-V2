import 'package:firebase_database/firebase_database.dart';

class Schedule {
  String key;
  String subject;
  bool completed;
  String timestamp;
  String userId;

  Schedule(this.subject, this.userId, this.completed, this.timestamp);

  Schedule.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    userId = snapshot.value["userId"],
    subject = snapshot.value["subject"],
    completed = snapshot.value["completed"],
    timestamp=snapshot.value["timestamp"];
    

  toJson() {
    return {
      "userId": userId,
      "subject": subject,
      "completed": completed,
      "timestamp": timestamp,
    };
  }
}
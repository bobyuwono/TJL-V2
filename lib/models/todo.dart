import 'package:firebase_database/firebase_database.dart';


class Todo {
  String key;
  String subject;
  bool completed;
  String userId;
  String timestamp;

  Todo(this.subject, this.userId, this.completed);

  Todo.fromSnapshot(DataSnapshot snapshot) :
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
      
      
    };
  }
}
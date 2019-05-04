import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Center travelerPage(DocumentSnapshot snapshot){
  return Center (child: Text('${snapshot.data['role']}'+'PAGE'));
  
}
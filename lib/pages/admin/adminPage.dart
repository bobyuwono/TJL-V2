import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Center adminPage(DocumentSnapshot snapshot){
  return Center (child: Text('${snapshot.data['role']}' +'PAGE'));

}
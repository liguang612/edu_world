import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreTools {
  static void startTools() async {
    final db = FirebaseFirestore.instance;
    final provCollection = db.collection("vietnam");

    String contents = await rootBundle.loadString('assets/out.json');
    final Map<String, dynamic> data = jsonDecode(contents);

    for (var province in data.entries) {
      final districtCollection = provCollection.doc(province.key).collection('district');

      for (var district in (province.value as Map<String, dynamic>).entries) {
        districtCollection.doc(district.key).set({"wards": district.value as List<dynamic>});
      }
    }
  }
}

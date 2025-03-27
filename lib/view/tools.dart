import 'package:edu_world/shared/utils/cloud_firestore_tools.dart';
import 'package:edu_world/view/register/register.dart';
import 'package:flutter/material.dart';

class Tools extends StatelessWidget {
  const Tools({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              CloudFirestoreTools.startTools();
            },
            child: Text('PRESS')),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_world/data/constants.dart';

class SubjectService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference subjectRef;

  SubjectService() {
    subjectRef = _firestore.collection(CollectionKeys.subjectCollection);
  }
}

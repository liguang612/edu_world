import 'package:cloud_firestore/cloud_firestore.dart';

class LectureService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference lectureRef;

  LectureService() {
    lectureRef = _firestore.collection('lecture');
  }

  Future<List<(String, String)>> getLectures(List<String> lectureIds) async {
    try {
      if (lectureIds.isEmpty) return [];

      final QuerySnapshot snapshots = await lectureRef.where(FieldPath.documentId, whereIn: lectureIds).get();

      final nameTable = Map.fromEntries(snapshots.docs.map(
        (e) => MapEntry(e.id, (e.data() as Map<String, dynamic>)['name']),
      ));

      return lectureIds.map((e) => (e, nameTable[e].toString())).toList();
    } catch (e) {
      print('GET LECTURE NAMES ERROR: $e');
    }
    return [];
  }
}

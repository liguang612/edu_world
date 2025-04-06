import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_world/data/constants.dart';
import 'package:edu_world/domain/response/subject_response.dart';

class CourseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference subjectRef;

  CourseService() {
    subjectRef = _firestore.collection(CollectionKeys.subjectCollection);
  }

  Future<List<SubjectResponse>> getSubjects({int? grade}) async {
    QuerySnapshot<Object?> res;

    if (grade == null) {
      res = await subjectRef.get();
    } else {
      Query query = subjectRef;
      query = query.where('grade', isEqualTo: grade);

      res = await query.get();
    }

    return res.docs.map((e) => SubjectResponse.fromMap(e.id, e.data() as Map<String, dynamic>)).toList();
  }
}

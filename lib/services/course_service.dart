import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_world/data/constants.dart';
import 'package:edu_world/domain/response/course_response.dart';
import 'package:edu_world/domain/response/subject_response.dart';
import 'package:edu_world/shared/utils/ext/map_ext.dart';

class CourseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference courseRef;
  late final CollectionReference subjectRef;

  CourseService() {
    courseRef = _firestore.collection(CollectionKeys.courseCollection);
    subjectRef = _firestore.collection(CollectionKeys.subjectCollection);
  }

  Future<List<CourseResponse>> getCourses(String userId, int role) async {
    try {
      Query query = courseRef;

      if (role == 1) {
        query = query.where(Filter.or(
          Filter('teacherId', isEqualTo: userId),
          Filter('teacherAssistantIds', arrayContains: userId),
        ));
      } else {
        query = query.where('studentIds', arrayContains: userId);
      }

      final res = await query.get();

      return res.docs.map((e) => CourseResponse.fromMap(e.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print('GET COURSES ERROR: $e');
    }

    return [];
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

  Future<String?> createCourse(CourseResponse request) async {
    try {
      final ref = await courseRef.add(request.toMap());

      return ref.id;
    } catch (e) {
      print('CREATE_COURSE_ERROR: $e');
    }

    return null;
  }

  Future<bool> updateCourse(
    String id, {
    List<String>? allCategories,
    List<Map<String, dynamic>>? chapters,
    String? description,
    List<String>? lectureIds,
    String? name,
    List<String>? studentIds,
    List<String>? tAs,
    String? wallpaper,
  }) async {
    try {
      final data = {
        "allCategories": allCategories,
        "chapters": chapters,
        "description": description,
        "lectureIds": lectureIds,
        "name": name,
        "studentIds": studentIds,
        "teacherAssistantIds": tAs,
        "wallpapaer": wallpaper,
      };

      await courseRef.doc(id).set(data.removeNull(), SetOptions(merge: true));

      return true;
    } catch (e) {
      print('UPDATE COURSE ERROR: $e');
    }
    return false;
  }
}

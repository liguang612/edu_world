import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_world/data/constants.dart';
import 'package:edu_world/domain/response/course_response.dart';
import 'package:edu_world/domain/response/subject_response.dart';
import 'package:edu_world/model/entity/review.dart';
import 'package:edu_world/shared/utils/ext/map_ext.dart';

class CourseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference courseRef;
  late final CollectionReference subjectRef;

  CourseService() {
    courseRef = _firestore.collection(CollectionKeys.courseCollection);
    subjectRef = _firestore.collection(CollectionKeys.subjectCollection);
  }

  Future<bool> addChapter(String courseId, String chapter) async {
    try {
      await courseRef.doc(courseId).update({
        'chapters': FieldValue.arrayUnion([
          {
            'name': chapter,
            'lectureIds': [],
          }
        ])
      });

      return true;
    } catch (e) {
      print('ADD CHAPTER ERROR: $e');
    }
    return false;
  }

  Future<String?> createCourse(CourseResponse request) async {
    try {
      final ref = await courseRef.add(request.toMap()..remove('id'));

      return ref.id;
    } catch (e) {
      print('CREATE_COURSE_ERROR: $e');
    }

    return null;
  }

  Future<bool> editCourse({required String id, required String name, required String description}) async {
    try {
      await courseRef.doc(id).update({
        'name': name,
        'description': description,
      });

      return true;
    } catch (e) {
      print('EDIT COURSE ERROR: $e');
    }

    return false;
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

      return res.docs.map((e) => CourseResponse.fromMap(e.id, e.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print('GET COURSES ERROR: $e');
    }

    return [];
  }

  Future<List<Review>> getReviews(String courseId) async {
    try {
      final data = await courseRef.doc(courseId).collection('review').get();

      return data.docs
          .map(
            (e) => Review.fromMap(e.reference, e.data()),
          )
          .toList();
    } catch (e) {
      print('GET REVIEWS ERROR: $e');
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

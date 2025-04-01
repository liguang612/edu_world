import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreTools {
  static void startTools() async {
    final db = FirebaseFirestore.instance;

    final subjectCollection = db.collection('subject');

    final List<String> subjects = [
      "Ngữ văn",
      "Toán",
      "Lịch sử",
      "Giáo dục thể chất",
      "Giáo dục quốc phòng và an ninh",
      "Giáo dục địa phương",
      "Địa lý",
      "Giáo dục kinh tế và pháp luật",
      "Vật lý",
      "Hoá học",
      "Sinh học",
      "Tin học",
      "Công nghệ",
      "Âm nhạc",
      "Mỹ thuật",
      "Tiếng Anh",
      "Tiếng Nga",
      "Tiếng Pháp",
      "Tiếng Trung Quốc",
      "Tiếng Đức",
      "Tiếng Nhật",
      "Tiếng Hàn"
    ];

    for (var element in subjects) {
      for (var i = 10; i <= 12; i++) {
        subjectCollection.add({
          "grade": i,
          "name": element,
        });
      }
    }
  }
}

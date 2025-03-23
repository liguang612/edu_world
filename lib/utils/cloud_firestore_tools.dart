import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreTools {
  static void startTools() async {
    final data = [
      {"Thành phố Hồ Chí Minh": 79, "Huyện Bình Chánh": 785, "Xã Quy Đức": 27640},
      {"Thành phố Hồ Chí Minh": 79, "Huyện Nhà Bè": 786, "Thị trấn Nhà Bè": 27643},
      {"Thành phố Hồ Chí Minh": 79, "Huyện Nhà Bè": 786, "Xã Phước Kiển": 27646},
      {"Thành phố Hồ Chí Minh": 79, "Huyện Nhà Bè": 786, "Xã Phước Lộc": 27649},
      {"Thành phố Hồ Chí Minh": 79, "Huyện Nhà Bè": 786, "Xã Nhơn Đức": 27652},
      {"Thành phố Hồ Chí Minh": 79, "Huyện Nhà Bè": 786, "Xã Phú Xuân": 27655},
      {"Thành phố Hồ Chí Minh": 79, "Huyện Nhà Bè": 786, "Xã Long Thới": 27658},
      {"Thành phố Hồ Chí Minh": 79, "Huyện Nhà Bè": 786, "Xã Hiệp Phước": 27661},
      {"Thành phố Hồ Chí Minh": 79, "Huyện Cần Giờ": 787, "Thị trấn Cần Thạnh": 27664},
      {"Thành phố Hồ Chí Minh": 79, "Huyện Cần Giờ": 787, "Xã Bình Khánh": 27667},
      {"Thành phố Hồ Chí Minh": 79, "Huyện Cần Giờ": 787, "Xã Tam Thôn Hiệp": 27670},
      {"Thành phố Hồ Chí Minh": 79, "Huyện Cần Giờ": 787, "Xã An Thới Đông": 27673},
      {"Thành phố Hồ Chí Minh": 79, "Huyện Cần Giờ": 787, "Xã Thạnh An": 27676},
      {"Thành phố Hồ Chí Minh": 79, "Huyện Cần Giờ": 787, "Xã Long Hòa": 27679},
      {"Thành phố Hồ Chí Minh": 79, "Huyện Cần Giờ": 787, "Xã Lý Nhơn": 27682},
    ];

    final db = FirebaseFirestore.instance;

    String prevProv = "", prevDist = "";

    final collection = db.collection("vietnam");
    DocumentReference<Map<String, dynamic>> provinceDoc = collection.doc("Thành phố Hà Nội"),
        districtDoc = provinceDoc.collection("district").doc("Quận Ba Đình");

    for (var e in data) {
      final entries = e.entries.toList();

      final province = entries[0];
      final district = entries[1];

      if (province.key != prevProv) {
        // Re-select province
        prevProv = province.key;
        provinceDoc = collection.doc(prevProv);

        // Add district
        prevDist = district.key;
        districtDoc = provinceDoc.collection("district").doc(prevDist);
        districtDoc.set({"code": district.value});
      } else if (district.key != prevDist) {
        // Add district
        prevDist = district.key;
        districtDoc = provinceDoc.collection("district").doc(prevDist);
        districtDoc.set({"code": district.value});
      }

      if (entries.length == 3) {
        final ward = entries[2];
        districtDoc.collection("ward").doc(ward.key).set({"code": ward.value});
      }
    }
  }
}

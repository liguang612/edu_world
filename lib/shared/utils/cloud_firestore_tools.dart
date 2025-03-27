import 'package:dio/dio.dart';
import 'package:edu_world/data/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreTools {
  static void startTools() async {
    final db = FirebaseFirestore.instance;

    final provCollection = db.collection("vietnam");

    const String path = 'https://violympic.vn/graphql';

    final dio = Dio();
    final res = await dio.post(path, data: {
      "query": "query GetProvinces {  provinces {    id    name    __typename  }}",
      "variables": {},
    });

    final provinces = (res.data as Map<String, dynamic>)['data']['provinces'] as List<dynamic>;

    for (Map<String, dynamic> province in provinces) {
      final districtCollection = provCollection.doc(province['name']).set({"id": province['id']});

      // final districtCollection = provCollection.doc(province['name']).collection(CollectionKeys.districtCollection);

      // final res = await dio.post(path, data: {
      //   "query": r"query GetDistricts($province: String!) {  fetchDistrict(province: $province) {    id    name   }}",
      //   "variables": {"province": province['id']}
      // });

      // final districts = (res.data as Map<String, dynamic>)['data']['fetchDistrict'] as List<dynamic>;
      // for (Map<String, dynamic> district in districts) {
      //   final res = await dio.post(path, data: {
      //     "query": r"query GetSchools($district: String!) {fetchSchool(district: $district) {id    name  }}",
      //     "variables": {"district": district['id']}
      //   });

      //   final schools = (res.data as Map<String, dynamic>)['data']['fetchSchool'] as List<dynamic>;

      //   final List<String> schoolList = [];
      //   for (Map<String, dynamic> school in schools) {
      //     schoolList.add(school['name']);
      //     print(province['name'] + ' - ' + district['name'] + ' - ' + school['name']);
      //   }

      //   districtCollection.doc(district['name']).set({"schools": schoolList});
      // }
    }
  }

  // static void startTools() async {
  //   final db = FirebaseFirestore.instance;

  //   final provCollection = db.collection("vietnam");

  //   final res = await provCollection.get();

  //   for (var doc in res.docs) {
  //     if (doc.id.startsWith('Tỉnh')) {
  //       print(doc.id);
  //       doc.reference.delete();
  //     }
  //   }
  // }
}

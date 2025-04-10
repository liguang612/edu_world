class CollectionKeys {
  static const String courseCollection = 'class';
  static const String districtCollection = 'district';
  static const String subjectCollection = 'subject';
  static const String userCollection = 'user';
  static const String vietnamCollection = 'vietnam';
}

class SharedPreferenceKeys {
  static const String accessToken = "accessToken";
  static const String role = "role";
  static const String userId = "userId";
}

class CloudStorageKeys {
  static const String courseWallpaper = "course/wallpapers";
}

enum FileType { image, audio, video, pdf }

enum UserRole {
  student(0),
  teacher(1);

  final int value;
  const UserRole(this.value);
}

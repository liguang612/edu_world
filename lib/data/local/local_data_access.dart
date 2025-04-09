abstract class LocalDataAccess {
  void clearAccessToken();
  void clearRole();
  void clearUserId();

  String? getAccessToken();
  int? getRole();
  String? getUserId();

  void setAccessToken(String accessToken);
  void setRole(int role);
  void setUserId(String userId);
}

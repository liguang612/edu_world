abstract class LocalDataAccess {
  void clearAccessToken();
  void clearUserId();

  String? getAccessToken();
  String? getUserId();

  void setAccessToken(String accessToken);
  void setUserId(String userId);
}

class GlobalVar {
  static var globalToken = '';
  static Map<String, String> header = {
    "Content-Type": "application/json",
    "Authorization": "Bearer ${GlobalVar.globalToken}"
  };
  static int activeTab = 0;
  static String mobileNo = "";
  static bool unreadBox = false;
  static String keyLogin = 'Login';
  static String userId = "";
  static String userPassword = "";
  static int visitedCount = 0;
  static List<dynamic> recentEvent = [];
  static String filterFlagName = "";
  static String filterFlagId = "";
  static String filterMobile = "";
}
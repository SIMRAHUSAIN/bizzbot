class GlobalVar {
  static var globalToken = '';
  static Map<String, String> header = {
    "Content-Type": "application/json",
    "Authorization": "Bearer ${GlobalVar.globalToken}"
  };
  static int activeTab = 0;
  static String mobileNo = "";
  static bool unreadBox = false;
}
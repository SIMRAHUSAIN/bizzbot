// ignore_for_file: file_names

class RequestUtils {

  Map getAuthToken({
    required userName,
    required passWord,
  }) {
    Map jsonPostData = {
      "username": userName,
      "password": passWord
    };
    return jsonPostData;
  }

  Map getLoginDetail({
    required userName,
    required passWord,
  }) {
    Map  jsonPostData = {
      "username": userName,
      "password": passWord
    };
    return jsonPostData;
  }
}
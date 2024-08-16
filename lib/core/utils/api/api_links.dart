class ApiLinks {
  static const String linkServerName = "http://192.168.1.35:8000";

  static const String _auth = "auth";
  static String signUpLink = "$linkServerName/$_auth/register";
  static String loginLink = "$linkServerName/$_auth/login";
  static String myInfosLink = "$linkServerName/$_auth/my";

  static const String _file = "api/file";
  static String listMyfiles = "$linkServerName/$_file/list";
  static String uploadFile = "$linkServerName/$_file/create/";
}

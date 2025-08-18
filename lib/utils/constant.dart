class Constant {
  static String domain = "https://api.classicvalet.net/";
  static String apiPath = "api/v1/";
  static String base_url = domain + apiPath;

  static bool isShowLog = true;

  static int api_catch_error = 102;
  static int api_no_net = 101;
  static String api_catch_error_msg = 'Something wrong!!!Try Later';
  static String api_no_net_msg = 'No Internet Connection';

  static String STAFF = 'staff';
  static String ID = 'ID';
  static String VENUEID = 'VENUEID';
  static String VENUENAME = 'VENUENAME';

  static showLog(var txt) {
    if (isShowLog) print(txt);
  }
}

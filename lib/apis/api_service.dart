import 'dart:convert';
import 'package:drivers_companionn/utils/checkConnection.dart';
import 'package:drivers_companionn/utils/constant.dart';
import 'package:http/http.dart' as http;

Future<dynamic> apiGetService(String api, Map reqData) async {
  try {
    String url = Constant.base_url + api;
    Constant.showLog("===call api===");
    Constant.showLog(url);

    Constant.showLog(reqData);
    bool conn = await isConnection();
    if (conn) {
      final uri = Uri.https(
        Constant.base_url, //domain
        "api", // path
        reqData.map((k, v) =>
            MapEntry(k, v.toString())), // convert all values to String
      );
      final response = await http.get(uri);
      Constant.showLog("Api Result");
      Constant.showLog(response.body);
      return json.decode(response.body);
    } else {
      Map res = {
        'success': Constant.api_no_net,
        'message': Constant.api_no_net_msg
      };
      return res;
    }
  } catch (e) {
    Constant.showLog("error");
    Constant.showLog(e);
    Map res = {
      'success': Constant.api_catch_error,
      'message': Constant.api_catch_error_msg
    };
    return res;
  }
}

Future<dynamic> apiPostService(String api, Map reqData) async {
  try {
    String url = Constant.base_url + api;
    Constant.showLog("===call api===");
    Constant.showLog(url);

    Constant.showLog(reqData);
    bool conn = await isConnection();
    if (conn) {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(reqData),
      );
      Constant.showLog("Api Result");
      Constant.showLog(response.body);
      return json.decode(response.body);
    } else {
      Map res = {
        'success': Constant.api_no_net,
        'message': Constant.api_no_net_msg
      };
      return res;
    }
  } catch (e) {
    Constant.showLog("error");
    Constant.showLog(e);
    Map res = {
      'success': Constant.api_catch_error,
      'message': Constant.api_catch_error_msg
    };
    return res;
  }
}

Future<dynamic> apiPostHeaderService(String api, Map reqData) async {
  try {
    String url = Constant.base_url + api;
    Constant.showLog("===call api===");
    Constant.showLog(url);
    Constant.showLog(reqData);
    bool conn = await isConnection();
    if (conn) {
      final response = await http.post(
        Uri.parse(url),
        body: reqData, //headers: {'brand-id': Constant.brand_id}
      );
      Constant.showLog(url);
      Constant.showLog("Api Result");
      Constant.showLog(response.body);
      return json.decode(response.body);
    } else {
      Map res = {
        'success': Constant.api_no_net,
        'message': Constant.api_no_net_msg
      };
      return res;
    }
  } catch (e) {
    Constant.showLog("error");
    Constant.showLog(e);
    Map res = {
      'success': Constant.api_catch_error,
      'message': Constant.api_catch_error_msg
    };
    return res;
  }
}

Future<dynamic> apiObjPostHeaderService(String api, Map reqData) async {
  try {
    String url = Constant.base_url + api;
    Constant.showLog(url);
    Constant.showLog(reqData);
    //Constant.showLogString(json.encode(reqData));
    bool conn = await isConnection();
    if (conn) {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(reqData),
        // headers: {
        //   'brand-id': Constant.brand_id,
        //   "Content-Type": "application/json"
        // }
      );
      Constant.showLog("Api Result");
      Constant.showLog(response.body);
      return json.decode(response.body);
    } else {
      Map res = {
        'success': Constant.api_no_net,
        'message': Constant.api_no_net_msg
      };
      return res;
    }
  } catch (e) {
    Constant.showLog("error");
    Constant.showLog(e);
    Map res = {
      'success': Constant.api_catch_error,
      'message': Constant.api_catch_error_msg
    };
    return res;
  }
}

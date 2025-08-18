import 'package:drivers_companionn/apis/api_service.dart';
import 'package:drivers_companionn/models/level2model.dart';
import 'package:drivers_companionn/models/level3model.dart';
import 'package:drivers_companionn/models/retrieveCarforPickupModel.dart';
import 'package:drivers_companionn/models/retrievecarinfo.dart';

Future<Map> staffAppRegister(String civilId) async {
  String apiName = "staffApp_register";
  Map reqData = {'civil_id': civilId};
  dynamic res = await apiPostService(apiName, reqData);
  return res;
}

Future<Map> staffAppUpdateRecord(
    String civilId, String phone, String pass) async {
  String apiName = "staffApp_updateRecord";
  Map reqData = {'civil_id': civilId, 'phone': phone, 'pass': pass};
  dynamic res = await apiPostService(apiName, reqData);
  return res;
}

Future<Map> staffAppLogin(String phone, String pass) async {
  String apiName = "staffApp_login";
  Map reqData = {'phone': phone, 'pass': pass};
  dynamic res = await apiPostService(apiName, reqData);
  return res;
}

Future<RetrieveCarInfo?> retrieveCarinfoData(String keyTag, int venueId) async {
  String apiName = "retrieveCarinfo";
  Map reqData = {'keytag': keyTag, 'venueid': venueId};
  dynamic res = await apiPostService(apiName, reqData);
  return RetrieveCarInfo.fromJson(res);
  //return res;
}

Future<Level2Model?> retrieveLevel2Data(int venueId, String level1) async {
  String apiName = "retrieveLevel2";
  Map reqData = {'venueid': venueId, 'level1': level1};
  dynamic res = await apiPostService(apiName, reqData);
  return Level2Model.fromJson(res);
  //return res;
}

Future<Level3Model?> retrieveLevel3Data(
    int venueId, String level1, String level2) async {
  String apiName = "retrieveLevel3";
  Map reqData = {'venueid': venueId, 'level1': level1, 'level2': level2};
  dynamic res = await apiPostService(apiName, reqData);
  return Level3Model.fromJson(res);
  //return res;
}

Future<Map?> staffAppUpdateParkingData(String barcode, int staffID,
    String level1, String level2, String level3, String level4) async {
  String apiName = "staffApp_updateParking";
  Map reqData = {
    'barcode': barcode,
    'ID': staffID,
    'level1': level1,
    'level2': level2,
    'level3': level3,
    if (level4.isNotEmpty) 'level4': level4
  };
  dynamic res = await apiPostService(apiName, reqData);
  // return Level3Model.fromJson(res);
  return res;
}

Future<RetrieveCarforPickupModel> retrieveCarforPickupData(
    String keyTag) async {
  String apiName = "retrieveCarforPickup";
  Map reqData = {'keytag': keyTag};
  dynamic res = await apiPostService(apiName, reqData);
  return RetrieveCarforPickupModel.fromJson(res);
  //return res;
}

//updatePickup
Future<Map?> updatePickupData(
    String barcode, int staffID, String parkingLocation) async {
  String apiName = "updatePickup";
  Map reqData = {
    'barcode': barcode,
    'staff_id': staffID,
    'parking_location': parkingLocation,
  };
  dynamic res = await apiPostService(apiName, reqData);
  return res;
}

//forgotPassword
Future<Map?> forgotPasswordData(String civilid, String otp) async {
  String apiName = "forgotPassword";
  Map reqData = {
    'civilid': civilid,
    'otp': otp,
  };
  dynamic res = await apiPostService(apiName, reqData);
  return res;
}

//changePassword
Future<Map?> changePasswordData(String civilid, String password) async {
  String apiName = "changePassword";
  Map reqData = {
    'civilid': civilid,
    'newpassword': password,
  };
  dynamic res = await apiPostService(apiName, reqData);
  return res;
}

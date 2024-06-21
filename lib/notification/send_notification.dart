import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'access_firebase_token.dart';

void sendMessage(List<String> tokens) async {
  AccessTokenFirebase accessTokenGetter = AccessTokenFirebase();
  String accessToken = await accessTokenGetter.getAccessToken();
  print(accessToken);
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken'
  };

  for (var token in tokens) {
    var data = json.encode({
      "message": {
        "token": token,
        "notification": {"body": "be_careful".tr(), "title": "warning".tr()}
      }
    });

    var dio = Dio();
    var response = await dio.request(
      'https://fcm.googleapis.com/v1/projects/tomatiopianote/messages:send',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully to $token');
    } else {
      print('Failed to send notification to $token: ${response.statusMessage}');
    }
  }
}
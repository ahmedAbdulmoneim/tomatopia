import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import 'access_firebase_token.dart';

void sendMessage(List<String> tokens,body) async {
  AccessTokenFirebase accessTokenGetter = AccessTokenFirebase();
  String accessToken = await accessTokenGetter.getAccessToken();
  debugPrint(accessToken);
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken'
  };

  for (var token in tokens) {
    var data = json.encode({
      "message": {
        "token": token,
        "notification": {"body": body, "title": "be_careful".tr()}
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
      debugPrint('Notification sent successfully to $token');
    } else {
      debugPrint('Failed to send notification to $token: ${response.statusMessage}');
    }
  }
}
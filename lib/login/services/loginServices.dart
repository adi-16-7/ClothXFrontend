// ignore_for_file: unnecessary_null_comparison

import 'package:clothx/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' as foundation;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:sms_autofill/sms_autofill.dart';

import 'package:clothx/phoneAuth/phoneAuthService.dart';
import 'package:clothx/providers/appConfig.dart';

Future<void> generateOTP(
    String countryCode, String mobileNumber, BuildContext context) async {
  //API called in loginScreen.dart
  FlutterSecureStorage storage = FlutterSecureStorage();
  String? signInMethod = await storage.read(key: 'isEmailSignIn');
  // String? referralCode = await storage.read(key: 'referralCode');
  String signature = "ClothX";
  if (!foundation.kIsWeb)
    signature = await SmsAutoFill().getAppSignature;
  else
    signature = 'clothx';
  final response = await http.put(
    Uri.parse(AppConfig.baseUrl + 'user/mobile-login/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      "country_code": countryCode,
      "mobile_number": mobileNumber,
      "signin_method": int.parse(signInMethod!),
      "app_signature": signature,
      // "referral_code": referralCode
    }),
  );
  generateOTPResponse(response, context, countryCode, mobileNumber);
}

Future<int> basicDetailsAPI(String firstName, String lastName, String email,
    BuildContext context) async {
  //API called in loginScreen.dart
  FlutterSecureStorage storage = FlutterSecureStorage();
  // String? signInMethod = await storage.read(key: 'isEmailSignIn');
  final response = await http.put(
    Uri.parse(AppConfig.baseUrl + 'user/basic-details/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${Provider.of<Auth>(context, listen: false).token}',
    },
    body: jsonEncode(<String, dynamic>{
      "first_name": firstName,
      "last_name": lastName,
      "email": email
      // "referral_code": referralCode
    }),
  );
  return generateBasicDetailsAPIResponse(
      response, context, firstName, lastName, email);
}

int generateBasicDetailsAPIResponse(http.Response response,
    BuildContext context, String firstName, String lastName, String email) {
  if (response.statusCode > 201) {
    var error_text = "";
    if (response.body.toString() != null) {
      var error_text = response.body.toString();
    } else {
      var error_text = "We faced an Error. Apologies for the inconvinience";
    }
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
        content: Text(error_text),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
    Navigator.of(context).pushNamed(
      // have a screen for showing the error
      '/error',
    );
    return -1;

    // throw Exception('Failed to save Basic Details Info for the user.');
  } else {
    return 1;
  }
}

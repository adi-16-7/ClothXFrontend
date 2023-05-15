import 'dart:convert';
// import 'dart:js';
import 'package:clothx/login/screens/basicDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import 'package:clothx/providers/auth.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:clothx/providers/appConfig.dart';



generateOTPResponse(
    http.Response response, context, countryCode, mobileNumber) {
  if (response.statusCode == 200) {
    if (jsonDecode(response.body)["is_user_deleted"] == false) {
      Provider.of<Auth>(context, listen: false).updateStatusFalse();
      int id = jsonDecode(response.body)[
          "id"]; //Getting the ID of the user after SignUp and using throughout

      String country_code = countryCode;
      String mobile_number = mobileNumber;

      Provider.of<Auth>(context, listen: false).updatePeopleId(id);
    } else {
      Provider.of<Auth>(context, listen: false).updateStatusTrue();
    }
  } else if (response.statusCode == 401) {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login failed!',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .merge(TextStyle(color: Color(0XFFFF0000))),
            ),
          ],
        ),
        content: Text(
          'To login into the app, you need referral code. '
          'Please contact moderator of the campaign you wish to join',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
    throw Exception('Attempt to sign up without referral code');
  } else {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Failed to create OTP during SignUp'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
    throw Exception('Failed to create OTP during SignUp');
  }
}


regenerateOTPResponse(http.Response response, context) {
  if (response.statusCode == 201) {
    int newOtp = jsonDecode(response.body)["OTP"];
    Provider.of<Auth>(context).updateNewOtp(newOtp);
  } else {
    print(response.reasonPhrase);
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Failed to load OTP'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
    throw Exception('Failed to load OTP');
  }
}



Future<void> regenerateOTP(
    String countryCode, String mobileNumber, BuildContext context) async {
  //This API will be called when User wants to get the OTP again
  String signature = "";
  if (!foundation.kIsWeb)
    signature = await SmsAutoFill().getAppSignature;
  else
    signature = 'flockngo';
  final response = await http.post(
    Uri.parse(AppConfig.baseUrl + 'user_api/resend-otp/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      "country_code": countryCode,
      "mobile_number": mobileNumber,
      "app_signature": signature,
    }),
  );
  regenerateOTPResponse(response, context);
}

validateOTPResponse(http.Response response, context, mobileNo) async {
  if (response.statusCode == 200) {
    var loginStatus = jsonDecode(response.body)["login_status"];
    // var loggedInUserType = jsonDecode(response.body)['user_login_type'];
    if (loginStatus == false) {
      await Future.delayed(Duration(seconds: 1));
      Navigator.of(context).pushNamed(
        // have a screen for showing the error
        '/error',
      );
      return;
    }
    var state = jsonDecode(response.body)["status"];
    String token = jsonDecode(response.body)["access_token"];
    bool isNewUser = jsonDecode(response.body)["is_new_user"];
    var countryCode = jsonDecode(response.body)["country_code"];
    var isoCode = jsonDecode(response.body)["iso_code"];
    // ignore: unused_local_variable
    var refreshToken = jsonDecode(response.body)["refresh_token"];

    DateTime _expiryDate = DateTime.now().add(Duration(
        days:
            30)); //Auto logout feature has been set to manually happen in 1 day
    Provider.of<Auth>(context, listen: false)
        .updatePhoneAtuhCreds(state, token, isNewUser, _expiryDate, countryCode);
    // if (!foundation.kIsWeb && loggedInUserType != "LEAD")
    //   await registerDevice(
    //       token, Provider.of<Auth>(context, listen: false).id, context);
    if (isNewUser) {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => BasicDetailsScreen(
                    // mobileNo: mobileNo,
                    // countryCode: countryCode,
                  )));
    } else {
      // Navigator.pushNamedAndRemoveUntil(
      //     context, DashboardScreen.routeName, (route) => false);
      print("User is not new");
    }
    final secureStorage = new FlutterSecureStorage();
    await secureStorage.write(key: 'isNewUser', value: isNewUser.toString());
    await secureStorage.write(key: 'token', value: token);
    await secureStorage.write(key: 'countryCode', value: countryCode.toString());
    await secureStorage.write(
        key: 'userId',
        value: Provider.of<Auth>(context, listen: false).id.toString());
    await secureStorage.write(
        key: 'expiryDate', value: _expiryDate.toIso8601String());
  } else {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Failed to verify OTP'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
    throw Exception('Failed to verify OTP');
  }
}


Future<void> validateOTP(String countryCode, String mobileNumber, int otp, BuildContext context) async {
  //This API request is to check whether the OTP entered is true or not
  final response = await http.put(
    Uri.parse(AppConfig.baseUrl + 'user/otp-validation/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      "Connection": "Keep-Alive",
    },
    body: jsonEncode(<String, dynamic>{
      //These 3 fields are needed to be send to API for checking or validating
      "country_code": countryCode,
      "mobile_number": mobileNumber,
      "otp": otp,
    }),
  );
  validateOTPResponse(response, context, mobileNumber);
}


int otpValidationResponse(http.Response response, context, mobileNo) {
  if (response.statusCode == 200) {
    var loginStatus = jsonDecode(response.body)["login_status"];
    // var loggedInUserType = jsonDecode(response.body)['user_login_type'];
    if (loginStatus == false) {
      // await Future.delayed(Duration(seconds: 1));
      Navigator.of(context).pushNamed(
        // have a screen for showing the error
        '/error',
      );
      return -1;
    }
    var state = jsonDecode(response.body)["status"];
    String token = jsonDecode(response.body)["access_token"];
    bool isNewUser = jsonDecode(response.body)["is_new_user"];
    var countryCode = jsonDecode(response.body)["country_code"];
    var isoCode = jsonDecode(response.body)["iso_code"];
    // ignore: unused_local_variable
    var refreshToken = jsonDecode(response.body)["refresh_token"];

    DateTime _expiryDate = DateTime.now().add(Duration(
        days:
            30)); //Auto logout feature has been set to manually happen in 1 day
    Provider.of<Auth>(context, listen: false)
        .updatePhoneAtuhCreds(state, token, isNewUser, _expiryDate, countryCode);
    // if (!foundation.kIsWeb && loggedInUserType != "LEAD")
    //   await registerDevice(
    //       token, Provider.of<Auth>(context, listen: false).id, context);
    // if (isNewUser) {
    //   Navigator.of(context).pop();
    //   Navigator.of(context).push(
    //       MaterialPageRoute(
    //           builder: (context) => BasicDetailsScreen(
    //                 // mobileNo: mobileNo,
    //                 // countryCode: countryCode,
    //               )));
    // } else {
    //   // Navigator.pushNamedAndRemoveUntil(
    //   //     context, DashboardScreen.routeName, (route) => false);
    //   print("User is not new");
    // }
    final secureStorage = new FlutterSecureStorage();
    secureStorage.write(key: 'isNewUser', value: isNewUser.toString());
    secureStorage.write(key: 'token', value: token);
    secureStorage.write(key: 'countryCode', value: countryCode.toString());
    secureStorage.write(
        key: 'userId',
        value: Provider.of<Auth>(context, listen: false).id.toString());
    secureStorage.write(
        key: 'expiryDate', value: _expiryDate.toIso8601String());
    if (isNewUser) {
      return 1;
    } else {
      return 0;
    }
    
  } else {
    // showDialog<String>(
    //   context: context,
    //   builder: (BuildContext context) => AlertDialog(
    //     title: const Text('Error'),
    //     content: const Text('Failed to verify OTP'),
    //     actions: <Widget>[
    //       TextButton(
    //         onPressed: () => Navigator.pop(context, 'Cancel'),
    //         child: const Text('Cancel'),
    //       ),
    //     ],
    //   ),
    // );
    // throw Exception('Failed to verify OTP');
    print(response.body);
    return -1;
  }
}




Future<int> otpValidation(String countryCode, String mobileNumber, int otp, BuildContext context) async {
  final response = await http.put(
    Uri.parse(AppConfig.baseUrl + 'user/otp-validation/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      "Connection": "Keep-Alive",
    },
    body: jsonEncode(<String, dynamic>{
      //These 3 fields are needed to be send to API for checking or validating
      "country_code": countryCode,
      "mobile_number": mobileNumber,
      "otp": otp,
    }),
  );
  return otpValidationResponse(response, context, mobileNumber);
}
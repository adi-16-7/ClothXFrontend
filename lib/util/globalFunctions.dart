
// import 'dart:convert';
// import 'dart:io';
// import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:clothx/providers/appConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:intl/intl.dart';
// import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';

void openLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const DefaultTextStyle(
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              child: Text(
                'Loading...',
              )),
          Container(
            height: 10,
          ),
          Container(
            height: 25,
            width: 25,
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        ],
      );
    },
  );
}

Widget screenLoader() {
  return Padding(
    padding: EdgeInsets.all(15.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DefaultTextStyle(
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700),
            child: Text(
              'Loading...',
            )),
        Container(
          height: 10,
        ),
        Container(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            color: Colors.grey.shade700,
          ),
        )
      ],
    ),
  );
}


Future<AppConfig> getEnvJsonDetails(String env) async {
  final contents = await rootBundle.loadString(
    'assets/config/$env.json',
  );
  final json = jsonDecode(contents);
  AppConfig.baseUrl = json['baseUrl'];
  return AppConfig(
      // razorPayKey: json['razorPayKey'],
      androidPackage: json['androidPackage'],
      iOSPackage: json['iOSPackage']);
}
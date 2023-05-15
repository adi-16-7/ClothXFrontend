import 'package:flutter/cupertino.dart';

class AppConfig with ChangeNotifier {
    static String baseUrl = '';
    // String razorPayKey = '';
    String androidPackage = '';
    String iOSPackage = '';

    AppConfig(
		{
			// required this.razorPayKey,
			required this.androidPackage,
			required this.iOSPackage
		}
	);
}
import 'package:clothx/login/screens/basicDetailsScreen.dart';
import 'package:clothx/login/screens/loginScreen.dart';
import 'package:clothx/login/screens/splashScreen.dart';
import 'package:clothx/login/screens/validateOtpScreen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
	static Route<dynamic> generateRoute(RouteSettings settings) {
		switch (settings.name) {
			case '/':
        		return MaterialPageRoute(builder: (_) => SplashScreen());
			case LoginScreen.routeName:
				return MaterialPageRoute(builder: (_) => LoginScreen());
			case ValidateOtpScreen.routeName:
        		return MaterialPageRoute(builder: (_) => ValidateOtpScreen());
			case SplashScreen.routeName:
				return MaterialPageRoute(builder: (_) => SplashScreen());
			case '/basic-details':
				return MaterialPageRoute(builder: (_) => BasicDetailsScreen());
			default:
        		return MaterialPageRoute(builder: (_) => LoginScreen());
		}
	}
}
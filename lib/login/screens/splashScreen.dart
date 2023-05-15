import 'dart:async';

import 'package:clothx/login/screens/loginScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash-screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

	@override
	void initState() {
		// TODO: implement initState
		super.initState();
		startTime();
	}

	@override
	Widget build(BuildContext context) {
		return Container(
			decoration: const BoxDecoration(
				image: DecorationImage(
					image: AssetImage('assets/vectors/splashBackdrop.png'),
					fit: BoxFit.cover,
				),
			),
			child: Scaffold(
				backgroundColor: Colors.transparent,
				body: Center(
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Image.asset(
								'assets/vectors/splashLogo.png',
								width: 200,
								height: 200,
							),
						],
					),
				),
			)
		);
	}

	Future<Timer> startTime() async {
		var duration = const Duration(seconds: 3);
		return Timer(duration, route);
	}

	void route() {
		Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
	}
}

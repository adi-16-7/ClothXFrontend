import 'dart:async';

import 'package:clothx/login/screens/basicDetailsScreen.dart';
import 'package:clothx/login/services/loginServices.dart';
import 'package:clothx/phoneAuth/phoneAuthService.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:clothx/util/globalFunctions.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:provider/provider.dart';

class ValidateOtpScreen extends StatefulWidget {
	static const routeName = '/otp-validate';
	final String phoneNumber;
	final String countryCode;

	ValidateOtpScreen(
		{this.phoneNumber = '',
		this.countryCode = ''});

	@override
	_ValidateOtpScreenState createState() => _ValidateOtpScreenState();
}

class _ValidateOtpScreenState extends State<ValidateOtpScreen> with TickerProviderStateMixin, CodeAutoFill {
	var otp;
	var _isLoading = false;
	bool _buttonVisibility = false;
	int _counter = 30;
	late Timer _timer;
	TextEditingController _otpController = TextEditingController();
  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
  bool hasError = false;

	void _startTimer() {
		_counter = 30;

		_timer = Timer.periodic(Duration(seconds: 1), (timer) {
			if (mounted) {
				setState(() {
					if (_counter > 0) {
						_counter--;
					} else {
						_timer.cancel();
						_buttonVisibility = true;
					}
				});
			}
		});
	}

	@override
	void initState() {
		super.initState();
		if (!foundation.kIsWeb) listenForCode();
		_startTimer();
	}

	@override
	Widget build(BuildContext context) {
		final deviceSize = MediaQuery.of(context).size;
		String timerStr = '';
		if (_counter < 10) {
		timerStr = '0:0';
		} else {
		timerStr = '0:';
		}
		return Container(
			decoration: const BoxDecoration(
				image: DecorationImage(
					image: AssetImage("assets/vectors/background.jpg"),
					fit: BoxFit.cover,
				),
			),
			child: Scaffold(
			backgroundColor: Colors.transparent,
			appBar: PreferredSize(
						preferredSize: Size.fromHeight(30),
						child: AppBar(
							backgroundColor: Colors.transparent,
							// elevation: 0,

							// title: Text(
							// 'Enter Your OTP',
							// style: Theme.of(context)
							// 	.appBarTheme
							// 	.titleTextStyle!
							// 	.merge(TextStyle(fontSize: 24)),
							// ),
						),
			),
			body: _isLoading
				? //This condition if for checking whether to show Screen Loader or not
				Center(
					child: screenLoader(),
					)
				: SingleChildScrollView(
					child: Column(
						mainAxisSize: MainAxisSize.max,
						mainAxisAlignment: MainAxisAlignment.center,
						crossAxisAlignment: CrossAxisAlignment.center,
						children: <Widget>[
							Padding(
								padding: EdgeInsets.fromLTRB(
									deviceSize.width * .05, 
									deviceSize.height *.025, 
									deviceSize.width * .05, 
									deviceSize.height * .05),
							),
							Image.asset(
								"assets/vectors/loginLogo2.png",
								width: 91.3,
								height: 78,
							),
						// Padding(
						// 	padding: EdgeInsets.fromLTRB(
						// 		40, 20, 40, MediaQuery.of(context).size.height * .2),
						// 	child: Text(
						// 		'OTP sent to your mobile number :${widget.countryCode}-${widget.phoneNumber}',
						// 		style: Theme.of(context).textTheme.headlineSmall),
						// ),
						Padding(padding: EdgeInsets.only(top: 30)),
						RichText(
							text: const TextSpan(
								children: <TextSpan>[
									TextSpan(
										text: 'OTP sent to your mobile number :', 
										style: TextStyle(
											fontWeight: FontWeight.normal,
											color: Colors.grey,
										), 
									),
								],
							),
						),
						RichText(
							text: TextSpan(
								children: <TextSpan>[
									TextSpan(
										text: '${widget.countryCode}-${widget.phoneNumber}', 
										style: const TextStyle(
											fontWeight: FontWeight.normal,
											color: Colors.grey,
										), 
									),
								],
							),
						),
						Padding(padding: EdgeInsets.only(top: 15)),
						Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget> [
								RichText(
									text: const TextSpan(
										children: <TextSpan>[
											TextSpan(
												text: 'Not your number?', 
												style: TextStyle(
													fontWeight: FontWeight.normal,
													color: Colors.black,
												), 
											),
										],
									),
								),
								TextButton(
									style: ButtonStyle(
										overlayColor: MaterialStateProperty.all<Color>(Color(0xFFD7FC70)),
										shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
										backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
										elevation: MaterialStateProperty.all<double>(0),
									),
									child:  Text(
										'Change',
										textAlign: TextAlign.center,
										style: Theme.of(context).textTheme.titleLarge!.merge(
											const TextStyle(
												fontWeight: FontWeight.w600,
												color: Color(0xFFEF5099))),
									),
									onPressed: () async {
									// await regenerateOTP(widget.countryCode,
									// 	widget.phoneNumber, context); //For resending the OTP
									// setState(() {
									// 	_buttonVisibility = false;
									// });
									// _startTimer();
									// navigate to the previous screen
									Navigator.pop(context);
									},
								),
							]
						),

						Padding(padding: EdgeInsets.fromLTRB(40, 20, 40, 0)),
						Container(
							color: Colors.transparent,
							padding: EdgeInsets.fromLTRB(
								MediaQuery.of(context).size.width * .15,
								0,
								MediaQuery.of(context).size.width * .15,
								0),
							child: PinCodeTextField(
								backgroundColor: Colors.transparent,
								length: 4,
								errorTextSpace: Checkbox.width,
								errorAnimationController: errorController,
								animationType: AnimationType.fade,
								keyboardType: TextInputType.number,
								pastedTextStyle: TextStyle(color: Colors.black),
								useHapticFeedback: true,
								hapticFeedbackTypes: HapticFeedbackTypes.light,
                autoFocus: true,
								// autovalidateMode: AutovalidateMode.onUserInteraction,
								pinTheme: PinTheme(
									shape: PinCodeFieldShape.box,
									activeColor: Color(0xFFEF5099),
									selectedFillColor: Colors.white,
									errorBorderColor: Colors.red,
									// fillColor: Colors.white,
									inactiveFillColor: Colors.white,
									activeFillColor: Colors.white,
									fieldHeight: 60,
									fieldWidth: 60,
									borderWidth: 1,
									borderRadius: BorderRadius.circular(10),
									inactiveColor: Colors.grey,
									selectedColor: Color(0xFFEF5099)),
								animationDuration: Duration(milliseconds: 300),
								controller: _otpController,
								textStyle: Theme.of(context).textTheme.bodyMedium!.merge(
									TextStyle(fontSize: 30, color: Colors.black)),
								onCompleted: (v) async {
									var res = await otpValidation(widget.countryCode, widget.phoneNumber, int.parse(v), context);
									if (res==-1){
										errorController.add(ErrorAnimationType.shake); // This will shake the pin code field
										setState(() {
											otp = int.parse(v);
											hasError = true;
										});
									} else {
										if (res==1) {
											Navigator.of(context).pop();
											Navigator.of(context).push(
												MaterialPageRoute(
													builder: (context) => BasicDetailsScreen(
															// mobileNo: mobileNo,
															// countryCode: countryCode,
													)));
                    } else {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BasicDetailsScreen(
                            // mobileNo: mobileNo,
                            // countryCode: countryCode,
                          )));
										}
									}
									print("completed and reached end");
								},
								onChanged: (value) {
									print(value);
								},
								beforeTextPaste: (text) {
									if (!isNumeric(text!)) {
									showDialog(
										context: context,
										builder: (c) {
											return const AlertDialog(
											title: Text('Alert'),
											content: Text('Copied data is not numeric.'),
											);
										});
									return false;
									}
									return true;
								},
								appContext: context,
							),
						),
						Padding(
							padding: const EdgeInsets.symmetric(horizontal: 30.0),
							child: Text(
							hasError ? "*Incorrect OTP" : "",
							style: const TextStyle(
								color: Colors.red,
								fontSize: 12,
								fontWeight: FontWeight.w400),
							),
						),
						// Container(
						// 	height: 10,
						// ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  // show button in grey until the timer is not finished
                  onPressed: _buttonVisibility ? 
                    () async {
                      await generateOTP(widget.countryCode, widget.phoneNumber, context); //For resending the OTP
                      setState(() {
                        _buttonVisibility = false;
                        hasError = false;
                      });
                      _otpController.clear();
                      _startTimer();
                    } : null,
                  child: Text(
                    'Resend OTP',
                    textAlign: TextAlign.center,
                    style: _buttonVisibility ? Theme.of(context).textTheme.titleLarge!.merge(
                      const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFEF5099))) 
                        : Theme.of(context).textTheme.titleLarge!.merge(
                      const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey)) ,
                    ),
                ),
                Text(
                  'in $timerStr$_counter',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.merge(
                    const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey)),
                ),
              ],
            ),
						// Container(
						// 	height: 30,
						// ),
						],
					),
					),
			bottomSheet: Container(
				decoration: const BoxDecoration(
						image: DecorationImage(
						image: AssetImage("assets/vectors/background.jpg"),
						fit: BoxFit.cover,
					),
				),
				padding: EdgeInsets.fromLTRB(0, 0, 0, deviceSize.height * .31),
				child: Visibility(
				visible: !_isLoading,
				child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				
				children: [
					Padding(
					padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 15.0),
					child: Container(
						width: MediaQuery.of(context).size.width * .85,
						child: ElevatedButton(
							style: ElevatedButton.styleFrom(
							elevation: 0, backgroundColor: Color(0xFFD7FC70),
							),
							onPressed: otp != null
								? () async {
									await validateOTP(
										widget.countryCode,
										widget.phoneNumber,
										otp,
										context); //Calling the validation API
									setState(() {
									_isLoading = true; //To start the loader
									});
								}
								: null,
							child: Padding(
							padding: const EdgeInsets.all(15.0),
							child: Text(
								'Verify',
								style: Theme.of(context)
									.textTheme
									.labelLarge!
									.merge(TextStyle(color: Colors.black)),
															
							),
							)),
					),
					),
				],
				),
			),
			),
			)

		);
	}

	bool isNumeric(String s) {
		if (s.isEmpty) {
		return false;
		}
		return double.tryParse(s) != null;
	}

	@override
	void codeUpdated() {
		setState(() {
		if (!foundation.kIsWeb) _otpController.text = code!;
		});
	}

	@override
	void dispose() {
		super.dispose();
		_timer.cancel();
		if (!foundation.kIsWeb) {
		cancel();
		unregisterListener();
		}
	}
}

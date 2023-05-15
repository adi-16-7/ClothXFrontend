import 'package:clothx/login/screens/validateOtpScreen.dart';
import 'package:clothx/login/services/loginServices.dart';
import 'package:clothx/providers/auth.dart';
import 'package:clothx/util/globalFunctions.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/src/widgets/basic.dart';
// import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:phone_form_field/phone_form_field.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';

// import '../../util/globalFunctions.dart';





class LoginScreen extends StatefulWidget {
	const LoginScreen({
		Key? key
	}) : super(key: key);
	static const routeName = '/landing-page';

	@override
	_LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
	// late User _user;
	int? groupValue = 0;

	void getPhoneNumber(String phoneNumber) async {
    // ignore: unused_local_variable
		// PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'IN');
  	}

	TextEditingController firstName = TextEditingController();
	TextEditingController lastName = TextEditingController();
	GlobalKey<FormState> _key = GlobalKey();

	@override
	Widget build(BuildContext context) {
		final deviceSize = MediaQuery.of(context).size;
		return Container(
			decoration: const BoxDecoration(
				image: DecorationImage(
					image: AssetImage("assets/vectors/background.jpg"),
					fit: BoxFit.cover,
				),
			),
			child: Container(
				margin: EdgeInsets.fromLTRB(deviceSize.width * 0.06, 0.0, deviceSize.width * 0.06, 0.0),
				color: Colors.transparent,
				child: Scaffold(
					backgroundColor: Colors.transparent,
					appBar: PreferredSize(
						preferredSize: Size.fromHeight(deviceSize.height * .10),
						child: Row(
							// mainAxisAlignment: MainAxisAlignment.center,
							// elevation: 0,
							children: [
								Padding(padding: EdgeInsets.fromLTRB(deviceSize.width * .7, deviceSize.height * .5, 0.0, deviceSize.height * .0)),
								buildTopBar()
							],
						),
						
					),
					
						// buildTopBar()),
					body: SingleChildScrollView(
						child: Column(
							mainAxisSize: MainAxisSize.max,
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							crossAxisAlignment: CrossAxisAlignment.center,
							children: <Widget>[
								// buildTopBar(),
								// Padding(padding: EdgeInsets.only(top: deviceSize.height * .00)),
								Container(
									height: deviceSize.height * .01,
								),
								// increase the size of the logo
								Image.asset(
									"assets/vectors/loginLogo2.png",
									width: 91.3,
									height: 78,
								),
								Padding(padding: EdgeInsets.only(top: deviceSize.height * .035)),
								RichText(
									text: const TextSpan(
										// text: 'Login ',
										// style: DefaultTextStyle.of(context).style,
										children: <TextSpan>[
											TextSpan(
												text: 'Login', 
												style: TextStyle(
													fontWeight: FontWeight.bold,
													color: Colors.black,
												), 
											),
											TextSpan(
												text: ' or ', 
												style: TextStyle(
													fontWeight: FontWeight.bold,
													color: Colors.grey,
												), 
											),
											TextSpan(
												text: 'Signup',
												style: TextStyle(
													fontWeight: FontWeight.bold,
													color: Colors.black,)
											),
										],
									),
								),
								// _getLogInSection(deviceSize),
								const LoginSection(),
							],
						),
					),
					// bottomSheet: 
				),
			),
		);
	}

	  final TextEditingController controller = TextEditingController();
	// final PhoneController controller = PhoneController(null);
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  var no, sendOtp = false;
  static String countryCode = "", mobileNumber = "", isoCode = "IN";

  Widget _getLogInSection(Size deviceSize) {
	bool isTenDigits = false;
    return Column(
      children: [
        // Container(
        //   height: deviceSize.height * .01,
        // ),
		// Padding(padding: EdgeInsets.only(top: 60.0)),
		const Padding(padding: EdgeInsets.only(top: 75.0)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
				vertical: 10.0
              ),
              child: Text(
                'Mobile Number',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              width: deviceSize.width,
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: 
			  Padding(
                padding: EdgeInsets.only(left: deviceSize.width * .02),
                child: 
				ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
					color: Colors.white,

					// a text form field with a phone number input formatter, length limiting input formatter, and a prefix text as a country code
					// this also needs validation to check if the phone number is valid or not

					child: TextFormField(
						controller: controller,
						keyboardType: const TextInputType.numberWithOptions(
							signed: false,
							decimal: false,
						),
						inputFormatters: [
							FilteringTextInputFormatter.digitsOnly,
							LengthLimitingTextInputFormatter(10),
						],
						decoration: const InputDecoration(
							// labelText: 'Phone number',
							hintText: 'Mobile Number',
							prefixText: '+91 ',
						),
						validator: (value) {
							if (value!.isEmpty) {
								return 'Please enter your mobile number';
							}
							if (value.length < 10) {
								return 'Please enter a valid mobile number';
							}
							// set sendotp as true in set state
							 if (value.length == 10) {
								setState(() {
									isTenDigits = true;
								});
							 }


							// setState(() {
							// 	sendOtp = true;
							// });
							return null;
						},
						onChanged: (value) {
							if (value.length == 10) {
								setState(() {
									sendOtp = true;
								});
							} else {
								setState(() {
									sendOtp = false;
								});
							}
						},
					),

					// child: TextFormField(
					// 	controller: controller,
					// 	keyboardType: const TextInputType.numberWithOptions(
					// 		signed: false,
					// 		decimal: false,
					// 	),
					// 	inputFormatters: [
					// 		FilteringTextInputFormatter.digitsOnly,
					// 		LengthLimitingTextInputFormatter(10),
					// 	],
					// 	decoration: const InputDecoration(
					// 		// labelText: 'Phone number',
					// 		hintText: 'Mobile Number',
					// 		prefixText: '+91 ',
					// 	),
					// ),
					

					// child: PhoneFormField(
					// 	// key: inputKey,
					// 	controller: controller,
					// 	shouldFormat: true,
					// 	autofocus: true,
					// 	autofillHints: const [AutofillHints.telephoneNumber],
					// 	countrySelectorNavigator: const CountrySelectorNavigator.dialog(
					// 		countries: [IsoCode.IN],
					// 	),
					// 	defaultCountry: IsoCode.IN,
					// 	// decoration: InputDecoration(
					// 	// 	label: withLabel ? const Text('Phone') : null,
					// 	// 	border: outlineBorder
					// 	// 		? const OutlineInputBorder()
					// 	// 		: const UnderlineInputBorder(),
					// 	// 	hintText: withLabel ? '' : 'Phone',
					// 	// ),
					// 	enabled: true,
					// 	showFlagInInput: false,
					// 	validator: PhoneValidator.validMobile(),
					// 	autovalidateMode: AutovalidateMode.onUserInteraction,
					// 	cursorColor: Theme.of(context).colorScheme.primary,
					// 	// ignore: avoid_print
					// 	onSaved: (p) => print('saved $p'),
					// 	// ignore: avoid_print
					// 	onChanged: (p) => print('changed $p'),
					// 	isCountryChipPersistent: false,
						
					// ),


					// child: 
					// // disable the country code dropdown
					// IntlPhoneField(
					// 	initialCountryCode: 'IN',
					// 	invalidNumberMessage: "*Invalid Mobile Number",
					// 	showDropdownIcon: false,
					// 	showCountryFlag: false,
					// 	// enabled: false,
					// 	countries: const ['IN'],
					// 	// pickerDialogStyle: None,
					// 	controller: controller,
					// 	// initialCountryCode: 'IN',
					// 	// initialValue: ,
					// 	keyboardType: TextInputType.number,
					// 	decoration: const InputDecoration(
					// 		border: OutlineInputBorder(
					// 			borderRadius: BorderRadius.all(Radius.circular(10.0)),
					// 			borderSide: BorderSide(),
					// 		),
					// 		hintText: 'Mobile Number',
					// 		hintStyle: TextStyle(
					// 			color: Colors.grey,
					// 			fontSize: 16.0,
					// 		),
					// 	),
					// ),
					
					// child: InternationalPhoneNumberInput(
					// 	maxLength: 10,
					// 	countries: const ['IN'],
					// 	selectorConfig: const SelectorConfig(
					// 		selectorType: PhoneInputSelectorType.DROPDOWN,
					// 		// countryComparator: (a, b) => a.name.compareTo(b.name),
					// 	),
					// 	onInputChanged: (PhoneNumber number) {
					// 	no = int.parse(number.phoneNumber!);
					// 	countryCode = number
					// 		.dialCode!; //Storing only the Country Code of the Phone No.
					// 	mobileNumber = number.phoneNumber!.replaceAll(countryCode,
					// 		""); //Storing only the mobile no. of the Phone No.
					// 	isoCode = number.isoCode!;
					// 	},
					// 	onInputValidated: (bool value) {
					// 		setState(() {
					// 			sendOtp = value;
					// 		});
					// 	},
					// 	// onSaved: (PhoneNumber number) {
					// 	//   print('On Saved: $number');
					// 	// },
					// 	// selectorConfig: SelectorConfig(
					// 	//   selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
					// 	// ),
					// 	ignoreBlank: false,
					// 	autoValidateMode: AutovalidateMode.onUserInteraction,
					// 	selectorTextStyle: const TextStyle(color: Colors.black),
					// 	initialValue: number,
					// 	textFieldController: controller,
					// 	formatInput: false,
					// 	keyboardType: const TextInputType.numberWithOptions(
					// 		signed: true, decimal: true),
					// 	inputDecoration: const InputDecoration(
					// 		border: InputBorder.none,
					// 	),
					// 	hintText: 'Mobile number',
					// 	validator: (String? value) {
					// 		if (value!.isEmpty) {
					// 			return 'Mobile Number is required';
					// 		} else if (value.length < 10) {
					// 			return 'Mobile Number must be of 10 digit';
					// 		}
					// 		sendOtp = true;
					// 		return null;
					// 	},
					// 	spaceBetweenSelectorAndTextField: 0,
					// 	textAlign: TextAlign.start,
					// 	textAlignVertical: TextAlignVertical.top,
					// 	textStyle: Theme.of(context).textTheme.headlineSmall,
					// ),
				  ),
                ),
              ),
            ),
            Consumer<Auth>(
              builder: (context, value, child) {
                return Visibility(
                  visible: value.isDeleted,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Colors.red,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 9.0,
                        ),
                        const Expanded(
                          child: Text(
                            "A request to delete this account is active therefore you cannot sign-in to FlocknGo. If you have any questions, please send an email to support@flockngo.com",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        // SizedBox(
        //   height: deviceSize.height * .15,
        // ),
      ],
    );
  }
	Widget buildSegment(String text) {
		return Container(
			padding: const EdgeInsets.symmetric(horizontal: 20.0),
			child: Text(
				text,
				style: Theme.of(context).textTheme.bodyLarge,
			),
		);
	}

	// build a widget for a top bar with a skip button
	Widget buildTopBar() {
		return Container(
			padding: const EdgeInsets.only(top: 40.0),
			// margin: EdgeInsets.fromLTRB(20.0, 0.0, 800.0, 0.0),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.end,
				children: [
					// skip button
					TextButton(
						onPressed: () {
							// Navigator.of(context).pushNamedAndRemoveUntil(
							// 	'/home', (Route<dynamic> route) => false);
							Navigator.of(context).pushNamedAndRemoveUntil(
								'/home', (Route<dynamic> route) => false);
						},
						style: ElevatedButton.styleFrom(
							backgroundColor: Colors.transparent,
							shape: RoundedRectangleBorder(
								borderRadius: BorderRadius.circular(20.0),
							),
						),
						child: const Text(
							'Skip',
							style: TextStyle(
								color: Colors.grey,
								fontSize: 16.0,
								fontWeight: FontWeight.w600,
							),
						),
					),
				],
			),
		);
	}
}



class LoginSection extends StatefulWidget {
  const LoginSection({super.key});

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
	var no, sendOtp = false;
  	static String countryCode = "", mobileNumber = "", isoCode = "IN";
	bool isTenDigits = false;
	final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
	final deviceSize = MediaQuery.of(context).size;
    return Column(
      children: [
        // Container(
        //   height: deviceSize.height * .01,
        // ),
		// Padding(padding: EdgeInsets.only(top: 60.0)),
		const Padding(padding: EdgeInsets.only(top: 75.0)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
				vertical: 10.0
              ),
              child: Text(
                'Mobile Number',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Container(
              width: deviceSize.width,
              margin: const EdgeInsets.symmetric(
                horizontal: 18.0,
              ),
              child: TextFormField(
				style: const TextStyle(
					color: Colors.black,
					fontSize: 14.0,
				),
				// focusNode: FocusNode(),
			  	controller: controller,
			  	keyboardType: const TextInputType.numberWithOptions(
			  		signed: false,
			  		decimal: false,
			  	),
			  	inputFormatters: [
			  		FilteringTextInputFormatter.digitsOnly,
			  		LengthLimitingTextInputFormatter(10),
			  	],
			  	autovalidateMode: isTenDigits ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
			  	decoration: InputDecoration(
					contentPadding: EdgeInsets.only(bottom: 30),
					prefixIcon: SizedBox(
						child: Column(
							mainAxisSize: MainAxisSize.min,
							mainAxisAlignment: MainAxisAlignment.start,
							// widthFactor: 0.0,
							// alignment: Alignment.bottomCenter,
							children: const [
								SizedBox(
									height: 14.2,
									),
								Text(
									'+91',
									style: TextStyle(
										color: Colors.black, 
										fontSize: 14
									),
								),
							]
						),
					),
					hintText: '000 0000 000',
					prefixStyle: TextStyle(color: Colors.black, fontSize: 14),
					// textStyle: TextStyle(color: Colors.black),
					suffixStyle: TextStyle(color: Colors.black),
			  		fillColor: Colors.white,
			  		// labelText: 'Phone number',
					enabledBorder: OutlineInputBorder(
						borderSide: BorderSide(color: Colors.grey),
						borderRadius: BorderRadius.all(Radius.circular(10.0))
					),
					focusedBorder: OutlineInputBorder(
						borderSide: BorderSide(color: Color(0xFFEF5099)),
						borderRadius: BorderRadius.all(Radius.circular(10.0))
					),
					border: OutlineInputBorder(
						borderSide: BorderSide(
							color: Colors.grey,
							width: 1.0,
						),
						borderRadius: BorderRadius.all(Radius.circular(10.0)),
					),
			  	),
			  	validator: (value) {
			  		if (value!.isEmpty) {
			  			return '*Required';
			  		}
			  		if (value.length < 10) {
			  			return '*Invalid Mobile Number';
			  		}
			  		return null;
			  	},
			  	onChanged: (value) {
			  		if (value.length == 10) {
			  			setState(() {
			  				isTenDigits = true;
			  			});
			  		}
			  	},
			  ),
            ),
            Consumer<Auth>(
              builder: (context, value, child) {
                return Visibility(
                  visible: value.isDeleted,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Colors.red,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 9.0,
                        ),
                        const Expanded(
                          child: Text(
                            "A request to delete this account is active therefore you cannot sign-in to FlocknGo. If you have any questions, please send an email to support@flockngo.com",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
			Padding(padding: EdgeInsets.only(top: deviceSize.height * .03)),
			Padding(
				padding: EdgeInsets.fromLTRB(deviceSize.width * .05, 0, deviceSize.width * .05, 0),
				child: 
				Align(
					alignment: Alignment.centerLeft,
					child: RichText(
						text: const TextSpan(
							// text: 'Login ',
							// style: DefaultTextStyle.of(context).style,
							children: <TextSpan>[
								TextSpan(
									text: 'I agree to the Terms of use & privacy Policy', 
									style: TextStyle(
										fontWeight: FontWeight.normal,
										color: Colors.grey
									),
								),
							],
						),
					),
				),
			),
			Padding(padding: EdgeInsets.only(top: deviceSize.height * .02)),
			Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Padding(
						padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 300.0),
						child: Container(
							color: Colors.transparent,
							width: deviceSize.width * .8,
							child: ElevatedButton(
								style: ButtonStyle(
									backgroundColor: MaterialStateProperty.resolveWith((states) =>  const Color(0XFFD7FC70)),
									elevation: MaterialStateProperty.resolveWith((states) => 0),
									shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
										borderRadius: BorderRadius.circular(10),
									)),
								),
								onPressed:
									() async {
										if (controller.value.text.length == 10) {
											mobileNumber = controller.value.text;
											countryCode = '+91';
										openLoadingDialog(context);
										FlutterSecureStorage storage = const FlutterSecureStorage();
										await storage.write(key: 'isEmailSignIn', value: '2');
										var status = context.read<Auth>();
										Provider.of<Auth>(context, listen: false).updateMobileCode(countryCode, mobileNumber);
										generateOTP(countryCode, mobileNumber, context).then((value) {
											print(status.isDeleted);
											if (!status.isDeleted) {
												Navigator.of(context).pop();
												Navigator.of(context).push(
													MaterialPageRoute(
														builder: (context) => ValidateOtpScreen(
															phoneNumber: mobileNumber,
															countryCode: countryCode,
														),
													),
											  );
											} else {
												Navigator.of(context).pop();
											}
										});}; //Calling this function from the idData.dart file for sending country code & mobile no. entered by the user
									},
								child: Padding(
									padding: const EdgeInsets.all(15.0),
									child: Text(
									'Send OTP',
									style: sendOtp
										? Theme.of(context).textTheme.labelLarge!.merge(const TextStyle(color: Colors.black))
										: Theme.of(context)
											.textTheme
											.labelLarge!
											.merge(const TextStyle(color: Colors.black)),
									),
								)
							),
						),
					),
				],
			),
			
          ],
        ),
        // SizedBox(
        //   height: deviceSize.height * .15,
        // ),
      ],
    );
  }
}
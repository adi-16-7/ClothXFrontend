import 'package:clothx/dashboard/screens/dashboardScreen.dart';
import 'package:clothx/login/screens/splashScreen.dart';
import 'package:clothx/login/services/loginServices.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';

class BasicDetailsScreen extends StatefulWidget {
  static const routeName = '/basicDetailsScreen';
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _autovalidate = false;
  bool isEmailValid = false;
  bool reTypeFirst = false;
  bool reTypeLast = false;
  bool reTypeEmail = false;

  @override
  _BasicDetailsScreenState createState() => _BasicDetailsScreenState();
}

class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
//   final firstName = TextEditingController();
//   final lastName = TextEditingController();
//   final email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/vectors/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),

        // child: Container(
        // 	margin: EdgeInsets.fromLTRB(deviceSize.width * 0.1, 0.0, deviceSize.width * 0.1, 0.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(30),
            child: Container(
              margin:
                  EdgeInsets.fromLTRB(deviceSize.width * 0.059, 0.0, 0.0, 0.0),
              child: AppBar(
                backgroundColor: Colors.transparent,
                // leadingWidth: 0.8,
                // automaticallyImplyLeading: false,
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
          ),
          body: Container(
            margin: EdgeInsets.fromLTRB(
                deviceSize.width * 0.1, 0.0, deviceSize.width * 0.1, 0.0),
            child: Form(
              autovalidateMode: widget._autovalidate
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              key: widget._formKey,
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    Container(
                      height: deviceSize.height * .08,
                    ),
                    Text(
                      'You are just',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .merge(const TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                          )),
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    Text(
                      'One Step Away!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .merge(const TextStyle(
                            fontSize: 25,
                            color: Color(0xFFEF5099),
                          )),
                    ),
                    Padding(padding: EdgeInsets.only(top: 50)),
                    // make three input fields for first name, last name and email, with a button to go to the next screen
                    // make sure to validate the input fields
                    Row(
                      children: [
                        Text(
                          'First Name',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 5)),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                        LengthLimitingTextInputFormatter(18),
                      ],
                      validator: (value) => value!.isEmpty
                          ? 'Please enter your first name'
                          : null,
                      cursorColor: Colors.grey,
                      controller: widget._firstNameController,
                      decoration: InputDecoration(
                        // labelText: 'Email',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xFFEF5099),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        labelStyle: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .merge(const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Row(
                      children: [
                        Text(
                          'Last Name',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                        LengthLimitingTextInputFormatter(18),
                      ],
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your last name' : null,
                      cursorColor: Colors.grey,
                      controller: widget._lastNameController,
                      decoration: InputDecoration(
                        // labelText: 'Email',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xFFEF5099),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        labelStyle: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .merge(const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Row(
                      children: [
                        Text(
                          'Email',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    TextFormField(
                      // autovalidateMode: isEmailValid ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                      keyboardType: TextInputType.emailAddress,
                      // call validate function on every tap outside the text field
                      // onTapOutside: (event) {
                      // 	print("tapped outside");
                      // 	_formKey.currentState!.validate();
                      // },
                      // onEditingComplete: () {
                      // 	print("editing complete");
                      // 	_formKey.currentState!.validate();
                      // },
                      // onFieldSubmitted: (value) {
                      // 	print("field submitted");
                      // 	_emailController.validate();
                      // },
                      onChanged: (value) {
                        // setState(() {
                        //   widget.isEmailValid = EmailValidator.validate(value);
                        // });
                        print("onChanged called " +
                            widget.isEmailValid.toString());
                      },
                      controller: widget._emailController,
                      validator: (value) =>
                          value != null && !EmailValidator.validate(value)
                              ? "Please enter a valid email"
                              : null,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        // labelText: 'Email',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xFFEF5099),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        labelStyle: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .merge(const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFD7FC70),
                          // width: MediaQuery.of(context).size.width * .79,
                          minimumSize:
                              Size(MediaQuery.of(context).size.width * .79, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          // 	context,
                          // 	MaterialPageRoute(builder: (context) => SplashScreen()),
                          // );
                          final form = widget._formKey.currentState;
                          if (form!.validate()) {
                            print("validated");
                            var res = basicDetailsAPI(
                              widget._firstNameController.value.toString(),
                              widget._lastNameController.value.toString(),
                              widget._emailController.value.toString(),
                              context
                            );
                            if (res==1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardScreen()),
                              );
                            }
                          } else {
                            print("not validated");
                          }
                          setState(() {
                            widget._autovalidate = true;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Continue',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .merge(TextStyle(color: Colors.black)),
                          ),
                        )),
                    Padding(padding: EdgeInsets.only(top: 30)),
                  ])),
            ),
          ),
          // bottomSheet: Container(
          // 	decoration: const BoxDecoration(
          // 		image: DecorationImage(
          // 			image: AssetImage('assets/vectors/background.jpg'),
          // 			fit: BoxFit.cover,
          // 		),
          // 	),
          // 	padding: EdgeInsets.fromLTRB(0, 0, 0, deviceSize.height * .20),
          // 	// height: deviceSize.height * .1,
          // 	// margin: EdgeInsets.fromLTRB(deviceSize.width * 0.1, 0.0, deviceSize.width * 0.1, 0.0),
          // 	child: Row(
          // 		mainAxisAlignment: MainAxisAlignment.center,
          // 		children:[
          // 			Padding(
          // 				padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 15.0),
          // 				child: Container(
          // 					width: MediaQuery.of(context).size.width * .79,
          // 					child: ElevatedButton(
          // 						style: ElevatedButton.styleFrom(
          // 							backgroundColor: Color(0xFFD7FC70),
          // 							shape: RoundedRectangleBorder(
          // 								borderRadius: BorderRadius.circular(10),
          // 							),
          // 						),
          // 						onPressed: () {
          // 							// Navigator.push(
          // 							// 	context,
          // 							// 	MaterialPageRoute(builder: (context) => SplashScreen()),
          // 							// );
          // 							final form = widget._formKey.currentState;
          // 							if (form!.validate()) {
          // 								print("validated");
          // 							} else {
          // 								print("not validated");
          // 							}
          // 						},
          // 						child: Padding(
          // 							padding: const EdgeInsets.all(15.0),
          // 							child: Text(
          // 								'Continue',
          // 								style: Theme.of(context)
          // 									.textTheme
          // 									.labelLarge!
          // 									.merge(TextStyle(color: Colors.black)
          // 								),
          // 							),
          // 						)
          // 					),
          // 				),
          // 			),
          // 		]
          // 	),
          // ),
        )
        // ),
        );
  }
  //   bottomSheet: Container(
  //     decoration: const BoxDecoration(
  //         image: DecorationImage(
  //         image: AssetImage("assets/vectors/background.jpg"),
  //         fit: BoxFit.cover,
  //       ),
  //     ),
  //     // padding: EdgeInsets.fromLTRB(0, 0, 0, deviceSize.height * .31),
  //     // child: Row(
  //     //   children: [
  //     //     // Padding(padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
  //     //     // child: Container(

  //     //     // ),
  //     //   ],
  //         ),
  //       ),
  //     )
  // );
}

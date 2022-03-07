import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genmote/authentication/login.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:page_transition/page_transition.dart';

import '../app_languages/english.dart';
import '../app_languages/pidginEnglish.dart';
import '../constants.dart';
import '../methods.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  bool _termsNConditions = false;
  bool _hideOrShowPassword = true;

  late String welcomeText,
      createAccount,
      signupText,
      name,
      email,
      phoneNumber,
      password,
      confirmPassword,
      iAgree,
      termsNConditions,
      forgotPassword,
      alreadyHaveAnAccount,
      loginText;

  void _lang() {
    if (Constant.englishLang) {
      welcomeText = English.welcomeText;
      createAccount = English.createAccount;
      loginText = English.loginText;
      email = English.email;
      phoneNumber = English.phoneNumber;
      password = English.password;
      iAgree = English.iAgree;
      termsNConditions = English.termsNConditions;
      forgotPassword = English.forgotPassword;
      signupText = English.signupText;
      name = English.name;
      alreadyHaveAnAccount = English.alreadyHaveAnAccount;
      confirmPassword = English.confirmPassword;
    }

    if (Constant.pidginEnglishLang) {
      welcomeText = PidginEnglish.welcomeText;
      createAccount = PidginEnglish.createAccount;
      loginText = PidginEnglish.loginText;
      email = PidginEnglish.email;
      phoneNumber = PidginEnglish.phoneNumber;
      password = PidginEnglish.password;
      iAgree = PidginEnglish.iAgree;
      termsNConditions = PidginEnglish.termsNConditions;
      forgotPassword = PidginEnglish.forgotPassword;
      signupText = PidginEnglish.signupText;
      name = PidginEnglish.name;
      alreadyHaveAnAccount = PidginEnglish.alreadyHaveAnAccount;
      confirmPassword = PidginEnglish.confirmPassword;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lang();
  }

  void _toggleVisibility() {
    setState(() {
      _hideOrShowPassword = !_hideOrShowPassword;
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Stack(
    //     children: [
    //       Container(
    //         height: double.infinity,
    //         width: double.infinity,
    //         decoration: const BoxDecoration(
    //           // image: DecorationImage(
    //           //   image: AssetImage("assets/backround_main.jpg.png"),
    //           //   fit: BoxFit.cover,
    //           // ),
    //           gradient: LinearGradient(
    //             begin: Alignment.topCenter,
    //             end: Alignment.bottomCenter,
    //             colors: [
    //               Color(0xFFA5D6A7),
    //               Color(0xFF91F086),
    //               Color(0xFF48BF53),
    //             ],
    //             stops: [0.1, 0.4, 0.7],
    //           ),
    //         ),
    //       ),
    //       Container(
    //         height: double.infinity,
    //         child: SingleChildScrollView(
    //           physics: const AlwaysScrollableScrollPhysics(),
    //           padding:
    //               const EdgeInsets.symmetric(horizontal: 30.0, vertical: 100.0),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               const Text(
    //                 'Welcome Back',
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: Constant.fontSizeLarge,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //               const SizedBox(height: 30.0),
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   const Text(
    //                     'Email',
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: Constant.fontSizeSmaller,
    //                     ),
    //                   ),
    //                   const SizedBox(height: 10.0),
    //                   Container(
    //                     alignment: Alignment.centerLeft,
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(20.0),
    //                       shape: BoxShape.rectangle,
    //                     ),
    //                     height: 60.0,
    //                     child: const TextField(
    //                       keyboardType: TextInputType.emailAddress,
    //                       style: TextStyle(color: Colors.white),
    //                       decoration: InputDecoration(
    //                         border: InputBorder.none,
    //                         contentPadding: EdgeInsets.only(top: 14.0),
    //                         prefixIcon: Icon(
    //                           Icons.email,
    //                           color: Colors.white,
    //                         ),
    //                         hintText: 'Enter your email',
    //                         hintStyle: TextStyle(color: Colors.white),
    //                       ),
    //                     ),
    //                   )
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/genmote_main.png"),
            fit: BoxFit.cover,
          ),
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     // Colors.purple,
          //     Constant.mainColor,
          //     Constant.accent,
          //   ],
          // ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _createAccountText(),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                margin: const EdgeInsets.only(top: 50),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        _signupText(),
                        _nameField(),
                        _emailField(),
                        _phoneNumber(),
                        _passwordField(),
                        _confirmPasswordField(),
                        _termsAndConditions(),
                        const SizedBox(height: 20),
                        _signupButton(),
                        const SizedBox(height: 20),
                        // _forgotPassword(),
                        // const SizedBox(height: 20),
                        _loginButton(),

                        // Forgot Password Field
                        // Container(
                        //   width: double.infinity,
                        //   alignment: Alignment.center,
                        //   height: 70,
                        //   margin: const EdgeInsets.only(top: 10),
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         padding: const EdgeInsets.only(left: 25.0),
                        //         child: const Text(
                        //           "Don't have an account?",
                        //           style: TextStyle(
                        //             color: Colors.black54,
                        //             fontSize: 15,
                        //           ),
                        //         ),
                        //       ),
                        //       Container(
                        //         padding: const EdgeInsets.only(right: 25.0),
                        //         child: const Text(
                        //           "Sign Up",
                        //           style: TextStyle(
                        //             color: Colors.black54,
                        //             fontSize: 15,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        // TextButton(
                        //   onPressed: () {},
                        //   child: RichText(
                        //     text: const TextSpan(
                        //       text: "Don't have an account? ",
                        //       style:
                        //           TextStyle(color: Colors.grey, fontSize: 18.0),
                        //       children: <TextSpan>[
                        //         TextSpan(
                        //           text: ' Sign In',
                        //           style: TextStyle(color: Constant.accent),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Image.asset(
                        //       "images/Facebook.png",
                        //       width: 80,
                        //     ),
                        //     const SizedBox(
                        //       width: 15,
                        //     ),
                        //     Image.asset(
                        //       "images/Instagram.png",
                        //       width: 80,
                        //     ),
                        //     const SizedBox(
                        //       width: 15,
                        //     ),
                        //     Image.asset(
                        //       "images/Tiktok.png",
                        //       width: 80,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _createAccountText() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 60),
          padding: const EdgeInsets.only(right: 45.0),
          child: Text(
            welcomeText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            createAccount,
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _signupText() {
    return Container(
      // color: Colors.red,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 25, bottom: 25),
      child: Text(
        signupText,
        style: const TextStyle(
            fontSize: 25,
            color: Colors.black87,
            letterSpacing: 2,
            fontFamily: "Lobster"),
      ),
    );
  }

  Widget _nameField() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(top: 20, bottom: 5, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.accent,
          width: 1,
        ),
        boxShadow: const [
          // BoxShadow(
          //   color: Constant.accent,
          //   blurRadius: 10,
          //   offset: Offset(1, 1),
          // ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.email_outlined),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                decoration: InputDecoration(
                  label: Text(name),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name!';
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailField() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.accent,
          width: 1,
        ),
        boxShadow: const [
          // BoxShadow(
          //   color: Constant.accent,
          //   blurRadius: 10,
          //   offset: Offset(1, 1),
          // ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.email_outlined),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                decoration: InputDecoration(
                  label: Text(email),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Oops! No email... Make sure to enter a real email";
                  }
                  return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)
                      ? null
                      : "This is not an email";
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _phoneNumber() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.accent,
          width: 1,
        ),
        boxShadow: const [
          // BoxShadow(
          //   color: Constant.accent,
          //   blurRadius: 10,
          //   offset: Offset(1, 1),
          // ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.call),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              // child: TextFormField(
              //   keyboardType: TextInputType.phone,
              //   maxLines: 1,
              //   decoration: InputDecoration(
              //     label: Text(phoneNumber),
              //     border: InputBorder.none,
              //   ),
              // ),
              child: IntlPhoneField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  // prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                keyboardType: TextInputType.phone,
                initialCountryCode: 'NG',
                onChanged: (phone) {
                  if (kDebugMode) {
                    print(phone.completeNumber);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.accent,
          width: 1,
        ),
        boxShadow: const [
          // BoxShadow(
          //   color: Constant.accent,
          //   blurRadius: 10,
          //   offset: Offset(1, 1),
          // ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.password_outlined),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: _hideOrShowPassword,
                maxLines: 1,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: _toggleVisibility,
                    child: Icon(
                      _hideOrShowPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 25.0,
                      color: Constant.grey,
                    ),
                  ),
                  label: Text(password),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _confirmPasswordField() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.accent,
          width: 1,
        ),
        boxShadow: const [
          // BoxShadow(
          //   color: Constant.accent,
          //   blurRadius: 10,
          //   offset: Offset(1, 1),
          // ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.password_outlined),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: _hideOrShowPassword,
                maxLines: 1,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: _toggleVisibility,
                    child: Icon(
                      _hideOrShowPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 25.0,
                      color: Constant.grey,
                    ),
                  ),
                  label: Text(confirmPassword),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _termsAndConditions() {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.grey),
            child: Checkbox(
              value: _termsNConditions,
              checkColor: Constant.darkGrey,
              activeColor: Constant.accent,
              onChanged: (value) {
                setState(() {
                  _termsNConditions = value!;
                });
              },
            ),
          ),
          Text(
            iAgree,
            style: const TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
          TextButton(
            onPressed: () {
              Methods.showToast(
                  'Terms and conditions clicked!', ToastGravity.CENTER);
            },
            child: Text(
              termsNConditions,
              style: const TextStyle(
                color: Constant.accent,
                fontSize: Constant.fontSizeSmaller,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _signupButton() {
    return ElevatedButton(
      onPressed: () {
        // Methods.showToast('Signup clicked!', ToastGravity.CENTER);

        Navigator.of(context).pushReplacement(
          PageTransition(
            child: const Login(),
            type: PageTransitionType.fade,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        onPrimary: Constant.accent,
        shadowColor: Constant.accent,
        elevation: 3,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Constant.accent, Constant.mainColor],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 250,
          height: 50,
          alignment: Alignment.center,
          child: Text(
            signupText,
            style: const TextStyle(
              fontSize: Constant.fontSizeSmall,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _forgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20.0),
      child: TextButton(
        onPressed: () {
          Methods.showToast('Forgot password clicked!', ToastGravity.CENTER);
        },
        child: Text(
          forgotPassword,
          style: const TextStyle(
            color: Constant.darkGrey,
            fontSize: Constant.fontSizeSmaller,
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 45.0),
          child: Text(
            alreadyHaveAnAccount,
            style: const TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     Methods.showToast(
        //         'Sign up clicked!', ToastGravity.BOTTOM);
        //   },
        //   child: Container(),
        // ),
        Container(
          padding: const EdgeInsets.only(left: 45.0),
          // child: const Text(
          //   'Sign Up',
          //   style: TextStyle(
          //     color: Constant.accent,
          //     fontSize: 16.0,
          //     // decoration: TextDecoration.underline,
          //   ),
          // ),
          child: TextButton(
            onPressed: () {
              Methods.showToast('Login clicked!', ToastGravity.CENTER);
            },
            child: Text(
              loginText,
              style: const TextStyle(
                color: Constant.accent,
                fontSize: Constant.fontSizeSmaller,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

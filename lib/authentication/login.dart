import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genmote/app_languages/pidginEnglish.dart';
import 'package:genmote/authentication/signup.dart';
import 'package:genmote/constants.dart';
import 'package:genmote/methods.dart';
import 'package:page_transition/page_transition.dart';

import '../app_languages/english.dart';
import '../drawer_activities/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  late String welcomeText,
      loginText,
      email,
      password,
      rememberMe,
      forgotPassword,
      signupText,
      noAccount;

  void _lang() {
    if (Constant.isEnglishLang) {
      welcomeText = English.welcomeBackText;
      loginText = English.loginText;
      email = English.email;
      password = English.password;
      rememberMe = English.rememberMe;
      forgotPassword = English.forgotPassword;
      signupText = English.signupText;
      noAccount = English.noAccount;
    }

    if (Constant.isPidginEnglishLang) {
      welcomeText = PidginEnglish.welcomeText;
      loginText = PidginEnglish.loginText;
      email = PidginEnglish.email;
      password = PidginEnglish.password;
      rememberMe = PidginEnglish.rememberMe;
      forgotPassword = PidginEnglish.forgotPassword;
      signupText = PidginEnglish.signupText;
      noAccount = PidginEnglish.noAccount;
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
      Constant.hideOrShowPassword = !Constant.hideOrShowPassword;
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
            _welcomeText(),
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
                        _loginText(),
                        _emailField(),
                        _passwordField(),
                        _saveLoginDetails(),
                        const SizedBox(height: 20),
                        _loginButton(),
                        const SizedBox(height: 20),
                        _forgotPassword(),
                        const SizedBox(height: 20),
                        _signUpButton(),

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

  Widget _welcomeText() {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      padding: const EdgeInsets.only(left: 25.0),
      child: Text(
        welcomeText,
        style: const TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _loginText() {
    return Container(
      // color: Colors.red,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 25, bottom: 25),
      child: Text(
        loginText,
        style: const TextStyle(
            fontSize: 25,
            color: Colors.black87,
            letterSpacing: 2,
            fontFamily: "Lobster"),
      ),
    );
  }

  Widget _emailField() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.accent,
          width: 1,
        ),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Constant.accent,
        //     blurRadius: 10,
        //     offset: Offset(1, 1),
        //   ),
        // ],
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

  Widget _passwordField() {
    return Container(
      width: double.infinity,
      height: 70,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.accent,
          width: 1,
        ),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Constant.accent,
        //     blurRadius: 10,
        //     offset: Offset(1, 1),
        //   ),
        // ],
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
                obscureText: Constant.hideOrShowPassword,
                maxLines: 1,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: _toggleVisibility,
                    child: Icon(
                      Constant.hideOrShowPassword
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

  Widget _saveLoginDetails() {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
      child: Row(
        children: [
          Theme(
            data: ThemeData(
              unselectedWidgetColor: Colors.grey,
            ),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Constant.darkGrey,
              activeColor: Constant.accent,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            rememberMe,
            style: const TextStyle(
              color: Constant.darkGrey,
              fontSize: Constant.fontSizeSmaller,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
          PageTransition(
            child: const Home(),
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
            loginText,
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

  Widget _signUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 45.0),
          child: Text(
            noAccount,
            style: const TextStyle(color: Colors.grey, fontSize: 16.0),
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     Methods.showToast('Sign up clicked!', ToastGravity.BOTTOM);
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
              HapticFeedback.vibrate();
              SystemSound.play(SystemSoundType.click);
              Navigator.of(context).push(
                PageTransition(
                  child: const Signup(),
                  type: PageTransitionType.fade,
                ),
              );
            },
            child: Text(
              signupText,
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

// class Login extends StatefulWidget {
//
//   final String title;
//   const Login({Key? key, required this.title}) : super(key: key);
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   int _counter = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // leading: Container(
//         //   margin: const EdgeInsets.only(left: 20),
//         //   child: IconButton(
//         //     color: Colors.white,
//         //     icon: const Icon(Icons.arrow_back_ios),
//         //     onPressed: () => Navigator.pop(context),
//         //   ),
//         // ),
//         backgroundColor: Constant.mainColor,
//         title: Text(widget.title),
//         elevation: 1,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'This is a prospective Login page!',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
// }

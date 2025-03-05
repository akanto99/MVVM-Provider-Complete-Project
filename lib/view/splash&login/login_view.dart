import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_provider_completeproject/res/color.dart';
import 'package:mvvm_provider_completeproject/res/components/round_button.dart';
import 'package:mvvm_provider_completeproject/responsive/responsive_ui.dart';
import 'package:mvvm_provider_completeproject/utils/routes/routes_name.dart';
import 'package:mvvm_provider_completeproject/utils/utils.dart';
import 'package:mvvm_provider_completeproject/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final GlobalKey webViewKey = GlobalKey();


  @override
  void initState() {
     super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      canDismissDialog: false,
      showLater: false,
      showIgnore: false,
      showReleaseNotes: false,
      upgrader: Upgrader(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ResPonsiveUi(
            mobile: body(),
            desktop: body(),
            tablet: body(),
          ),
        ),
      ),
    );
  }

  Widget body() {
    final authViewMode = Provider.of<AuthViewModel>(context);
    final screenHeight = MediaQuery.of(context).size.height * 1;
    final screenWidth = MediaQuery.of(context).size.width * 1;

    return WillPopScope(
      onWillPop: () async {
        exit(0);
        return true;
      },
      child: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Container(
                  width: screenWidth * 0.95,
                  decoration: BoxDecoration(
                    color: AppColors.navOpacity,
                    border: Border.all(
                      color: AppColors.navButtonColor,
                      width: 0.1,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: emailFocusNode,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      // labelText: 'Email',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      // labelStyle: TextStyle(color: Colors.black,fontSize: 15),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 12.0),
                      prefixIcon: Icon(Icons.alternate_email,
                          color: Colors.blue, size: 20),
                    ),
                    onFieldSubmitted: (value) {
                      Utils.fieldFocusChange(
                          context, emailFocusNode, passwordFocusNode);
                    },
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Center(
                  child: ValueListenableBuilder(
                      valueListenable: _obsecurePassword,
                      builder: (context, value, child) {
                        return Column(
                          children: [
                            Container(
                              width: screenWidth * 0.95,
                              decoration: BoxDecoration(
                                color: AppColors.navOpacity,
                                border: Border.all(
                                  color: AppColors.navButtonColor,
                                  width: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: _obsecurePassword.value,
                                focusNode: passwordFocusNode,
                                obscuringCharacter: "*",
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  // labelText: 'Password',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                  // labelStyle: TextStyle(color: Colors.black,fontSize: 15),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 12.0),
                                  prefixIcon: Icon(
                                    Icons.lock_open_rounded,
                                    color: Colors.redAccent,
                                    size: 20,
                                  ),
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        _obsecurePassword.value =
                                            !_obsecurePassword.value;
                                      },
                                      child: Icon(
                                        _obsecurePassword.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility,
                                        color: AppColors.navColor,
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Container(
                              width: screenWidth * 0.95,
                              // color:Colors.blueAccent,
                              child: GestureDetector(
                                onTap: () {},
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Password Recovery",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration
                                          .underline, // Underline the text
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),

                RoundButtonLogo(
                  title: 'Login',
                  loading: authViewMode.loading,
                  onPress: () {
                    if (_emailController.text.isEmpty) {
                      Utils.flushBarErrorMessage('Please enter email', context);
                    } else if (_passwordController.text.isEmpty) {
                      Utils.flushBarErrorMessage(
                          'Please enter password', context);
                    } else if (_passwordController.text.length < 6) {
                      Utils.flushBarErrorMessage(
                          'Please enter correct password', context);
                    } else {
                      Map data = {
                        'email': _emailController.text.toString(),
                        'password': _passwordController.text.toString(),
                      };

                      authViewMode.loginApi(data, context);
                      print('api hit');
                    }
                  },
                ),
                // SizedBox(height: screenHeight * 0.016,),

                SizedBox(
                  height: screenHeight * 0.02,
                ),

                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, RoutesName.signUpViewStaff);
                    _showRegistrationDialog(context);
                  },
                  child: Container(
                    height: screenHeight * 0.06,
                    width: screenWidth * 0.95,
                    // padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.navOpacity,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Register",
                          style: TextStyle(
                              color: AppColors.navColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text("Please enter your email and password to ",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 12,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w400)),
                Text("access your account.",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 12,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w400)),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRegistrationDialog(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration:
          Duration(milliseconds: 190), // Duration for smoother animation
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1,
            vertical: screenHeight * 0.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.03,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Choose Registration Type",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize:
                                screenWidth > 600 ? 24 : screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: AppColors.blackColor,
                          size: screenWidth > 600 ? 30 : screenWidth * 0.05,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    child: Container(
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.06,
                      // padding: EdgeInsets.symmetric(vertical: screenHeight * 0.011),
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                      decoration: BoxDecoration(
                        color: AppColors.navButtonColor,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Center(
                        // Center the text
                        child: Text(
                          "Candidate Registration",
                          style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    child: Container(
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.06,
                      // padding: EdgeInsets.symmetric(vertical: screenHeight * 0.011),
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015), // Responsive padding

                      decoration: BoxDecoration(
                        color: AppColors.navButtonColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        // Center the text
                        child: Text(
                          "Company Registration",
                          style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var scaleAnimation = animation.drive(tween);

        return ScaleTransition(
          scale: scaleAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }
}

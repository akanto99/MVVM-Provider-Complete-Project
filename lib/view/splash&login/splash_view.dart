
import 'package:flutter/material.dart';
import 'package:mvvm_provider_completeproject/res/color.dart';
import 'package:mvvm_provider_completeproject/responsive/responsive_ui.dart';
import 'package:mvvm_provider_completeproject/view_model/services/splash_services.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.checkAuthentication(context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ResPonsiveUi(
          mobile: body(),
          desktop: body(),
          tablet: body(),
        ),
      ),
    );
  }

  Widget body() {
    final screenHeight = MediaQuery.of(context).size.height *1;
    final screenWidth = MediaQuery.of(context).size.width *1;

    return Center(
        child: Text("Attendly",style: (TextStyle(color:AppColors.navButtonColor,fontSize: 25,fontWeight: FontWeight.w500)),));}
}

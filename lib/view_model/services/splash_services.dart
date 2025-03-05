import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_provider_completeproject/model/user_model/user_model.dart';
import 'package:mvvm_provider_completeproject/utils/routes/routes_name.dart';
import 'package:mvvm_provider_completeproject/view_model/user_view_model.dart';


class SplashServices {


  Future<UserModel> getUserDate() => UserViewModel().getUser();


  void checkAuthentication(BuildContext context)async{

    getUserDate().then((value)async{
      print(value.token.toString());
      if(value.token.toString() == 'null' || value.token.toString() == ''){
        await Future.delayed(Duration(milliseconds: 1500 ));
        Navigator.pushNamed(context, RoutesName.login);
      }
      // else if(value.role.toString() == 'clients' ){
      //   await  Future.delayed(Duration(milliseconds: 1500 ));
      //   Navigator.pushNamed(context, RoutesName.homeView);
      // }
      else if(value.token.toString().isNotEmpty ){
        await  Future.delayed(Duration(milliseconds: 1500 ));
        Navigator.pushNamed(context, RoutesName.homeView);
      }
    }).onError((error, stackTrace){
      if(kDebugMode){
        print(error.toString());
      }
    });

  }



}


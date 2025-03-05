import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_provider_completeproject/model/user_model/user_model.dart';
import 'package:mvvm_provider_completeproject/respository/auth_repository.dart';
import 'package:mvvm_provider_completeproject/utils/routes/routes_name.dart';
import 'package:mvvm_provider_completeproject/utils/utils.dart';
import 'package:mvvm_provider_completeproject/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {

  final _myRepo = AuthRepository();

  bool _loading = false ;
  bool get loading => _loading ;

  bool _signUpLoading = false ;
  bool get signUpLoading => _signUpLoading ;

  bool _createLoading = false ;
  bool get createLoading => _createLoading ;


  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }

  setcreateLoading(bool value){
    _createLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    _myRepo.loginApi(data).then((value) {
      setLoading(false);

      final userPreference = Provider.of<UserViewModel>(context, listen: false);

      userPreference.saveUser(
        UserModel(
          id: value['id'].toString(),
          token: value['token'].toString(),
          message: value['message'].toString(),
          role: value['role'].toString(),
          image: value['image'].toString(),
          name: value['name'].toString(),
          latitude: value['latitude'].toString(),
          longitude: value['longitude'].toString(),
        ),
      );

      Utils.flushBarSuccessMessage('Login Successfully', context);

      // String role = value['role'].toString().toLowerCase();
      // switch (role) {
      //   case 'clients':
      //     Navigator.pushNamed(context, RoutesName.homeView);
      //     break;
      //   default:
      //     break;
      // }
      String token = value['token'].toString();

      if (token.isNotEmpty) {
        Navigator.pushNamed(context, RoutesName.homeView);
      } else {
        Utils.flushBarErrorMessage('Invalid token', context);
      }

      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorLoginMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }



  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);

    try {
      dynamic value = await _myRepo.signUpApi(data);
      setSignUpLoading(false);
      Utils.flushBarSuccessMessage('SignUp Successfully', context);
      if (kDebugMode) {
        print(value.toString());
      }
    } catch (error) {
      setSignUpLoading(false);
      Utils.flushBarErrorMessage('Error: $error', context);
      if (kDebugMode) {
        print('Error: $error');
      }
    }
  }






}
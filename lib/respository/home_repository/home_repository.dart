import 'package:mvvm_provider_completeproject/data/network/BaseApiServices.dart';
import 'package:mvvm_provider_completeproject/data/network/NetworkApiService.dart';
import 'package:mvvm_provider_completeproject/model/movieslist_model/movies_list_model.dart';
import 'package:mvvm_provider_completeproject/res/app_url.dart';
class HomeRepository{
  BaseApiServices _apiServices =NetworkApiService();

  Future<MoviesListModel> fetchMoviesList()async{
    try {
      dynamic response =await _apiServices.getGetApiResponse(AppUrl.movieList);
      print(response);
      return response =MoviesListModel.fromJson(response);

    }catch(e){
      throw e ;
    }
  }


}
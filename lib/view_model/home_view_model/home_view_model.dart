import 'package:flutter/cupertino.dart';
import 'package:mvvm_provider_completeproject/data/response/api_response.dart';
import 'package:mvvm_provider_completeproject/model/movieslist_model/movies_list_model.dart';
import 'package:mvvm_provider_completeproject/respository/home_repository/home_repository.dart';

class HomeViewModel with ChangeNotifier{

  final _myRepo= HomeRepository();

  ApiResponse<MoviesListModel>moviesList=ApiResponse.loading();

  setMoviesList(ApiResponse<MoviesListModel>response){
    moviesList=response;
    notifyListeners();
  }




  // Future <void> fetchMoviesListApi()async{
  //
  //   setMoviesList(ApiResponse.loading());
  //
  //   _myRepo.fetchMoviesList().then((value){
  //     setMoviesList(ApiResponse.completed(value));
  //   }).onError((error, stackTrace){
  //     setMoviesList(ApiResponse.error(error.toString()));
  //   });
  // }

  Future<void> fetchMoviesListApi() async {
    setMoviesList(ApiResponse.loading());
    print("Status: LOADING... Fetching movies list");

    try {
      final value = await _myRepo.fetchMoviesList();
      print("Status: COMPLETED 🎉 Movies fetched successfully: $value");
      setMoviesList(ApiResponse.completed(value));
    } catch (error, stackTrace) {
      print("Status: ERROR ❌ Failed to fetch movies: $error");
      setMoviesList(ApiResponse.error(error.toString()));
    }
  }



}
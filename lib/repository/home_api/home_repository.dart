
import 'package:mvvm_provider_completeproject/model/movie_list/movie_list_model.dart';

abstract class HomeRepository {
  Future<MovieListModel> fetchMoviesList();
}
import 'package:flutter/material.dart';
import 'package:mvvm_provider_completeproject/data/response/status.dart';
import 'package:mvvm_provider_completeproject/utils/routes/routes_name.dart';
import 'package:mvvm_provider_completeproject/view_model/home_view_model/home_view_model.dart';
import 'package:mvvm_provider_completeproject/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    // Fetch movies list API on screen load
    Future.microtask(() =>
        Provider.of<HomeViewModel>(context, listen: false).fetchMoviesListApi()
    );
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: () {
            userPreferences.remove().then((value) {
              Navigator.pushNamed(context, RoutesName.login);
            });
          },
          child: const Center(child: Text("Logout")),
        ),
        centerTitle: true,
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, value, _) {
          print("Current Status: ${value.moviesList.status}"); // Debugging status

          switch (value.moviesList.status) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text("Error: ${value.moviesList.message}"));
            case Status.COMPLETED:
              return ListView.builder(
                itemCount: value.moviesList.data!.movies!.length,
                itemBuilder: (context, index) {
                  final moviesList = value.moviesList.data!.movies![index];
                  return Card(
                    child: ListTile(
                      title: Text(moviesList.title.toString()),
                      subtitle: Text(moviesList.year.toString()),
                    ),
                  );
                },
              );
            default:
              return const SizedBox(); // Empty space
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

// Packages
import 'package:username/username.dart';

// Project
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todone/views/home/home.dart';

/// {@template home_page}
/// This is the home page.
///
/// It consists of a scaffold with an app bar and a drawer,
/// and it displays the [TodosOverviewPage].
/// {@endtemplate}
class HomePage extends StatelessWidget {
  /// {@macro home_page}
  const HomePage({super.key});

  /// The static route for HomePage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

/// {@template home_view}
/// Displays the Body of HomeView
/// {@endtemplate}
class HomeView extends StatelessWidget {
  /// {@macro home_view}
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: Text(context.select<UsernameCubit, String>(
          (cubit) => cubit.state.username,
        )),
      ),
      body: const SafeArea(
        child: HomeBody(),
      ),
    );
  }
}

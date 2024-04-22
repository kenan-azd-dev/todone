import 'package:flutter/material.dart';

// Project
import '../../todos_overview/todos_overview.dart';

/// {@template home_body}
/// Body of the HomePage.
///
/// It displays [TodosOverviewPage]
/// {@endtemplate}
class HomeBody extends StatelessWidget {
  /// {@macro home_body}
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const TodosOverviewPage();
  }
}

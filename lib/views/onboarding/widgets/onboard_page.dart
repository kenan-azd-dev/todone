import 'package:flutter/material.dart';

// Packages
import 'package:app_ui/app_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Project
import 'package:todone/common/common.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({
    super.key,
    required String title,
    required List<Widget>? widgets,
    required String description,
  })  : _title = title,
        _widgets = widgets,
        _description = description;

  final String _title;
  final List<Widget>? _widgets;
  final String _description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                _title,
                textAlign: TextAlign.center,
                style: CoreTextStyle.mainTitle,
              ),
              ViewsConstant.gap12,
              Text(
                _description,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          if (_widgets != null)
            for (final widget in _widgets) widget,
        ],
      ),
    ).animate().fade(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 600),
        );
  }
}

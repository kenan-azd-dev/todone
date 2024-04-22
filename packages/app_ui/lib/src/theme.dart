import 'package:app_ui/src/colors.dart';
import 'package:app_ui/src/typography/typography.dart';
import 'package:flutter/material.dart';

const _smallTextScaleFactor = 0.80;
const _largeTextScaleFactor = 1.20;

/// Namespace for the Core [ThemeData].
class CoreTheme {
  /// Standard dark `ThemeData` for Core UI.
  static ThemeData get standardDark {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: CoreColors.primary,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: CoreColors.charcoal,
      elevatedButtonTheme: _elevatedButtonTheme,
      textTheme: _textTheme,
      inputDecorationTheme: _inputDecorationTheme,
      dialogTheme: _dialogTheme,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: CoreColors.charcoal,
        modalBackgroundColor: CoreColors.charcoal,
        surfaceTintColor: CoreColors.charcoal,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: CoreColors.charcoal,
        surfaceTintColor: CoreColors.charcoal,
      ),
      dividerTheme: const DividerThemeData(
        color: CoreColors.darkGray,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: CoreColors.charcoal,
        surfaceTintColor: CoreColors.charcoal,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black87,
      ),
    );
  }

  /// Standard `ThemeData` for Core UI.
  static ThemeData get standard {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: CoreColors.primary,
      ),
      elevatedButtonTheme: _elevatedButtonTheme,
      scaffoldBackgroundColor: CoreColors.whiteBackground,
      inputDecorationTheme: _inputDecorationTheme,
      textTheme: _textTheme,
      dialogTheme: _dialogTheme,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: CoreColors.whiteBackground,
        modalBackgroundColor: CoreColors.whiteBackground,
        surfaceTintColor: CoreColors.whiteBackground,
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: CoreColors.whiteBackground,
          surfaceTintColor: CoreColors.whiteBackground),
      dividerTheme: const DividerThemeData(
        color: CoreColors.gray,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black87,
      ),
    );
  }

  static ThemeData theme(
    Brightness brightness,
    Color color,
  ) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: color,
        brightness: brightness,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      inputDecorationTheme: _inputDecorationTheme,
      dialogTheme: _dialogTheme,
      textTheme: _textTheme,
    );
  }

  /// `ThemeData` for Core UI for small screens.
  static ThemeData get small {
    return standard.copyWith(textTheme: _smallTextTheme);
  }

  /// `ThemeData` for Core UI for medium screens.
  static ThemeData get medium {
    return standard.copyWith(textTheme: _smallTextTheme);
  }

  /// `ThemeData` for Core UI for large screens.
  static ThemeData get large {
    return standard.copyWith(textTheme: _largeTextTheme);
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: CoreTextStyle.displayLarge,
      displayMedium: CoreTextStyle.displayMedium,
      displaySmall: CoreTextStyle.displaySmall,
      headlineMedium: CoreTextStyle.headlineMedium,
      headlineSmall: CoreTextStyle.headlineSmall,
      titleLarge: CoreTextStyle.titleLarge,
      titleMedium: CoreTextStyle.titleMedium,
      titleSmall: CoreTextStyle.titleSmall,
      bodyLarge: CoreTextStyle.bodyLarge,
      bodyMedium: CoreTextStyle.bodyMedium,
      bodySmall: CoreTextStyle.bodySmall,
      labelSmall: CoreTextStyle.labelSmall,
      labelLarge: CoreTextStyle.labelLarge,
    );
  }

  static TextTheme get _smallTextTheme {
    return TextTheme(
      displayLarge: CoreTextStyle.displayLarge.copyWith(
        fontSize: _textTheme.displayLarge!.fontSize! * _smallTextScaleFactor,
      ),
      displayMedium: CoreTextStyle.displayMedium.copyWith(
        fontSize: _textTheme.displayMedium!.fontSize! * _smallTextScaleFactor,
      ),
      displaySmall: CoreTextStyle.displaySmall.copyWith(
        fontSize: _textTheme.displaySmall!.fontSize! * _smallTextScaleFactor,
      ),
      headlineMedium: CoreTextStyle.headlineMedium.copyWith(
        fontSize: _textTheme.headlineMedium!.fontSize! * _smallTextScaleFactor,
      ),
      headlineSmall: CoreTextStyle.headlineSmall.copyWith(
        fontSize: _textTheme.headlineSmall!.fontSize! * _smallTextScaleFactor,
      ),
      titleLarge: CoreTextStyle.titleLarge.copyWith(
        fontSize: _textTheme.titleLarge!.fontSize! * _smallTextScaleFactor,
      ),
      titleMedium: CoreTextStyle.titleMedium.copyWith(
        fontSize: _textTheme.titleMedium!.fontSize! * _smallTextScaleFactor,
      ),
      titleSmall: CoreTextStyle.titleSmall.copyWith(
        fontSize: _textTheme.titleSmall!.fontSize! * _smallTextScaleFactor,
      ),
      bodyLarge: CoreTextStyle.bodyLarge.copyWith(
        fontSize: _textTheme.bodyLarge!.fontSize! * _smallTextScaleFactor,
      ),
      bodyMedium: CoreTextStyle.bodyMedium.copyWith(
        fontSize: _textTheme.bodyMedium!.fontSize! * _smallTextScaleFactor,
      ),
      bodySmall: CoreTextStyle.bodySmall.copyWith(
        fontSize: _textTheme.bodySmall!.fontSize! * _smallTextScaleFactor,
      ),
      labelSmall: CoreTextStyle.labelSmall.copyWith(
        fontSize: _textTheme.labelSmall!.fontSize! * _smallTextScaleFactor,
      ),
      labelLarge: CoreTextStyle.labelLarge.copyWith(
        fontSize: _textTheme.labelLarge!.fontSize! * _smallTextScaleFactor,
      ),
    );
  }

  static TextTheme get _largeTextTheme {
    return TextTheme(
      displayLarge: CoreTextStyle.displayLarge.copyWith(
        fontSize: _textTheme.displayLarge!.fontSize! * _largeTextScaleFactor,
      ),
      displayMedium: CoreTextStyle.displayMedium.copyWith(
        fontSize: _textTheme.displayMedium!.fontSize! * _largeTextScaleFactor,
      ),
      displaySmall: CoreTextStyle.displaySmall.copyWith(
        fontSize: _textTheme.displaySmall!.fontSize! * _largeTextScaleFactor,
      ),
      headlineMedium: CoreTextStyle.headlineMedium.copyWith(
        fontSize: _textTheme.headlineMedium!.fontSize! * _largeTextScaleFactor,
      ),
      headlineSmall: CoreTextStyle.headlineSmall.copyWith(
        fontSize: _textTheme.headlineSmall!.fontSize! * _largeTextScaleFactor,
      ),
      titleLarge: CoreTextStyle.titleLarge.copyWith(
        fontSize: _textTheme.titleLarge!.fontSize! * _largeTextScaleFactor,
      ),
      titleMedium: CoreTextStyle.titleMedium.copyWith(
        fontSize: _textTheme.titleMedium!.fontSize! * _largeTextScaleFactor,
      ),
      titleSmall: CoreTextStyle.titleSmall.copyWith(
        fontSize: _textTheme.titleSmall!.fontSize! * _largeTextScaleFactor,
      ),
      bodyLarge: CoreTextStyle.bodyLarge.copyWith(
        fontSize: _textTheme.bodyLarge!.fontSize! * _largeTextScaleFactor,
      ),
      bodyMedium: CoreTextStyle.bodyMedium.copyWith(
        fontSize: _textTheme.bodyMedium!.fontSize! * _largeTextScaleFactor,
      ),
      bodySmall: CoreTextStyle.bodySmall.copyWith(
        fontSize: _textTheme.bodySmall!.fontSize! * _largeTextScaleFactor,
      ),
      labelSmall: CoreTextStyle.labelSmall.copyWith(
        fontSize: _textTheme.labelSmall!.fontSize! * _largeTextScaleFactor,
      ),
      labelLarge: CoreTextStyle.labelLarge.copyWith(
        fontSize: _textTheme.labelLarge!.fontSize! * _largeTextScaleFactor,
      ),
    );
  }

  // static AppBarTheme get _appBarTheme {
  //   return const AppBarTheme(color: CoreColors.primary);
  // }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: CoreColors.charcoal,
        backgroundColor: CoreColors.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }

  // static OutlinedButtonThemeData get _outlinedButtonTheme {
  //   return OutlinedButtonThemeData(
  //     style: OutlinedButton.styleFrom(
  //       foregroundColor: CoreColors.white,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(12)),
  //       ),
  //       side: const BorderSide(color: CoreColors.white, width: 2),
  //       fixedSize: const Size(208, 54),
  //     ),
  //   );
  // }

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }

  // static InputDecorationTheme get _inputDecorationDarkTheme {
  //   return InputDecorationTheme(
  //     focusedBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(18),
  //       borderSide: const BorderSide(color: CoreColors.whiteBackground, width: 2),
  //     ),
  //     labelStyle: const TextStyle(color: Colors.white70),
  //     focusColor: Colors.white30,
  //     border: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(18),
  //     ),
  //   );
  // }

  // static ProgressIndicatorThemeData get _progressIndicatorThemeData {
  //   return const ProgressIndicatorThemeData(color: CoreColors.charcoal);
  // }

  // static ProgressIndicatorThemeData get _progressIndicatorDarkThemeData {
  //   return const ProgressIndicatorThemeData(color: Colors.white38);
  // }

  // static TooltipThemeData get _tooltipTheme {
  //   return const TooltipThemeData(
  //     decoration: BoxDecoration(
  //       color: CoreColors.charcoal,
  //       borderRadius: BorderRadius.all(Radius.circular(5)),
  //     ),
  //     padding: EdgeInsets.all(10),
  //     textStyle: TextStyle(color: CoreColors.white),
  //   );
  // }

  static DialogTheme get _dialogTheme {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  // static BottomSheetThemeData get _bottomSheetTheme {
  //   return const BottomSheetThemeData(
  //     backgroundColor: CoreColors.whiteBackground,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
  //     ),
  //   );
  // }

  // static TabBarTheme get _tabBarTheme {
  //   return const TabBarTheme(
  //     indicator: UnderlineTabIndicator(
  //       borderSide: BorderSide(
  //         width: 2,
  //         color: CoreColors.primary,
  //       ),
  //     ),
  //     labelColor: CoreColors.primary,
  //     unselectedLabelColor: CoreColors.black25,
  //     indicatorSize: TabBarIndicatorSize.tab,
  //   );
  // }

  // static DividerThemeData get _dividerTheme {
  //   return const DividerThemeData(
  //     space: 0,
  //     thickness: 1,
  //     color: CoreColors.black25,
  //   );
  // }
}

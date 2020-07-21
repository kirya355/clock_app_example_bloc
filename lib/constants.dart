import 'package:flutter/material.dart';

const List<String> textUnderPicker = ['h', 'min', 's'];
const List<String> titles = [
  'World Time',
  'Stopwatch',
  'Timer',
];
const List<Color> colors = [
  Colors.grey,
  Colors.blue,
  Colors.purpleAccent,
  Colors.purple,
  Colors.deepPurpleAccent,
  Colors.deepPurple,
  Colors.lightBlue,
];
const String yourLocation = 'Your location:';
const String yourTime = 'Time in your location:';
const String timeOut = 'Time out';

class AppThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static ThemeData lightThemeData = themeData(lightColorScheme);
  static ThemeData darkThemeData = themeData(darkColorScheme);

  static ThemeData themeData(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      appBarTheme: AppBarTheme(
        textTheme: _textTheme.apply(bodyColor: colorScheme.onPrimary),
        color: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        brightness: colorScheme.brightness,
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      accentColor: colorScheme.primary,
    );
  }

  static ColorScheme lightColorScheme = ColorScheme(
    primary: Colors.blue,
    primaryVariant: const Color(0xFF117378),
    secondary: Colors.blue,
    secondaryVariant: const Color(0xFFFAFBFB),
    background: const Color(0xFFFFFFFF),
    surface: const Color(0xFFFAFBFB),
    onBackground: Colors.black.withOpacity(0.4),
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: const Color(0xFF322942),
    onSurface: const Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static ColorScheme darkColorScheme = ColorScheme(
    primary: Colors.teal,
    primaryVariant: const Color(0xFF1CDEC9),
    secondary: Colors.teal,
    secondaryVariant: const Color(0xFF451B6F),
    background: const Color(0xFF241E39),
    surface: const Color(0xFF1F1929),
    onBackground: Colors.white.withOpacity(0.4),
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );
  static TextTheme _textTheme = TextTheme(
    bodyText2: TextStyle(),
    bodyText1: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
    headline1: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
    subtitle1: TextStyle(fontSize: 60, fontWeight: FontWeight.w200),
  );
}

const TextStyle worldTimeText =
    TextStyle(fontSize: 60, fontWeight: FontWeight.w200);
const TextStyle worldLocationText =
    TextStyle(fontSize: 20, fontWeight: FontWeight.w300);
const TextStyle underStopwatchStyleText =
    TextStyle(fontSize: 20, fontWeight: FontWeight.w300);
const TextStyle yourTimeStyle =
    TextStyle(fontSize: 25, fontWeight: FontWeight.w400);

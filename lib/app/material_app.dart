import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/configs/strings.dart';
import '../core/themes/theme.dart';
import '../features/home_layout/presentation/screen/home_layout_screen.dart';
import '../generated/l10n.dart';

MaterialApp materialApp(BuildContext context) => MaterialApp(
  debugShowCheckedModeBanner: false,
  title: Strings.label,
  supportedLocales: const [Locale(Strings.ar), Locale(Strings.en)],
  localizationsDelegates: [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  localeResolutionCallback: (currentLan, supportedLocales) {
    if (currentLan != null) {
      return currentLan;
    }
    return supportedLocales.first;
  },
  theme: themeData(),
  darkTheme: darkThemeMode(),
  themeMode: ThemeMode.system,
  home: const HomeLayoutScreen(),
);

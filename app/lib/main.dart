import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty_guide/src/modules/home/home_provider.dart';
import 'src/app_provider.dart';

import 'src/app_widget.dart';
import 'src/core/theme/store/theme_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStore = ThemeStore();
  await themeStore.init();
  await appSetupProvider();
  await homeProvider();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    const AppWidget(),
  );
}

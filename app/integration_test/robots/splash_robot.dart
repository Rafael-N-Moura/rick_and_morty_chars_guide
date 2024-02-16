import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';
import 'package:rick_and_morty_guide/src/app_provider.dart';
import 'package:rick_and_morty_guide/src/core/domain/entities/character_entity.dart';
import 'package:rick_and_morty_guide/src/core/theme/rmg_themes.dart';
import 'package:rick_and_morty_guide/src/core/theme/store/theme_store.dart';
import 'package:rick_and_morty_guide/src/modules/detail/presentation/pages/detail_page.dart';
import 'package:rick_and_morty_guide/src/modules/home/presentation/page/home_page.dart';
import 'package:rick_and_morty_guide/src/modules/splash/presentation/page/splash_page.dart';

class SplashRobot {
  final PatrolIntegrationTester tester;
  SplashRobot(this.tester);

  Future<void> initializeApp() async {
    await tester.pumpWidgetAndSettle(
      MaterialApp(
          title: 'Rick and Morty Guide',
          theme: RMGThemes.light,
          darkTheme: RMGThemes.dark,
          debugShowCheckedModeBanner: false,
          themeMode: getIt<ThemeStore>().themeMode,
          routes: {
            '/': (context) => const SplashPage(),
            '/home': (context) => const HomePage(),
            '/detail': (context) => CharDetailPage(
                char: ModalRoute.of(context)!.settings.arguments as Character),
          },
          initialRoute: '/'),
    );

    await Future.delayed(const Duration(seconds: 5));

    await tester.pumpAndSettle();
  }
}

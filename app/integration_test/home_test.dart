import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:rick_and_morty_guide/src/app_provider.dart';
import 'package:rick_and_morty_guide/src/core/theme/store/theme_store.dart';
import 'package:rick_and_morty_guide/src/modules/home/home_provider.dart';

import 'robots/home_robot.dart';
import 'robots/splash_robot.dart';

void main() {
  late SplashRobot splashRobot;
  late HomeRobot homeRobot;

  setUpAll(() async {
    ThemeStore themeStore = ThemeStore();
    await themeStore.init();
    await appSetupProvider();
    await homeProvider();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  });

  patrolTest(
    'Favorites list',
    ($) async {
      splashRobot = SplashRobot($);
      homeRobot = HomeRobot($);

      await splashRobot.initializeApp();

      await homeRobot.tapCharacterFavoriteButton('Morty Smith');

      await Future.delayed(const Duration(seconds: 5));

      await homeRobot.verifyIfCharIsInFavoritesTab('Morty Smith');
    },
  );

  patrolTest(
    'Turning in dark mode',
    ($) async {
      splashRobot = SplashRobot($);
      homeRobot = HomeRobot($);

      await splashRobot.initializeApp();
      await homeRobot.tapThemeModeButton();

      homeRobot.verifyThemeMode(ThemeMode.dark);
    },
  );

  patrolTest(
    'Turning in light mode',
    ($) async {
      splashRobot = SplashRobot($);
      homeRobot = HomeRobot($);

      await splashRobot.initializeApp();
      await homeRobot.tapThemeModeButton();

      homeRobot.verifyThemeMode(ThemeMode.light);
    },
  );

  patrolTest(
    'Searching by character',
    ($) async {
      splashRobot = SplashRobot($);
      homeRobot = HomeRobot($);

      await splashRobot.initializeApp();

      await homeRobot.enterSearchText('Summer');

      homeRobot.verifySearch('Summer Smith');
    },
  );
}

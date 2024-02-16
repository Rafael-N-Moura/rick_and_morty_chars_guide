import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:rick_and_morty_guide/src/app_provider.dart';
import 'package:rick_and_morty_guide/src/core/theme/store/theme_store.dart';
import 'package:rick_and_morty_guide/src/modules/home/presentation/page/widgets/card_widget.dart';

class HomeRobot {
  final PatrolIntegrationTester tester;

  HomeRobot(this.tester);

  Future<void> tapThemeModeButton() async {
    await tester(#themeModeButton).tap();
    await Future.delayed(const Duration(seconds: 2));
  }

  void verifyThemeMode(ThemeMode theme) {
    ThemeStore themeStore = getIt<ThemeStore>();
    expect(themeStore.themeMode, theme);
  }

  Future<void> enterSearchText(String text) async {
    await tester(#searchTextField).enterText(text);
    await Future.delayed(const Duration(seconds: 2));
  }

  void verifySearch(String text) {
    expect(tester(#characterCard).$(text).exists, equals(true));
  }

  Future<void> verifyIfCharIsInFavoritesTab(String character) async {
    await routeToFavoritesTab();

    await Future.delayed(const Duration(seconds: 5));

    expect(
        (tester(#characterCard)
            .which<CardWidget>((widget) => widget.char.name == character)),
        findsOneWidget);
  }

  Future<void> tapCharacterFavoriteButton(String character) async {
    await (tester(#characterCard)
            .which<CardWidget>((widget) => widget.char.name == character))
        .$(#heartFavoriteButton)
        .tap();
  }

  Future<void> routeToFavoritesTab() async {
    await tester('Favorites').tap();
  }
}

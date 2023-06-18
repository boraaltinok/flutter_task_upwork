import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_list_app/model/task.dart';

import '../enums/menu_item_enum.dart';

final selectedTaskProvider = StateProvider<Task?>((ref) => null);

final selectedMenuItemProvider = StateProvider<MenuItemEnum>((ref) => MenuItemEnum.tasks);

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en'));

  void updateLocale(Locale newLocale) {
    state = newLocale;
  }
}

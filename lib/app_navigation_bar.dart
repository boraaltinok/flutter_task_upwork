import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/common/app_style.dart';
import 'package:task_list_app/enums/menu_item_enum.dart';
import 'package:task_list_app/providers/provider.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final selectedMenuItem = ref.watch(selectedMenuItemProvider);

      final localeNotifier = ref.read(localeProvider.notifier);

      void changeLocale(Locale newLocale) {
        localeNotifier.updateLocale(newLocale);
      }

      return ColoredBox(
        color: AppStyle.darkBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 64),
                itemCount: navigationBarItems.length,
                itemBuilder: (context, index) {
                  final isSelected =
                      selectedMenuItem == navigationBarItems[index].type;

                  return GestureDetector(
                    onTap: () {
                      ref.read(selectedMenuItemProvider.notifier).state =
                          navigationBarItems[index].type;
                      print("going to ${navigationBarItems[index].url}");
                      context.go(navigationBarItems[index]
                          .url); // Navigate to the selected URL
                    },
                    child: _NavigationBarListItem(
                      item: navigationBarItems[index],
                      isSelected: isSelected,
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  color: AppStyle.mediumBlue,
                  height: 1,
                  endIndent: 16,
                  indent: 16,
                ),
              ),
            ),
            Expanded(child: buildLanguagePicker(context, changeLocale))
          ],
        ),
      );
    });
  }

  PopupMenuButton<dynamic> buildLanguagePicker(
      BuildContext context, void changeLocale(Locale newLocale)) {
    return PopupMenuButton(
      child: Container(
          color: AppStyle.lightGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Change language",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: AppStyle.mediumBlue, fontSize: 25),
              ),
              Icon(Icons.language)
            ],
          )),
      itemBuilder: (BuildContext context) {
        final Country? arabia = Country.tryParse('ar');
        final Country? us = Country.tryParse('us');
        return [
          PopupMenuItem(
            onTap: () {
              changeLocale(Locale('ar'));
            },
            child: Text("${arabia?.flagEmoji ?? ""} ${"Arabic".toUpperCase()}"),
          ),
          PopupMenuItem(
            onTap: () {
              changeLocale(Locale('en'));
            },
            child: Text("${us?.flagEmoji ?? ""} ${"English".toUpperCase()}"),
          )
        ];
      },
    );
  }
}

class _NavigationBarListItem extends StatelessWidget {
  const _NavigationBarListItem({
    Key? key,
    required this.item,
    required this.isSelected,
  }) : super(key: key);
  final NavigationBarItem item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSelected ? AppStyle.orangeAccent : null,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        item.type.localeValue(context),
        style: TextStyle(fontSize: 18, color: AppStyle.lightTextColor),
      ),
    );
  }
}

final navigationBarItems = [
  // TODO: labels should be in app localization file
  NavigationBarItem(type: MenuItemEnum.tasks, url: '/tasks'),
  NavigationBarItem(type: MenuItemEnum.projects, url: '/projects'),
  NavigationBarItem(type: MenuItemEnum.teams, url: '/teams'),
];

class NavigationBarItem {
  final MenuItemEnum type;
  final String url;

  NavigationBarItem({required this.type, required this.url});
}

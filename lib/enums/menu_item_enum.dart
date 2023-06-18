import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
enum MenuItemEnum {
  tasks,
  projects,
  teams,
}

extension ItemTypeExtension on MenuItemEnum {
  String get stringValue {
    switch (this) {
      case MenuItemEnum.tasks:
        return 'Tasks';
      case MenuItemEnum.projects:
        return 'Projects';
      case MenuItemEnum.teams:
        return 'Teams';
    }
  }

  String localeValue(BuildContext context) {
    switch (this) {
      case MenuItemEnum.tasks:
        return AppLocalizations.of(context).tasks;
      case MenuItemEnum.projects:
        return AppLocalizations.of(context).projects;
      case MenuItemEnum.teams:
        return AppLocalizations.of(context).teams;
    }
  }

}

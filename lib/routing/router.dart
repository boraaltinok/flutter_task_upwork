import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/pages/projects/_view/projects_page.dart';
import 'package:task_list_app/pages/scaffold_with_navbar_page.dart';
import 'package:task_list_app/pages/task_and_detail_page.dart';
import 'package:task_list_app/pages/teams/_view/teams_page.dart';

import '../enums/menu_item_enum.dart';
import '../providers/provider.dart';

class AppRouter {
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/tasks',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return NoTransitionPage(
            child: ScaffoldWithNavbarPage(
              child: child,
            ),
          );
        },
        routes: [
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/tasks',
            builder: (context, state) {
              return TaskAndDetailPage();
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/projects',
            builder: (context, state) {
              return ProjectsPage();
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/teams',
            builder: (context, state) {
              return TeamsPage();
            },
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(child: Container()),
  );

  static Future<bool> onWillPop(BuildContext context, WidgetRef ref) async {
    final canGoBack = _shellNavigatorKey.currentState?.canPop() ?? false;
    if (canGoBack) {
      _shellNavigatorKey.currentState?.pop();

      final currentRoute =
          ModalRoute.of(_shellNavigatorKey.currentContext!)?.settings.name;
      if (currentRoute == '/tasks') {
        ref.read(selectedMenuItemProvider.notifier).state = MenuItemEnum.tasks;
      } else if (currentRoute == '/projects') {
        ref.read(selectedMenuItemProvider.notifier).state = MenuItemEnum.projects;
      } else if (currentRoute == '/teams') {
        ref.read(selectedMenuItemProvider.notifier).state = MenuItemEnum.teams;
      }

      return false;
    }
    return true;
  }

}

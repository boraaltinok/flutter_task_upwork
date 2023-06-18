import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/pages/projects/_view/projects_page.dart';
import 'package:task_list_app/pages/scaffold_with_navbar_page.dart';
import 'package:task_list_app/pages/task_and_detail_page.dart';
import 'package:task_list_app/pages/teams/_view/teams_page.dart';

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
          print(state.location);
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
}

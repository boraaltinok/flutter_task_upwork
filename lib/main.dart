import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_list_app/providers/provider.dart';
import 'package:task_list_app/routing/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Consumer(
      builder: (context, ref, _) {
        final locale = ref.watch(localeProvider);

        return MaterialApp.router(
          title: 'Task list App',
          supportedLocales: L10n.all,
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,

          ],
          theme: ThemeData(
            primarySwatch: Colors.indigo,
          ),
          routerConfig: AppRouter.router,
        );
      }
    );
  }
}

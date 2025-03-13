import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_state/common/data/preference/app_shared_preference.dart';
import 'package:todo_state/data/local/local_db.dart';
import 'package:todo_state/data/memory/app_block/app_bloc_observer.dart';
import 'package:todo_state/data/memory/app_block/app_event_transformer.dart';

import 'app.dart';
import 'common/data/preference/app_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await AppPreferences.init();
  await AppSharedPreference.init();
  await LocalDB.init();



  Bloc.observer = AppBlocObserver();
  Bloc.transformer = appEventTransformer;

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      useOnlyLangCode: true,
      child: const App()));
}

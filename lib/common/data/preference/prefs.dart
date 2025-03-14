import 'package:todo_state/common/data/preference/item/nullable_preference_item.dart';
import 'package:todo_state/common/data/preference/item/preference_item.dart';
import 'package:todo_state/common/theme/custom_theme.dart';

class Prefs {
  static final appTheme = NullablePreferenceItem<CustomTheme>('appTheme');
  static final launchCount = PreferenceItem<int>('launchCount', 0);
  static final count = PreferenceItem<bool>('count', true);
}

main(){
  Prefs.launchCount.set(200);
  final launchCount = Prefs.launchCount.get();
}

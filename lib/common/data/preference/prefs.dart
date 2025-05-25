import 'package:flutter_carrot_market/common/data/preference/item/nullable_preference_item.dart';
import 'package:flutter_carrot_market/common/theme/custom_theme.dart';

class Prefs {
  static final appTheme = NullablePreferenceItem<CustomTheme>('appTheme');
}

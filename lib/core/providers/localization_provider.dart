import 'package:flutter/foundation.dart';

class LocalizationProvider extends ChangeNotifier {
  bool _isArabic = false;
  bool get isArabic => _isArabic;
  
  String get languageCode => _isArabic ? 'ar' : 'en';

  void toggleLanguage() {
    _isArabic = !_isArabic;
    notifyListeners();
  }

  String text(String english, String arabic) {
    return _isArabic ? arabic : english;
  }
}

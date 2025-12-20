import 'package:shared_preferences/shared_preferences.dart';

class Redirect{
  static Future <bool> isFirstTime()async{
    final prefs= await SharedPreferences.getInstance();
    return prefs.getBool('seenOnboarding')!= true;
  }

  static Future completeOnboarding ()async{
    final prefs= await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
  }


}
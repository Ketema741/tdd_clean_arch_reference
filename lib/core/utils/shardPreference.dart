
import "package:shared_preferences/shared_preferences.dart";

class ShardPrefHelper {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
      
  static SharedPreferences? _prefsInstance;

  static Future<bool> getIsOpened() async {
    
    final SharedPreferences prefs = await _instance;
    bool firstTimeOpened = prefs.getBool("firstTimeOpened") ?? false;
    if (!firstTimeOpened) {
      prefs.setBool("firstTimeOpened", true);
    }
    return firstTimeOpened;
  }

  static Future setIsOpened() async {

    final SharedPreferences prefs = await _instance;
    prefs.setBool("firstTimeOpened", true);

  }
  

  static Future<bool> clear() async {
    final SharedPreferences prefs = await _instance;
    return prefs.clear();
  }
}
import 'package:guru_booking/utils/networking.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userdata {
  final networking = Networking();
  static Map<String,dynamic> data = {};
  static SharedPreferences? prefs;

  static Future<void> getPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  static List<dynamic> mapel = [];
  Future<void> loadMapel() async {
    mapel = await networking.getKategori();
  }
}
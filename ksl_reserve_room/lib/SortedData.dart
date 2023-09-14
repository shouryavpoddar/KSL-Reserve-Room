import 'package:shared_preferences/shared_preferences.dart';

class Preference{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> hasLogedIn()async {
    SharedPreferences preferences = await _prefs;
    return ((preferences.getString("caseId") != null)&&(preferences.getString("firstName") != null)&&(preferences.getString("lastName") != null));
  }

  Future<void> saveFirstName(String firstName) async{
    SharedPreferences preferences = await _prefs;
    preferences.setString("firstName", firstName);
  }

  Future<void> saveLastName(String lastName) async{
    SharedPreferences preferences = await _prefs;
    preferences.setString("lastName", lastName);
  }

  Future<void> saveCaseId(String caseId) async{
    SharedPreferences preferences = await _prefs;
    preferences.setString("caseId", caseId);
  }

  Future<String?> getFirstName() async{
    SharedPreferences preferences = await _prefs;
    return preferences.getString("firstName");
  }

  Future<String?> getLastName() async{
    SharedPreferences preferences = await _prefs;
    return preferences.getString("lastName");
  }

  Future<String?> getCaseId() async{
    SharedPreferences preferences = await _prefs;
    return preferences.getString("caseId");
  }

  Future<void> deleteCaseId() async{
    SharedPreferences preferences = await _prefs;
    preferences.remove("caseId");
  }

  Future<void> deleteFirstName() async{
    SharedPreferences preferences = await _prefs;
    preferences.remove("firstName");
  }

  Future<void> deleteLastName() async{
    SharedPreferences preferences = await _prefs;
    preferences.remove("lastName");
  }
}
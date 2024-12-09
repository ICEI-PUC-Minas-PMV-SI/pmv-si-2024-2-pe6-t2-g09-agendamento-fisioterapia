import 'package:shared_preferences/shared_preferences.dart';

class DataUser {
  Future<void> saveUserData(Map<String, dynamic> apiResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String jwtToken = apiResponse['jwtToken'];
    Map<String, dynamic> user = apiResponse['user'];
    String userId = user['id'].toString();
    String username = user['user'];
    String email = user['email'];

    await prefs.setString('jwtToken', jwtToken);
    await prefs.setString('userId', userId);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
  }

  Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static String? firstName, token, mobile, lastName, profilePic, email, password;

  static Future<void> saveUserData(
      String uFristName,
      String utoken,
      String uLastName,
      String uProfilePic,
      String uMobile,
      String uemail,
      String upassword) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', utoken);
    await sharedPreferences.setString('firstName', uFristName);
    await sharedPreferences.setString('lastName', uLastName);
    await sharedPreferences.setString('mobile', uMobile);
    await sharedPreferences.setString('profilePic', uProfilePic);
    await sharedPreferences.setString('email', uemail);
    await sharedPreferences.setString('password', upassword); // Store the password in shared preferences
    firstName = uFristName;
    lastName = uLastName;
    token = utoken;
    mobile = uMobile;
    profilePic = uProfilePic;
    email = uemail;
    password = upassword; // Update the password in the static variable
  }

  static Future<bool> checkLoginState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> geetAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    firstName = sharedPreferences.getString("firstName");
    lastName = sharedPreferences.getString("lastName");
    mobile = sharedPreferences.getString("mobile");
    profilePic = sharedPreferences.getString("profilePic");
    email = sharedPreferences.getString("email");
    password = sharedPreferences.getString("password"); // Retrieve the password from shared preferences
  }

  static Future<void> clearData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}

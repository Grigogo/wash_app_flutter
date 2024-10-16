import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserStorageService {
  Future<void> saveUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', user.id);
    prefs.setString('phoneNumber', user.phoneNumber);
    prefs.setString('name', user.name);
    prefs.setString('picture', user.picture);
    prefs.setInt('balance', user.balance);
    prefs.setInt('cashback', user.cashback);
  }

  Future<User?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userId')) return null;

    return User(
      id: prefs.getString('userId')!,
      phoneNumber: prefs.getString('phoneNumber')!,
      name: prefs.getString('name')!,
      picture: prefs.getString('picture')!,
      balance: prefs.getInt('balance')!,
      cashback: prefs.getInt('cashback')!,
    );
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

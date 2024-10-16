import 'package:vt_app/models/user.dart';
import 'package:vt_app/database/database_service.dart';

class UserStorageService {
  final DatabaseService _databaseService = DatabaseService();

  Future<void> saveUserData(User user) async {
    await _databaseService.saveUser(user);
  }

  Future<User?> getUserData() async {
    return await _databaseService.getUser();
  }

  Future<void> clearUserData() async {
    print("Clearing user data from storage...");
    await _databaseService.clearUser();
  }
}

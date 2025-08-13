import 'package:flutter/material.dart';
import 'package:hr/data/models/user_model.dart';
import 'package:hr/provider/features/features_ids.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  bool get isLoggedIn => _user != null;

  int get roleId => _user?.peran.id ?? 0; // ambil id peran
  String get roleName => _user?.peran.namaPeran ?? 'Guest';

  List<String> features = []; // dari DB, isinya list fitur yang diizinin

  bool hasFeature(String featureId) {
    return features.contains(featureId);
  }

  void setUser(UserModel user) {
    _user = user;
    if (roleName == "Super Admin") {
      features = [
        ...FeatureIds.manageCuti,
        ...FeatureIds.manageLembur,
        ...FeatureIds.dashboard,
      ];
    }
    // Kalau bukan Super Admin, load dari database
    else {
      features = [
        ...FeatureIds.userCuti,
        ...FeatureIds.userLembur,
        ...FeatureIds.dashboardUser,
      ];
      // features = await getRoleFeaturesFromDB(user.peran.id);
    }

    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}

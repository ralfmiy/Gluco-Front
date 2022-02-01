import 'package:demo_youtube/models/user_model.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  static final AppProvider _instance = AppProvider._constructor();

  factory AppProvider() {
    return _instance;
  }

  AppProvider._constructor();

  UserModel _userModel = UserModel();

  UserModel get userModel => this._userModel;
  set userModel(UserModel data) {
    this._userModel = data;
    notifyListeners();
  }

  init() async {
        
  }
}

import 'package:flutter/material.dart';

class AppTabController extends ChangeNotifier {
  static final AppTabController _instance = AppTabController._internal();
  factory AppTabController() => _instance;
  AppTabController._internal();

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setTabIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  void goToHome() {
    setTabIndex(0);
  }

  void goToProfile() {
    setTabIndex(1);
  }
} 
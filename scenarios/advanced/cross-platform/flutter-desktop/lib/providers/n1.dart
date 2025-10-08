import 'package:flutter/foundation.dart';

class AppProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  String _currentScenario = 'Home';
  
  int get selectedIndex => _selectedIndex;
  String get currentScenario => _currentScenario;
  
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
  
  void setCurrentScenario(String scenario) {
    _currentScenario = scenario;
    notifyListeners();
  }
  
  void reset() {
    _selectedIndex = 0;
    _currentScenario = 'Home';
    notifyListeners();
  }
}

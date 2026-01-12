import 'package:flutter/widgets.dart';

class UIProvider extends ChangeNotifier{
  int _selectedMenuOpt = 1;

  int get selectedMenuOpt{
    return _selectedMenuOpt;
  }

  set selectedMenuOpt(int index){
    _selectedMenuOpt = index;
    notifyListeners();
  }
}
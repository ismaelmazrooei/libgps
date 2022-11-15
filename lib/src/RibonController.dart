import 'package:flutter/cupertino.dart';

class Riboncontroller extends ChangeNotifier {
  invalidate() {
    notifyListeners();
  }
}

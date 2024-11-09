import 'package:flutter/material.dart';

class GlobalStateProvider extends ChangeNotifier {
  bool _isFirstEnterDetailPage = true;

  bool get isFirstEnterDetailPage => _isFirstEnterDetailPage;

  void changeItNotFirstEnterDetailPage() {
    _isFirstEnterDetailPage = false;
  }
}

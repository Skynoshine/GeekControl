import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final pageController = PageController();
  var indexPage = 0;

  void changePage(int page) {
    pageController.jumpToPage(page);
    indexPage = page;
    notifyListeners();
  }

  Future<void> inicia(context) async {
    HomeController();
    
  }
}

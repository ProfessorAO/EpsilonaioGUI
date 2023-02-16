import 'package:flutter/material.dart';



class ProfileProvider with ChangeNotifier{
  List<Widget> all_profile_details = [];
  List<Widget> all_profile_cards = [];


  void addProfile(Widget Profile){
    all_profile_cards.add(Profile);
    notifyListeners();
  }


}



import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  List<Widget> all_profile_details = [];
  List<Widget> all_profile_cards = [];

  void addProfile(Widget Profile) {
    all_profile_cards.add(Profile);
    notifyListeners();
  }

  void removeProfile(Widget Profile) {
    all_profile_cards.removeWhere((element) => element == Profile);
    notifyListeners();
  }

  void removeAllProfiles() {
    all_profile_cards.clear();
    notifyListeners();
  }
}

class ProfileInstance {
  String first_name = "";
  String last_name = "";
  String profile_name = "";
  String card_name = "";
  String address = "";
  String city = "";
  String postcode = "";
  String phone = "";
  late int ProfileID;

//GETTERS
  String get firstName => first_name;
  String get lastName => last_name;
  String get profileName => profile_name;
  String get cardName => card_name;
  String get address_ => address;
  String get city_ => city;
  String get postcode_ => postcode;
  String get phone_ => phone;
  int get profileId => ProfileID;

//SETTERS
  void set firstName(String newfname) {
    first_name = newfname;
  }

  void set lastName(String newlname) {
    last_name = newlname;
  }

  void set profileName(String newpname) {
    profile_name = newpname;
  }

  void set cardName(String newcname) {
    card_name = newcname;
  }

  void set address_(String newaddress) {
    address = newaddress;
  }

  void set city_(String newcity) {
    city = newcity;
  }

  void set postcode_(String newpostcode) {
    postcode = newpostcode;
  }

  void set phone_(String newphone) {
    phone = newphone;
  }

  void set profileId(int newId) {
    ProfileID = newId;
  }

  ProfileInstance(
      fname, lname, pname, cname, address_, city_, postcode_, phone_) {
    first_name = fname;
    last_name = lname;
    profile_name = pname;
    card_name = cname;
    address = address_;
    city = city_;
    postcode = postcode_;
    phone = phone_;
  }
}

import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  List<ProfileInstance> all_profile_instances = [];
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

  void createProfileInstance(
      String fname,
      String lname,
      String pname,
      String cname,
      String cnum,
      String address_,
      String city_,
      String postcode_,
      String phone_) {
    ProfileInstance profileInstance = ProfileInstance(
        fname, lname, pname, cname, cnum, address_, city_, postcode_, phone_);

    all_profile_instances.add(profileInstance);
    profileInstance
        .setprofileId(all_profile_instances.indexOf(profileInstance));
  }
}

class ProfileInstance {
  String first_name = "";
  String last_name = "";
  String profile_name = "";
  String card_name = "";
  String card_number = "";
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
  String get cardNumber => card_number;
  String get address_ => address;
  String get city_ => city;
  String get postcode_ => postcode;
  String get phone_ => phone;
  int get profileId => ProfileID;

//SETTERS
  void setfirstName(String newfname) {
    first_name = newfname;
  }

  void setlastName(String newlname) {
    last_name = newlname;
  }

  void setprofileName(String newpname) {
    profile_name = newpname;
  }

  void setcardName(String newcname) {
    card_name = newcname;
  }

  void setcardNumber(String newcnum) {
    card_number = newcnum;
  }

  void setaddress_(String newaddress) {
    address = newaddress;
  }

  void setcity_(String newcity) {
    city = newcity;
  }

  void setpostcode_(String newpostcode) {
    postcode = newpostcode;
  }

  void setphone_(String newphone) {
    phone = newphone;
  }

  void setprofileId(int newId) {
    ProfileID = newId;
  }

  ProfileInstance(
      fname, lname, pname, cname, cnum, address_, city_, postcode_, phone_) {
    first_name = fname;
    last_name = lname;
    profile_name = pname;
    card_number = cnum;
    card_name = cname;
    address = address_;
    city = city_;
    postcode = postcode_;
    phone = phone_;
  }
}

class Profile_card extends StatelessWidget {
  const Profile_card({
    super.key,
    required this.profile_name,
    required this.card_name,
    required this.address,
    required this.card_no,
  });
  final String profile_name;
  final String card_name;
  final String address;
  final String card_no;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 25, 36, 78),
          border: Border(
              left: BorderSide(
            color: Colors.blue,
            width: 5,
            style: BorderStyle.solid,
          ))),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.01, 0, 0, 0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  profile_name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.062,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.01, 0, 0, 0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(card_name,
                    style: TextStyle(color: Colors.white, fontSize: 12))),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.01, 0, 0, 0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(address,
                    style: TextStyle(color: Colors.white, fontSize: 12))),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.01, 0, 0, 1),
            child: Row(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "\u2022 \u2022 \u2022 \u2022 " +
                            card_no
                                .toString()
                                .substring(card_no.toString().length - 4),
                        style: TextStyle(color: Colors.white, fontSize: 12))),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0 + .1,
                ),
                InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: const Text('Profile Removed'),
                      action: SnackBarAction(
                        label: '',
                        onPressed: () {},
                      ),
                    );
                    ProfileProvider().removeProfile(this);
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

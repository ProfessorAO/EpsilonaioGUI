import 'package:epsilon_gui/providers/profile_provider.dart';
import 'package:epsilon_gui/providers/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//STOP PEOPLE FROM MAKING PROFILE GROUP NAMES THE SAME

class ProfileGroupProvider with ChangeNotifier {
  static final ProfileGroupProvider _instance =
      ProfileGroupProvider._internal();
  ProfileGroupProvider._internal();

  List<ProfileGroup> profileGroups = [];
  List<DataRow> all_profiles_data = [];
  ProfileProvider profileManager = ProfileProvider.instance;

//GETTERS
  static ProfileGroupProvider get instance => _instance;
  List<DataRow> get allProfilesData => all_profiles_data;

//SETTERS

  List<Widget> getWidgets() {
    var widgetList = <Widget>[];
    for (ProfileGroup pg in profileGroups) {
      widgetList.add(pg.widget);
    }
    return widgetList;
  }

//FUNCTIONS
  void refreshData() {
    all_profiles_data = getProfileTableData();
    notifyListeners();
  }

  void removeFromProfileGroups(Profile profile) {
    for (ProfileGroup pg in profileGroups) {
      if (pg.contains(profile)) {
        pg.removeProfile(profile);
        pg.updateWidget();
      }
    }
    notifyListeners();
  }

  List<DataRow> getProfileTableData() {
    List<DataRow> data = [];
    DataRow dataRow_instance;
    var list = profileManager.all_profile_instances;
    for (Profile instance in list) {
      data.add(instance.getDataRow());
    }
    notifyListeners();
    return data;
  }

  List<Profile> getSelectedProfiles() {
    var list = profileManager.all_profile_instances;
    List<Profile> selectedProfiles = [];
    for (Profile instance in list) {
      if (instance.checked == true) {
        selectedProfiles.add(instance);
      }
    }
    return selectedProfiles;
  }

  void deleteGroup(UniqueKey uniqueKey) {
    profileGroups.removeWhere(
      (element) {
        return element.uniqueKey == uniqueKey;
      },
    );

    notifyListeners();
  }

  void addProfileGroup(String groupName) {
    final key = UniqueKey();
    List<Profile> selectedProfiles = getSelectedProfiles();

    ProfileGroup newProfileGroup =
        ProfileGroup(key, groupName, selectedProfiles);

    profileGroups.add(newProfileGroup);

    // final snackBar = SnackBar(
    //   duration: const Duration(seconds: 1),
    //   backgroundColor: Colors.green,
    //   content: Text("$groupName Task Group Created"),
    //   action: SnackBarAction(
    //     label: '',
    //     onPressed: () {},
    //   ),
    // );
    //ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //UserData.instance.saveProfileGroups(profileGroups);

    notifyListeners();
  }
}

class ProfileGroupWidget extends StatelessWidget {
  final String groupName;
  final int profileLength;
  final UniqueKey uniqueKey;

  const ProfileGroupWidget(
      {super.key,
      required this.groupName,
      required this.profileLength,
      required this.uniqueKey});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border:
                  Border.all(color: Color.fromARGB(255, 25, 36, 78), width: 3)),
          child: Container(
            child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity,
                      MediaQuery.of(context).size.height * 0.08)),
              onPressed: () {},
              onLongPress: () {},
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.center,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        groupName,
                        style: const TextStyle(fontSize: 17),
                      )),
                  Spacer(),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "$profileLength Profile(s)",
                        style: const TextStyle(fontSize: 14),
                      )),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          final snackBar = SnackBar(
                            duration: const Duration(seconds: 1),
                            backgroundColor: Colors.red,
                            content: Text("$groupName Deleted"),
                            action: SnackBarAction(
                              label: '',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          context
                              .read<ProfileGroupProvider>()
                              .deleteGroup(uniqueKey);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileGroup {
  UniqueKey uniqueKey;
  List<Profile> profiles;
  ProfileGroupWidget widget = ProfileGroupWidget(
      groupName: "", profileLength: 0, uniqueKey: UniqueKey());
  String name;

  int get profileLength => profiles.length;

  ProfileGroup(this.uniqueKey, this.name, this.profiles) {
    widget = ProfileGroupWidget(
        groupName: name, profileLength: profiles.length, uniqueKey: uniqueKey);
  }

  void setName(String newName) {
    name = newName;
  }

  void updateWidget() {
    widget = ProfileGroupWidget(
        groupName: name, profileLength: profiles.length, uniqueKey: uniqueKey);
  }

  void setProfiles(List<Profile> newProfiles) {
    profiles = newProfiles;
  }

  void removeProfile(Profile profile) {
    profiles.remove(profile);
  }

  bool contains(Profile profile) {
    bool check = false;
    for (Profile profile_ in profiles) {
      if (profile == profile_) {
        check = true;
        return check;
      } else {
        check = false;
      }
    }
    return check;
  }
}

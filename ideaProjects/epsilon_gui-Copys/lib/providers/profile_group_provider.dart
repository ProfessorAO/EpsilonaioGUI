import 'package:epsilon_gui/providers/profile_provider.dart';
import 'package:epsilon_gui/providers/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//STOP PEOPLE FROM MAKING PROFILE GROUP NAMES THE SAME

class ProfileGroupProvider with ChangeNotifier {
  List<ProfileGroup> profileGroups = [];
  late BuildContext context_;
  List<DataRow> all_profiles_data = [];

//GETTERS
  List<DataRow> get allProfilesData => all_profiles_data;

//SETTERS
  void setContext(BuildContext newcontext) {
    context_ = newcontext;
    notifyListeners();
  }

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

  List<DataRow> getProfileTableData() {
    List<DataRow> data = [];
    DataRow dataRow_instance;
    var list = context_.read<ProfileProvider>().all_profile_instances;
    for (Profile instance in list) {
      data.add(instance.getDataRow());
    }
    notifyListeners();
    return data;
  }

  List<Profile> getSelectedProfiles() {
    var list = context_.read<ProfileProvider>().all_profile_instances;
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

  Widget createProfileGroup(context, groupName, key, profileLength) {
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            minimumSize: Size(
                double.infinity, MediaQuery.of(context).size.height * 0.08)),
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
                    // final snackBar = SnackBar(
                    //   duration: const Duration(seconds: 1),
                    //   backgroundColor: Colors.red,
                    //   content: Text("Deleted"),
                    //   action: SnackBarAction(
                    //     label: '',
                    //     onPressed: () {},
                    //   ),
                    // );
                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    deleteGroup(key);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void addProfileGroup(BuildContext context, String groupName) {
    final key = UniqueKey();
    List<Profile> selectedProfiles = getSelectedProfiles();
    var profileLen = selectedProfiles.length;
    Widget widget = Column(
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
          child: createProfileGroup(context, groupName, key, profileLen),
        ),
      ],
    );

    ProfileGroup newProfileGroup =
        ProfileGroup(key, groupName, selectedProfiles, widget);
    profileGroups.add(newProfileGroup);
    //profileGroups_widget.addEntries(entry.entries);
    //profileGroups_names.addEntries(nameEntry.entries);
    final snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.green,
      content: Text("$groupName Task Group Created"),
      action: SnackBarAction(
        label: '',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    UserData.instance.saveProfileGroups(profileGroups);
    notifyListeners();
  }
}

class ProfileGroup {
  UniqueKey uniqueKey;
  List<Profile> profiles;
  Widget widget;
  String name;

  ProfileGroup(this.uniqueKey, this.name, this.profiles, this.widget);

  void setName(String newName) {
    name = newName;
  }

  void setProfiles(List<Profile> newProfiles) {
    profiles = newProfiles;
  }

  Map<String, dynamic> toJson() {
    return {
      'uniqueKey': uniqueKey.toString(),
      'name': name,
      'profiles': profiles.map((profile) => profile.toJson()).toList(),
    };
  }

  static ProfileGroup fromJson(Map<String, dynamic> json) {
    UniqueKey uniqueKey = UniqueKey.fromString(json['uniqueKey']);
    String name = json['name'];
    List<Profile> profiles = (json['profiles'] as List)
        .map((profileJson) => Profile.fromJson(profileJson))
        .toList();

    Widget widget = ProfileGroup.createProfileGroupWidget(profiles, name);
    return ProfileGroup(uniqueKey, name, profiles, widget);
  }

  static Widget createProfileGroupWidget(BuildContext context,
      List<Profile> profiles, String groupName, UniqueKey uniqueKey) {
    int profileLength = profiles.length;
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            minimumSize: Size(
                double.infinity, MediaQuery.of(context).size.height * 0.08)),
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
                    // Replace 'deleteGroup' with the appropriate method in your provider.
                    context.read<ProfileGroupProvider>().deleteGroup(uniqueKey);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

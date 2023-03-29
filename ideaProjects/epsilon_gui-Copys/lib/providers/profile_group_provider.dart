import 'dart:io';

import 'package:epsilon_gui/providers/profile_provider.dart';
import 'package:epsilon_gui/screens/components/TopBar_.dart';
import 'package:epsilon_gui/providers/tasks_list_provider.dart';
import 'package:epsilon_gui/providers/task_inputs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ready/ready.dart';

class ProfileGroupProvider with ChangeNotifier {
  Map<UniqueKey, List<ProfileInstance>> profileGroups_ins = {};
  Map<UniqueKey, Widget> profileGroups_widget = {};
  Map<UniqueKey, String> profileGroups_names = {};
  late BuildContext context_;
  List<DataRow> all_profiles_data = [];

//GETTERS
  List<DataRow> get allProfilesData => all_profiles_data;
  Map<UniqueKey, Widget> get profileWidgetList => profileGroups_widget;

//SETTERS
  void setContext(BuildContext newcontext) {
    context_ = newcontext;
    notifyListeners();
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
    for (ProfileInstance instance in list) {
      data.add(instance.getDataRow());
    }
    notifyListeners();
    return data;
  }

  List<ProfileInstance> getSelectedProfiles() {
    var list = context_.read<ProfileProvider>().all_profile_instances;
    List<ProfileInstance> selectedProfiles = [];
    for (ProfileInstance instance in list) {
      if (instance.checked == true) {
        selectedProfiles.add(instance);
      }
    }
    return selectedProfiles;
  }

  void addtoGroupDetails(List<ProfileInstance> list, UniqueKey key) {
    profileGroups_ins.addAll({key: list});
    notifyListeners();
  }

  void deleteGroup(UniqueKey uniqueKey) {
    profileGroups_ins.removeWhere((key, value) => key == uniqueKey);
    profileGroups_widget.removeWhere((key, value) => key == uniqueKey);
    profileGroups_names.removeWhere((key, value) => key == uniqueKey);

    notifyListeners();
  }

  Widget createProfileGroup(context, groupName, key) {
    List<ProfileInstance> selectedProfiles = getSelectedProfiles();
    addtoGroupDetails(selectedProfiles, key);

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
                  "${selectedProfiles.length} Profile(s)",
                  style: const TextStyle(fontSize: 14),
                )),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
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
    final nameEntry = <UniqueKey, String>{key: groupName};
    final entry = <UniqueKey, Widget>{
      key: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                    color: Color.fromARGB(255, 25, 36, 78), width: 3)),
            child: createProfileGroup(context, groupName, key),
          ),
        ],
      )
    };
    profileGroups_widget.addEntries(entry.entries);
    profileGroups_names.addEntries(nameEntry.entries);
    notifyListeners();
  }
}

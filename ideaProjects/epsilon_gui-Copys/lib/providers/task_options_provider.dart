import 'dart:io';

import 'package:flutter/material.dart';
import 'package:epsilon_gui/providers/profile_group_provider.dart';

class TaskOptions with ChangeNotifier {
  ProfileGroupProvider profileGroupReference;

  TaskOptions(this.profileGroupReference) {}
  List<DropdownMenuItem<String>>? size_options = [
    DropdownMenuItem(
      value: "XS",
      child: Text("XS"),
    ),
    DropdownMenuItem(
      value: "S",
      child: Text("S"),
    ),
    DropdownMenuItem(
      value: "M",
      child: Text("M"),
    ),
    DropdownMenuItem(
      value: "L",
      child: Text("L"),
    ),
    DropdownMenuItem(
      value: "XL",
      child: Text("XL"),
    ),
  ];
  List<DropdownMenuItem<String>>? store_options = [
    DropdownMenuItem(
      value: "Trapstar",
      child: Text("Trapstar"),
    ),
    DropdownMenuItem(
      value: "Palace-Clothing",
      child: Text("Palace-Clothing"),
    ),
    DropdownMenuItem(
      child: Text("End-Clothing"),
      value: "End-Clothing",
    )
  ];
  List<DropdownMenuItem<String>>? region_options = [
    DropdownMenuItem(
      value: "UK",
      child: Text("UK"),
    ),
    DropdownMenuItem(
      value: "US",
      child: Text("US"),
    ),
    DropdownMenuItem(
      value: "EU",
      child: Text("EU"),
    ),
  ];
  List<DropdownMenuItem<String>>? profile_options = [
    DropdownMenuItem(
      value: "No Profile Groups",
      child: Text("No Profile Groups"),
    ),
  ];
  List<DropdownMenuItem<String>>? taskType_options = [
    DropdownMenuItem(
      value: "Browser",
      child: Text("Browser"),
    ),
    DropdownMenuItem(
      value: "Requests",
      child: Text("Requests"),
    ),
  ];
  List<DropdownMenuItem<String>>? proxy_options = [
    DropdownMenuItem(
      value: "group1",
      child: Text("group1"),
    ),
  ];
  List<DropdownMenuItem<String>>? clothingType_options = [
    const DropdownMenuItem(
      value: "Sneakers",
      child: Text("Sneakers"),
    ),
    DropdownMenuItem(
      value: "Jackets",
      child: Text("Jackets"),
    ),
    DropdownMenuItem(
      value: "Bottoms",
      child: Text("Bottoms"),
    ),
    DropdownMenuItem(
      value: "Jumpers",
      child: Text("Jumpers/Hoodies"),
    ),
    DropdownMenuItem(
      value: "Shirts",
      child: Text("T-Shirts"),
    ),
    DropdownMenuItem(
      value: "Bottoms",
      child: Text("Bottoms"),
    ),
  ];

  List<String> size_list = <String>['XS', 'S', 'M', 'L', 'XL'];
  List<String> category_list = <String>[
    'Sneakers',
    'Jackets',
    'Bottoms',
    'Jumpers',
    'T-Shirts',
    'Bottoms'
  ];
  List<String> region_list = <String>['UK', 'US', 'EU'];
  List<String> profile_list = <String>['No Profile Groups'];
  List<String> taskType_list = <String>['Browser', 'Requests'];
  List<String> proxyGroup_list = <String>['group1'];
  List<String> store_list = <String>[
    'Trapstar',
    'Palace-Clothing',
    'End-Clothing'
  ];

  void setProfileGroups() {
    if (profileGroupReference.profileGroups_ins.keys.toList().isEmpty) {
      //Make Unselectable
      print("nothing here");
    } else {
      profile_list = profileGroupReference.profileGroups_names.values.toList();
      print("got here");
      profile_options = createDropdownMenu(profile_list);
    }
  }

  List<DropdownMenuItem<String>>? createDropdownMenu(list) {
    List<DropdownMenuItem<String>>? dropdown = [];
    for (String str in list) {
      dropdown.add(DropdownMenuItem(
        value: str,
        child: Text(str),
      ));
    }
    return dropdown;
  }

  List<DropdownMenuItem<String>>? get stores => store_options;
  List<DropdownMenuItem<String>>? get sizes => size_options;
  List<DropdownMenuItem<String>>? get regions => region_options;
  List<DropdownMenuItem<String>>? get profiles => profile_options;
  List<DropdownMenuItem<String>>? get taskTypes => taskType_options;
  List<DropdownMenuItem<String>>? get proxies => proxy_options;
  List<DropdownMenuItem<String>>? get clothingTypes => clothingType_options;
}

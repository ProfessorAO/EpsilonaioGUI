import 'package:epsilon_gui/providers/profile_provider.dart';
import 'package:epsilon_gui/providers/profile_group_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

typedef StringVoidCallback = void Function(String?);
typedef StringCallback = void Function(String);
typedef ProfileGroupVoidCallback = void Function(ProfileGroup?);

class columInputer_text extends StatelessWidget {
  const columInputer_text({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.label,
    required this.length,
  });

  final TextEditingController controller;
  final StringCallback onChanged;
  final String label;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 25, 36, 78),
      child: TextField(
          style: const TextStyle(
              fontFamily: 'Audiowide', color: Colors.white, fontSize: 16),
          controller: controller,
          maxLength: length,
          onChanged: onChanged,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Color.fromARGB(255, 25, 36, 78))),
            counterText: '',
            label: Text(
              label,
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.all(8),
          )),
    );
  }
}

class columnInput_Menu extends StatelessWidget {
  const columnInput_Menu({
    super.key,
    required this.value,
    required this.onChanged,
    required this.Menuitems,
    required this.label,
  });

  final String value;
  final StringVoidCallback onChanged;
  final List<DropdownMenuItem<String>>? Menuitems;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 3, color: Color.fromARGB(255, 25, 36, 78))),
          label: Text(
            label,
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 25, 36, 78),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.all(8),
        ),
        dropdownColor: const Color.fromRGBO(26, 25, 25, 1),
        value: value,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        style: const TextStyle(
            fontFamily: 'Audiowide', color: Colors.white, fontSize: 15),
        items: Menuitems,
        onChanged: onChanged);
  }
}

class columnInput_Menu_custom extends StatelessWidget {
  const columnInput_Menu_custom({
    super.key,
    required this.value,
    required this.onChanged,
    required this.Menuitems_custom,
    required this.label,
  });

  final ProfileGroup value;
  final ProfileGroupVoidCallback onChanged;
  final List<DropdownMenuItem<ProfileGroup>>? Menuitems_custom;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 3, color: Color.fromARGB(255, 25, 36, 78))),
        label: Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 15),
        ),
        filled: true,
        fillColor: Color.fromARGB(255, 25, 36, 78),
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.all(8),
      ),
      dropdownColor: const Color.fromRGBO(26, 25, 25, 1),
      value: value,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      style: const TextStyle(
          fontFamily: 'Audiowide', color: Colors.white, fontSize: 15),
      items: Menuitems_custom,
      onChanged: (Object? value) => onChanged(value as ProfileGroup?),
    );
  }
}

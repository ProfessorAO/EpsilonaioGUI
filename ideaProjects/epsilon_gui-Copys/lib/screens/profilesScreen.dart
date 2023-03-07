import 'package:epsilon_gui/screens/components/epsilonText.dart';
import 'package:epsilon_gui/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:epsilon_gui/providers/tabbar_index_provider.dart';
import 'package:epsilon_gui/screens/components/bottombar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:epsilon_gui/screens/components/CustomPackages/InputWidgets.dart';

class ProfilesScreen extends StatelessWidget {
  const ProfilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 17, 26, 59),
        body: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: dashboard(context),
              ),
            ],
          ),
        ));
  }

  Container dashboard(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          EpsilonText(),
          context.watch<TabbarIndex>().this_TopBar,
          bottomBar(),
          ProfileGroup(),
          Profile_btn_State(),
          remove_Profiles(),
          Profiles_layout_state(),
        ],
      ),
    );
  }
}

class Profiles_layout_state extends StatefulWidget {
  const Profiles_layout_state({
    super.key,
  });
  @override
  State<Profiles_layout_state> createState() => Profiles_layout();
}

class Profiles_layout extends State<Profiles_layout_state> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.03,
      top: MediaQuery.of(context).size.height * 0.08,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.685,
        height: MediaQuery.of(context).size.height * 0.82,
        child: RawScrollbar(
          thumbColor: Colors.white,
          radius: const Radius.circular(16),
          thickness: 3,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            dragStartBehavior: DragStartBehavior.down,
            primary: true,
            child: Wrap(
              spacing: MediaQuery.of(context).size.width * 0.03,
              runSpacing: MediaQuery.of(context).size.width * 0.025,
              children: context.watch<ProfileProvider>().all_profile_cards,
            ),
          ),
        ),
      ),
    );
  }
}

class Profile_btn_State extends StatefulWidget {
  const Profile_btn_State({
    super.key,
  });
  @override
  State<Profile_btn_State> createState() => Add_Profile_btn();
}

class Add_Profile_btn extends State<Profile_btn_State> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.01,
      left: MediaQuery.of(context).size.width * 0.01,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.all(16.0),
        ),
        onPressed: () {
          final snackBar = SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.green,
            content: const Text('Profile Created'),
            action: SnackBarAction(
              label: '',
              onPressed: () {},
            ),
          );
          final ProfileController = TextEditingController();
          final CardController = TextEditingController();
          final AddressController = TextEditingController();
          final CardNoController = TextEditingController();
          showPopupWindow(context,
              gravity: KumiPopupGravity.center,
              //curve: Curves.elasticOut,
              bgColor: const Color.fromARGB(255, 17, 26, 59).withOpacity(0.8),
              clickOutDismiss: true,
              clickBackDismiss: true,
              customAnimation: false,
              customPop: false,
              customPage: false,
              //targetRenderBox: (btnKey.currentContext.findRenderObject() as RenderBox),
              //needSafeDisplay: true,
              underStatusBar: false,
              underAppBar: true,
              offsetX: 0,
              offsetY: 0,
              duration: Duration(milliseconds: 200), childFun: (pop) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.55,
              height: MediaQuery.of(context).size.width * 0.45,
              key: GlobalKey(),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 25, 36, 78),
              ),
              child: Row(
                children: [],
              ),
            );
          });

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context.read<ProfileProvider>().addProfile(Profile_card());
          setState(() {});
        },
        child: const Text('Add Profile'),
      ),
    );
  }
}

class remove_Profiles extends StatefulWidget {
  @override
  State<remove_Profiles> createState() => _remove_ProfilesState();
}

class _remove_ProfilesState extends State<remove_Profiles> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.01,
      left: MediaQuery.of(context).size.width * 0.096,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          padding: const EdgeInsets.all(16.0),
        ),
        onPressed: () {
          final snackBar = SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.red,
            content: Text(
                '${context.read<ProfileProvider>().all_profile_cards.length.toString()} Profiles Removed'),
            action: SnackBarAction(
              label: '',
              onPressed: () {},
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context.read<ProfileProvider>().removeAllProfiles();
          setState(() {});
        },
        child: const Text('Remove All Profiles'),
      ),
    );
  }
}

class Profile_card extends StatelessWidget {
  const Profile_card({
    super.key,
  });

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
                  "Profile Name",
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
                child: Text("Card Name",
                    style: TextStyle(color: Colors.white, fontSize: 12))),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.01, 0, 0, 0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Address",
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
                    child: Text("\u2022 \u2022 \u2022 \u2022  1234",
                        style: TextStyle(color: Colors.white, fontSize: 12))),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
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
                    context.read<ProfileProvider>().removeProfile(this);
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

class ProfileGroup extends StatelessWidget {
  const ProfileGroup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: MediaQuery.of(context).size.width * 0.72,
        top: MediaQuery.of(context).size.height * 0.08,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.27,
            height: MediaQuery.of(context).size.height * 0.82,
            child: Column(children: [
              Expanded(
                  flex: 1,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.28,
                            MediaQuery.of(context).size.height * 0.1)
                        //padding: const EdgeInsets.all(16.0),
                        ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        const Spacer(),
                        const Text(
                          'New Profile Group',
                          style: TextStyle(fontSize: 17),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,
                              MediaQuery.of(context).size.height * 0.001, 0, 0),
                          child: Icon(
                            Icons.add,
                            size: MediaQuery.of(context).size.height * 0.027,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 9,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: Color.fromARGB(255, 25, 36, 78),
                              width: 3)),
                      child: RawScrollbar(child: SingleChildScrollView())

                      //width: MediaQuery.of(context).size.width * 0.265,

                      )),
            ])));
  }
}

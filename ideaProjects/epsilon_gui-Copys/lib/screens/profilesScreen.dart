import 'package:epsilon_gui/screens/components/epsilonText.dart';
import 'package:epsilon_gui/providers/profile_provider.dart';
import 'package:epsilon_gui/providers/profile_group_provider.dart';
import 'package:flutter/material.dart';
import 'package:epsilon_gui/providers/tabbar_index_provider.dart';
import 'package:epsilon_gui/screens/components/bottombar.dart';
import 'package:epsilon_gui/screens/components/CustomPackages/InputWidgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:epsilon_gui/screens/components/column_general.dart';

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
    ProfileGroupProvider profileGroupProvider =
        context.watch<ProfileGroupProvider>();
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
                children: context.watch<ProfileProvider>().all_profile_cards),
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
          final ProfileController = TextEditingController();
          final FnameController = TextEditingController();
          final LnameController = TextEditingController();
          final PostcodeController = TextEditingController();
          final CardNameController = TextEditingController();
          final CardNumberController = TextEditingController();
          final phoneController = TextEditingController();
          final CityController = TextEditingController();
          final AddressController = TextEditingController();
          final CardNoController = TextEditingController();
          String firstName = "";
          String lastName = "";
          String profileName = "";
          String cardName = "";
          String cardNumber = "";
          String address = "";
          String city = "";
          String postcode = "";
          String phone = "";
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
              child: Column(
                children: [
                  Expanded(
                      child: columInputer_text(
                    length: 50,
                    controller: ProfileController,
                    onChanged: (String input) {
                      profileName = input;
                    },
                    label: "Profile Name",
                  )),
                  Expanded(
                      child: columInputer_text(
                    length: 50,
                    controller: FnameController,
                    onChanged: (String input) {
                      firstName = input;
                    },
                    label: "First Name",
                  )),
                  Expanded(
                      child: columInputer_text(
                    length: 50,
                    controller: LnameController,
                    onChanged: (String input) {
                      lastName = input;
                    },
                    label: "Last Name",
                  )),
                  Expanded(
                      child: columInputer_text(
                    length: 50,
                    controller: CardNameController,
                    onChanged: (String input) {
                      cardName = input;
                    },
                    label: "Card Name",
                  )),
                  Expanded(
                      child: columInputer_text(
                    length: 50,
                    controller: CardNumberController,
                    onChanged: (String input) {
                      cardNumber = input;
                    },
                    label: "Card Number",
                  )),
                  Expanded(
                      child: columInputer_text(
                    length: 50,
                    controller: AddressController,
                    onChanged: (String input) {
                      address = input;
                    },
                    label: "Address",
                  )),
                  Expanded(
                      child: columInputer_text(
                    length: 50,
                    controller: CityController,
                    onChanged: (String input) {
                      city = input;
                    },
                    label: "City",
                  )),
                  Expanded(
                      child: columInputer_text(
                    length: 50,
                    controller: PostcodeController,
                    onChanged: (String input) {
                      postcode = input;
                    },
                    label: "Postcode",
                  )),
                  Expanded(
                      child: columInputer_text(
                    length: 50,
                    controller: phoneController,
                    onChanged: (String input) {
                      phone = input;
                    },
                    label: "Phone Number",
                  )),
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            context
                                .read<ProfileProvider>()
                                .createProfileInstance(
                                  firstName,
                                  lastName,
                                  profileName,
                                  cardName,
                                  cardNumber,
                                  address,
                                  city,
                                  postcode,
                                  phone,
                                  Profile_card(
                                      profile_name: profileName,
                                      card_name: cardName,
                                      address: address,
                                      card_no: cardNumber),
                                  context.read<ProfileGroupProvider>(),
                                );

                            setState(() {});

                            final snackBar = SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.green,
                              content: const Text('Profile Created'),
                              action: SnackBarAction(
                                label: '',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            setState(() {});
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          child: Text("Create Profile")))
                ],
              ),
            );
          });

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

class ProfileGroup extends StatefulWidget {
  const ProfileGroup({
    super.key,
  });

  @override
  State<ProfileGroup> createState() => _ProfileGroupState();
}

class _ProfileGroupState extends State<ProfileGroup> {
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
                  onPressed: () {
                    final ProfileGroupNameController = TextEditingController();
                    String profileGroupName = "";
                    context.read<ProfileGroupProvider>().refreshData();
                    showPopupWindow(
                      context,
                      gravity: KumiPopupGravity.center,
                      bgColor: Color.fromARGB(255, 17, 26, 59).withOpacity(0.8),
                      clickOutDismiss: true,
                      clickBackDismiss: true,
                      customAnimation: false,
                      customPop: false,
                      customPage: false,
                      underStatusBar: false,
                      underAppBar: true,
                      offsetX: 0,
                      offsetY: 0,
                      duration: Duration(milliseconds: 200),
                      childFun: (popup) {
                        return StatefulBuilder(
                            key: GlobalKey(),
                            builder:
                                (BuildContext context, StateSetter setState) {
                              setState;
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: Color.fromARGB(255, 25, 36, 78),
                                ),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.width * 0.45,
                                child: Column(
                                  children: [
                                    columInputer_text(
                                        controller: ProfileGroupNameController,
                                        onChanged: (String value) {
                                          profileGroupName = value;
                                        },
                                        label: "Profile Group Name",
                                        length: 100),
                                    //Spacer(),
                                    SizedBox(
                                      child: RawScrollbar(
                                        thumbColor: Colors.white,
                                        radius: const Radius.circular(16),
                                        thickness: 3,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          dragStartBehavior:
                                              DragStartBehavior.down,
                                          primary: true,
                                          child: Theme(
                                            data: ThemeData(
                                              primarySwatch: Colors.blue,
                                              unselectedWidgetColor:
                                                  Colors.white,
                                            ),
                                            child: DataTable(
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    border: Border.all(
                                                        color: Color.fromARGB(
                                                            255, 25, 36, 78),
                                                        width: 3)),
                                                headingRowColor:
                                                    MaterialStateColor
                                                        .resolveWith(
                                                  (states) {
                                                    return const Color.fromARGB(
                                                        255, 25, 36, 78);
                                                  },
                                                ),
                                                columns: const [
                                                  DataColumn(
                                                    label: table_Column(
                                                        name: "ID"),
                                                  ),
                                                  DataColumn(
                                                      label: table_Column(
                                                          name: "Card Name")),
                                                  DataColumn(
                                                      label: table_Column(
                                                          name: "Card No")),
                                                  DataColumn(
                                                      label: table_Column(
                                                          name: "Address")),
                                                  DataColumn(
                                                      label: table_Column(
                                                          name: "Phone")),
                                                ],
                                                rows: context
                                                    .watch<
                                                        ProfileGroupProvider>()
                                                    .all_profiles_data),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          print("here");
                                          context
                                              .read<ProfileGroupProvider>()
                                              .addProfileGroup(
                                                  profileGroupName);
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.blue,
                                          textStyle: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: Text("Create Profile Group"))
                                  ],
                                ),
                              );
                            });
                      },
                    );
                  },
                  child: Row(
                    children: [
                      const Spacer(),
                      const Text(
                        'New Profile Group',
                        style: TextStyle(fontSize: 17),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,
                            MediaQuery.of(context).size.height * 0.006, 0, 0),
                        child: Icon(
                          Icons.add,
                          size: MediaQuery.of(context).size.height * 0.027,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 9,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                              color: Color.fromARGB(255, 25, 36, 78),
                              width: 3)),
                      child: RawScrollbar(
                          child: SingleChildScrollView(
                              child: profileGroupColumn()))

                      //width: MediaQuery.of(context).size.width * 0.265,

                      )),
            ])));
  }
}

class profileGroupColumn extends StatefulWidget {
  const profileGroupColumn({
    super.key,
  });

  @override
  State<profileGroupColumn> createState() => _profileGroupColumnState();
}

class _profileGroupColumnState extends State<profileGroupColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(children: context.watch<ProfileGroupProvider>().getWidgets());
  }
}

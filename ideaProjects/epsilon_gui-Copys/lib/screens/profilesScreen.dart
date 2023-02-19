import 'package:epsilon_gui/screens/components/epsilonText.dart';
import 'package:epsilon_gui/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:epsilon_gui/providers/tabbar_index_provider.dart';
import 'package:epsilon_gui/screens/components/bottombar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';

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
        )
    );
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
                    Profiles_layout_state(),
                    
                     
                    
                  ],
                ),
              );
  }
}
class Profiles_layout_state extends StatefulWidget{
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
class Profile_btn_State extends StatefulWidget{
  const Profile_btn_State ({
    super.key,
  });
  @override
  State<Profile_btn_State> createState() => Add_Profile_btn() ;
}
class Add_Profile_btn extends State<Profile_btn_State> {
 
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.01,
      left: MediaQuery.of(context).size.width * 0.01 ,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.all(16.0),
        ),
        onPressed: () {
           final snackBar = SnackBar(
                                          backgroundColor: Colors.green,
                                          content: const Text('Profile Created'),
                                          action: SnackBarAction(
                                          label: '',
                                    onPressed: () {},
                                  ),
                                    );
                              
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context.read<ProfileProvider>().addProfile(Profile_card());
          setState((){});
        
          
        },
        child: const Text('Add Profile'),
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
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.white,width: 0.8)
      ),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01,0,0,0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Profile Name",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 13),)),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          Padding(
            padding:EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01,0,0,0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Card Name",style: TextStyle(color: Colors.white,fontSize: 12))),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01,0,0,0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Address",style: TextStyle(color: Colors.white,fontSize: 12))),
          ),


          Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01,0,0,0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(".... 1234",style: TextStyle(color: Colors.white,fontSize: 12))),
          ),

          Padding(
            padding:  EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.16,0,0,0),
            child: Row(
              children: [
                Icon(Icons.edit,size: 20,color: Colors.white,),
                Icon(Icons.delete,size: 20,color: Colors.white,)
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
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: TextButton(
                style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                minimumSize: Size(MediaQuery.of(context).size.width * 0.28,MediaQuery.of(context).size.height* 0.1)
                //padding: const EdgeInsets.all(16.0),
        ),
        onPressed: () {},
        child:  Row(
                children:  [
                  const Spacer(),
                  const Text('New Profile Group',style: TextStyle(fontSize: 17),),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.001, 0, 0),
                    child: Icon(Icons.add,size:MediaQuery.of(context).size.height * 0.027  ,),
                  ),
                  const Spacer(),
                ],
              ),
              )
            ),
            Expanded(
              flex:9,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  
                  borderRadius: BorderRadius.all(Radius.circular(5)),
        
          border:  Border.all(color: Color.fromARGB(255, 25, 36, 78),width: 3)
                ),
                child: RawScrollbar(
                  child: SingleChildScrollView(
                    )
                    )
                
                //width: MediaQuery.of(context).size.width * 0.265,

                
                
              )
            ),
          ]
        )
      )
    );
  }
}
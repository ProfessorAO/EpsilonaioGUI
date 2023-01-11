import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:epsilon_gui/screens/components/CustomPackages/OnHoverText.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 45,
          child: WindowTitleBarBox(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: MoveWindow(
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: infoBar(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0,0 , 0),
                  child: WindowsButtons(),
                ),

              ],
            ),
          ),
        )
      ],
    );
  }
}
class WindowsButtons extends StatelessWidget{
  String currdate = "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        MinimizeWindowButton(colors: WindowButtonColors(iconNormal: Colors.white,iconMouseOver: Colors.blueAccent)),
        //MaximizeWindowButton(colors: WindowButtonColors(iconNormal: Colors.white,iconMouseOver: Colors.blueAccent)),
        CloseWindowButton(colors: WindowButtonColors(iconNormal: Colors.white,iconMouseOver: Colors.red)),
      ],
    );
  }
}
class infoBar extends StatelessWidget{
  String currdate = "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}";

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height : 29,
          width:  MediaQuery.of(context).size.width * 0.6/2,
          color: const Color.fromRGBO(26, 25, 25, 0.6),
          child: const TextField(
            style:TextStyle(fontFamily: 'Audiowide',color: Colors.white70,fontSize: 20) ,
            decoration: InputDecoration( labelStyle: TextStyle(fontFamily: 'Audiowide',color: Colors.white30,fontSize: 20),
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              labelText: 'Search',),

          ),
        ),
        Align(
          alignment:Alignment.bottomCenter ,
          child: SizedBox(
            width: 95,
            height: 30,
            child: Text(
              currdate,
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 13),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: OnHoverText(
            child: Image.asset(
              "assets/images/discord.png",
              height : 35,
              width:  35,
            ),
          ),
        ),

        OnHoverText(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Image.asset(
              "assets/images/bell.png",
              height : 29,
              width:  29,
            ),
          ),
        ),
        OnHoverText(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Image.asset(
              "assets/images/settings.png",
              height : 29,
              width:  29,
            ),
          ),
        ),
        Align(
          alignment:Alignment.bottomCenter ,
          child: Container(
            color: Colors.black26,
            width: 85,
            height: 40,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Text(
                "User1",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 14),
              ),
            ),
          ),
        ),
        OnHoverText(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: CircleAvatar(
              backgroundColor: Color(1692195289),
              child: Text(
                'U1',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18,color: Colors.white),),
            ),
          ),
        ),
      ],
    );
  }
}

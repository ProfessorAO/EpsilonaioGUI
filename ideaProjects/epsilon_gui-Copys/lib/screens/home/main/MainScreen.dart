

import 'package:epsilon_gui/screens/components/CustomPackages/OnHoverChange.dart';
import 'package:epsilon_gui/screens/components/CustomPackages/OnHoverText.dart';
import 'package:epsilon_gui/screens/home/main_components/sideMenu.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import '../../components/background.dart';
import '../../components/epsilonText.dart';


class MainScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: 140,
              child: SideMenu(color: Color.fromARGB(255, 49, 47, 47)),
              ),
              Expanded(
                  child: dashboard(context),
              ),
            // Container(
            //     child: DashboardScreen()
            //
            // ),
          ],
        ),
      )
    );
  }
  Container dashboard(BuildContext context) {
    return Container(


      child: Stack(
        children: [
          const background(),
          const EpsilonText(),
          TotalSpent(),
          CheckoutsWiget(),
          FailuresWiget(),
          TopBar(),
          Releases(),
          sneakerNews(),
          _CalendarState(),
          RecentCheckouts(),
        ],

      )
    );
  }
}

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
                  flex: 5,
                  child: MoveWindow(
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: infoBar(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0,0 , 10),
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
class RecentCheckouts extends StatelessWidget {
  const RecentCheckouts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      bottom: MediaQuery.of(context).size.height/5 -120,
      child: SizedBox(
        width: (MediaQuery.of(context).size.width * 0.7) - (MediaQuery.of(context).size.width * 0.22) - 20,
        height: MediaQuery.of(context).size.height /1.6 ,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Baseline(
                  baseline: 1 ,
                  baselineType: TextBaseline.alphabetic,
                child: Text("Recent Checkouts",
                    style: TextStyle(fontSize: 25,
                        fontFamily: 'Audiowide',
                        color: Color.fromARGB(125, 255, 255, 255)
                    )
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text("Price",
                          style: TextStyle(
                              color: Color.fromARGB(255, 210, 210, 210),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ),
                    Text("Shoe name",
                      style: TextStyle(
                          color: Color.fromARGB(255, 210, 210, 210),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text("Date/Time",
                      style: TextStyle(
                          color: Color.fromARGB(255, 210, 210, 210),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text("Store",
                      style: TextStyle(
                          color: Color.fromARGB(255, 210, 210, 210),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text("Result",
                      style: TextStyle(
                          color: Color.fromARGB(255, 210, 210, 210),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(26, 25, 25, 0.6),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                )
            ),
            Spacer(),
            Expanded(
                flex: 8,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(26, 25, 25, 0.6),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                )
            ),
            Spacer(),
            Expanded(
                flex: 8,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(26, 25, 25, 0.6),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                )
            ),
            Spacer(),
            Expanded(
                flex: 8,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(26, 25, 25, 0.6),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                )
            ),
            Spacer(),
            Expanded(
                flex: 8,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(26, 25, 25, 0.6),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                )
            ),
            Spacer(),
            Expanded(
                flex: 8,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(26, 25, 25, 0.6),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                )
            ),
            Spacer(),
            Expanded(
                flex: 8,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(26, 25, 25, 0.6),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}
class FailuresWiget extends StatelessWidget {
  const FailuresWiget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (MediaQuery.of(context).size.width * 0.7 + 20),
      top:  (MediaQuery.of(context).size.width /4.7 + 50) + ((MediaQuery.of(context).size.width /4.7) / 3) + ((MediaQuery.of(context).size.width /4.7) / 3)+ 20,
      right: 10,
      child: InkWell(
        onTap: (){
          print("Clicked on Failures");
        },
        hoverColor: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width /4.8 ,
          height: (MediaQuery.of(context).size.width /4.7) / 3,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 70, 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: OnHoverChange(builder : (isHovered) {
                final color = isHovered? Colors.orange : Color.fromARGB(255, 255, 255, 255);
                return Container(
                  child: Text("Failures",
                    style: TextStyle(fontSize: MediaQuery
                        .of(context)
                        .size
                        .width / 90,
                      fontFamily: 'Audiowide',
                      color: color,

                    ),
                  ),
                );
              }),
            ),
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment(0.9,0.1),
                image: AssetImage("assets/images/declined.png"),
                scale: MediaQuery.of(context).size.width / 400,
              ),
              color: Color.fromRGBO(114, 3, 3, 0.7137254901960784),
              border: Border.all(
                width: 3,
                color: Color.fromRGBO(255, 0, 0, 1.0),

              ),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
        ),
      ),
    );
  }
}
class CheckoutsWiget extends StatelessWidget {
  const CheckoutsWiget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (MediaQuery.of(context).size.width * 0.7 + 20),
      top:  (MediaQuery.of(context).size.width /4.7 + 50) + ((MediaQuery.of(context).size.width /4.7) / 3) + 15,
      right: 10,
      child: InkWell(
        onTap: (){
          print("Clicked on Checkouts");
          },
        child: Container(
          width: MediaQuery.of(context).size.width /4.8 ,
          height: (MediaQuery.of(context).size.width /4.7) / 3,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 70, 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: OnHoverChange(builder : (isHovered){
                final color = isHovered? Colors.orange : Color.fromARGB(255, 255, 255, 255);
                return Container(
                  child: Text("Checkouts",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width /90,
                      fontFamily: 'Audiowide',
                      color: color,

                    ),
                  ),
                );
              }),
            ),
          ),
          decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment(0.9,0.1),
                image: AssetImage("assets/images/checkout.png"),
                scale: MediaQuery.of(context).size.height / 170,
              ),
              color: Color.fromRGBO(0, 89, 25, 0.7137254901960784),
              border: Border.all(
                width: 3,
                color: Color.fromRGBO(0, 255, 71, 1.0),

              ),
              borderRadius: BorderRadius.all(Radius.circular(15))

          ),
        ),
      ),
    );
  }
}
class TotalSpent extends StatelessWidget {
  const TotalSpent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (MediaQuery.of(context).size.width * 0.7 + 20),
      top:  (MediaQuery.of(context).size.width /4.7 + 60),
      right: 10,
      child: InkWell(
        onTap: (){
          print("Clicked on TotalSpent");
          },
        child: Container(
          width: MediaQuery.of(context).size.width /4.8 ,
          height: (MediaQuery.of(context).size.width /4.7) / 3,
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment(0.85,1),
              image: AssetImage("assets/images/money.png"),
              scale: MediaQuery.of(context).size.width /400 ,
            ),

            color: Color.fromRGBO(1, 44, 105, 0.7137254901960784),
              border: Border.all(
                width: 3,
                color: Color.fromRGBO(0, 102, 255, 1.0),

              ),
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 90, 20),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: OnHoverChange(builder : (isHovered){
                final color = isHovered? Colors.orange : Color.fromARGB(255, 255, 255, 255);
                return Container(
                    child: Text("Total Spent",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width /90,
                        fontFamily: 'Audiowide',
                          color: color,

                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      );
  }
}
class _CalendarState extends StatefulWidget{
  @override
  Calendar createState() => Calendar();
}
class Calendar extends State<_CalendarState> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;


  @override
  Widget build(BuildContext context) {
    return Positioned(
      left :   (MediaQuery.of(context).size.width * 0.7 + 20) ,
      top: 50,
      right: 10,
      child: Container(
        width: MediaQuery.of(context).size.width /4.8 ,
        height: MediaQuery.of(context).size.width /4.7 ,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(26, 25, 25, 0.6),
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: TableCalendar(
          availableCalendarFormats: {CalendarFormat.month : 'Month'},
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: Colors.grey
            ),
                weekendStyle: TextStyle(
              color: Colors.white
          )
          ),
          calendarStyle:  CalendarStyle(
            defaultTextStyle: TextStyle(
                fontSize: 14  ,
                color: Color.fromARGB(255, 152, 148, 148)),
            weekendTextStyle: TextStyle(
                fontSize: 14  ,
                color: Colors.white54),

          ),
            headerStyle: const HeaderStyle(
              //leftChevronIcon: ,
              //rightChevronIcon: ,
              //titleTextFormatter: ,
              titleTextStyle: TextStyle(fontSize: 18  ,
                fontFamily: 'Audiowide',
                color: Color.fromARGB(255, 255, 255, 255))
            ),
            rowHeight: (MediaQuery.of(context).size.width/40)  + (MediaQuery.of(context).size.height/40) / 50,
            focusedDay: DateTime.now() ,
            firstDay: DateTime.utc(2010,10,16),
            lastDay: DateTime.utc(2030,3,14),
          selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay){
              setState((){
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });

          },
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
class sneakerNews extends StatelessWidget {
  const sneakerNews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right :  MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.7 + 150) ,
      bottom: MediaQuery.of(context).size.height/5 -130,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.22,
        height: MediaQuery.of(context).size.height /1.6,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(26, 25, 25, 0.6),
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Baseline(
          baselineType: TextBaseline.alphabetic,
          baseline: -7,
          child: Text("Sneaker News",
                style: TextStyle(fontSize: 25,
                    fontFamily: 'Audiowide',
                    color: Color.fromARGB(125, 255, 255, 255),
                ),
              ),

        ),
      ),
    );
  }
}
class Releases extends StatelessWidget {
  const Releases({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child :Positioned(
          left: 10,
          top: 50,
          right: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.7 + 150) ,
          child : Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height / 4.5,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(26, 25, 25, 0.6),
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),


            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 4.5,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft:   Radius.circular(15),
                        ),
                          color:Color.fromARGB(255, 30, 30, 30),
                      ),

                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Baseline(
                          baseline: -10 ,
                          baselineType: TextBaseline.alphabetic,
                          child: Text("Releases",
                              style: TextStyle(fontSize: 25,
                                  fontFamily: 'Audiowide',
                                  color: Color.fromARGB(125, 255, 255, 255)
                              )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 6,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 4.5,
                      child: Container(
                        color: Color.fromARGB(255, 30, 30, 30),

                      ),
                    )
                ),
                Spacer(),
                Expanded(
                    flex: 6,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 4.5,
                      child: Container(
                          color: Color.fromARGB(255, 30, 30, 30),

                      ),
                    )
                ),
                Spacer(),
                Expanded(
                    flex: 6,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 4.5,
                      child: Container(
                          color: Color.fromARGB(255, 30, 30, 30),

                      ),
                    )
                ),
                Spacer(),
                Expanded(
                    flex: 6,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 4.5,
                      child: Container(
                          color: Color.fromARGB(255, 30, 30, 30),

                      ),
                    )
                ),
                Spacer(),
                Expanded(
                    flex: 6,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 4.5,
                      child: Container(
                          color: Color.fromARGB(255, 30, 30, 30),

                      ),
                    )
                ),
                Spacer(),
                Expanded(
                    flex: 6,
                    child: SizedBox(
                      height:MediaQuery.of(context).size.height / 4.5,
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight:   Radius.circular(15),
                            ),
                            color: Color.fromARGB(255, 30, 30, 30),
                        ),
                      ),
                    )
                ),
              ],
            )


          ),
    ),
    );
  }
}
class WindowsButtons extends StatelessWidget{
  String currdate = (DateTime.now().day.toString())+"/" +DateTime.now().month.toString()+"/" + DateTime.now().year.toString();
  @override
  Widget build(BuildContext context){
          return Row(
            children: [
              MinimizeWindowButton(colors: WindowButtonColors(iconNormal: Colors.white,iconMouseOver: Colors.blueAccent)),
               MaximizeWindowButton(colors: WindowButtonColors(iconNormal: Colors.white,iconMouseOver: Colors.blueAccent)),
               CloseWindowButton(colors: WindowButtonColors(iconNormal: Colors.white,iconMouseOver: Colors.red)),
            ],
    );
  }
}
class infoBar extends StatelessWidget{
  String currdate = (DateTime.now().year.toString())+"/" +DateTime.now().month.toString()+"/"  + DateTime.now().day.toString();

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment:Alignment.bottomCenter ,
          child: SizedBox(
            width: 95,
            height: 30,
            child: Text(
              currdate,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Audiowide',color: Colors.white,fontSize: 14),
            ),
          ),
        ),
        OnHoverText(
          child: Image.asset(
            "assets/images/discord.png",
            height : 35,
            width:  35,
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





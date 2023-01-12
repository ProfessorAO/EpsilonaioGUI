import 'package:epsilon_gui/screens/components/CustomPackages/OnHoverChange.dart';
import 'package:epsilon_gui/screens/home/main_components/sideMenu.dart';
import 'package:epsilon_gui/screens/components/TopBar_.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../components/background.dart';
import '../../components/epsilonText.dart';

class MainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:  Row(
          children: [
           
              Expanded(child: dashboard(context),),
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
          Stats(),
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
class RecentCheckouts extends StatelessWidget {
  const RecentCheckouts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.height * 0.7,
      bottom: MediaQuery.of(context).size.height * 0.3 ,
      child: SizedBox(
        width: (MediaQuery.of(context).size.width * 0.65) - (MediaQuery.of(context).size.width * 0.22) - 20,
        height: MediaQuery.of(context).size.height /1.6 ,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Baseline(
                  baseline: -4 ,
                  baselineType: TextBaseline.alphabetic,
                child: Text("Recent Checkouts",
                    style: TextStyle(fontSize: 25,
                        fontFamily: 'Audiowide',
                        color: Color.fromARGB(188, 255, 255, 255),
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
                        child: checkoutTitle(name: "Price"),
                    ),
                     checkoutTitle(name: "Shoe Name"),
                     checkoutTitle(name: "Date/Time"),
                     checkoutTitle(name: "Store"),
                     checkoutTitle(name: "Result"),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
                child: checkoutRow(),
            ),
            const Spacer(),
            Expanded(
                flex: 8,
                child: checkoutRow(),
            ),
            const Spacer(),
            Expanded(
                flex: 8,
                child: checkoutRow(),
            ),
            const Spacer(),
            Expanded(
                flex: 8,
                child: checkoutRow(),
            ),
            const Spacer(),
            Expanded(
                flex: 8,
                child: checkoutRow(),
            ),
            const Spacer(),
            Expanded(
                flex: 8,
                child: checkoutRow(),
            ),
            const Spacer(),
            Expanded(
                flex: 8,
                child: checkoutRow(),
            )
          ],
        ),
      ),
    );
  }
}
class checkoutRow extends StatelessWidget {
  const checkoutRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromRGBO(26, 25, 25, 0.6),
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
    );
  }
}
class checkoutTitle extends StatelessWidget {
  const checkoutTitle({
    super.key,
    required this.name
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(name,
      style: const TextStyle(
          color: Color.fromARGB(188, 255, 255, 255),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
class Stats extends StatelessWidget {
  const Stats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
          StatsWidget(
                          top:(MediaQuery.of(context).size.width /4.7 + 60),
                          right: 10,
                          text: "Total Spent",
                          firstcolor:const Color.fromRGBO(1, 44, 105, 0.7137254901960784),
                          secondcolor: const Color.fromRGBO(0, 102, 255, 1.0),
                          image:const AssetImage("assets/images/money.png"),),

          StatsWidget(
                          top:(MediaQuery.of(context).size.width /4.7 + 50) + ((MediaQuery.of(context).size.width /4.7) / 3) + 15,
                          right: 10,
                          text: "Checkouts",
                          firstcolor:const Color.fromRGBO(0, 89, 25, 0.7137254901960784),
                          secondcolor: const Color.fromRGBO(0, 255, 71, 1.0),
                          image:const AssetImage("assets/images/checkout.png"),),

          StatsWidget(
                          top:(MediaQuery.of(context).size.width /4.7 + 50) + ((MediaQuery.of(context).size.width /4.7) / 3) + ((MediaQuery.of(context).size.width /4.7) / 3)+ 20,
                          right: 10,
                          text: "Failures",
                          firstcolor:const Color.fromRGBO(114, 3, 3, 0.7137254901960784),
                          secondcolor: const Color.fromRGBO(255, 0, 0, 1.0),
                          image:const AssetImage("assets/images/declined.png"),),
          
      ]
    );
  }
}
class StatsWidget extends StatelessWidget {
  const StatsWidget({
    super.key,
    required this.top,
    required this.right,
    required this.text,
    required this.firstcolor,
    required this.secondcolor,
    required this.image,

  });
  final double top;
  final double right;
  final String text;
  final Color? firstcolor;
  final Color secondcolor;
  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (MediaQuery.of(context).size.width * 0.8),
      top:  top,
      right: right,
      child: InkWell(
        onTap: (){
          print("Clicked on TotalSpent");
          },
        child: Container(
          height: (MediaQuery.of(context).size.width /4.7) / 3,
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment(0.85,1),
              image: image,
              scale: MediaQuery.of(context).size.width /400 ,
            ),

            color: firstcolor,
              border: Border.all(
                width: 3,
                color: secondcolor,

              ),
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 90, 20),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: OnHoverChange(builder : (isHovered){
                final color = isHovered? Color.fromARGB(255, 15, 237, 120) : Color.fromARGB(250, 255, 255, 255);
                return Container(
                    child: Text(text,
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
      left : (MediaQuery.of(context).size.width * 0.8) ,
      top: 50,
      right: 10,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.38 ,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(26, 25, 25, 0.6),
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: TableCalendar(
          availableCalendarFormats: const {CalendarFormat.month : 'Month'},
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: Colors.white
            ),
                weekendStyle: TextStyle(
              color: Colors.white
          )
          ),
          calendarStyle:  const CalendarStyle(
            selectedDecoration: BoxDecoration(color:Color.fromARGB(188, 255, 255, 255), shape: BoxShape.circle ),
            todayDecoration:BoxDecoration(color:Color.fromARGB(188, 255, 255, 255), shape: BoxShape.circle ),
            defaultTextStyle: TextStyle(
                fontSize: 14  ,
                color: Colors.white),
            weekendTextStyle: TextStyle(
                fontSize: 14  ,
                color: Colors.white),
            outsideTextStyle: TextStyle(
                color : Colors.white,
                fontSize: 14 ),
            withinRangeTextStyle: TextStyle(
                color : Colors.white,
                fontSize: 14 ),

          ),
            headerStyle: const HeaderStyle(
              leftChevronIcon: Icon(Icons.chevron_left,color: Color.fromARGB(188, 255, 255, 255)) ,
              rightChevronIcon:Icon(Icons.chevron_right,color: Color.fromARGB(188, 255, 255, 255)) ,
              //titleTextFormatter: ,
              titleTextStyle: TextStyle(fontSize: 18  ,
                fontFamily: 'Audiowide',
                color: Color.fromARGB(188, 255, 255, 255))
            ),
            rowHeight: (MediaQuery.of(context).size.width/40)  + (MediaQuery.of(context).size.height/40) / 50 , 
            focusedDay: _focusedDay ,
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
      right :  MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.23 + 10) ,
      bottom: MediaQuery.of(context).size.height/4 ,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.22,
        height: MediaQuery.of(context).size.height /1.6,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(26, 25, 25, 0.6),
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: const Baseline(
          baselineType: TextBaseline.alphabetic,
          baseline: -7,
          child: Text("Sneaker News",
                style: TextStyle(fontSize: 25,
                    fontFamily: 'Audiowide',
                    color: Color.fromARGB(188, 255, 255, 255),
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
          top: MediaQuery.of(context).size.height * 0.98 - MediaQuery.of(context).size.height / 4.5 ,

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
                                  color: Color.fromARGB(188, 255, 255, 255),
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
                    child: releaseData()
                ),
                Spacer(),
                Expanded(
                    flex: 6,
                    child: releaseData()
                ),
                Spacer(),
                Expanded(
                    flex: 6,
                   child: releaseData()
                ),
                Spacer(),
                Expanded(
                    flex: 6,
                   child: releaseData()
                ),
                Spacer(),
                Expanded(
                    flex: 6,
                   child: releaseData()
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
class releaseData extends StatelessWidget {
  const releaseData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4.5,
      child: Container(
        color: const Color.fromARGB(255, 30, 30, 30),

      ),
    );
  }
}






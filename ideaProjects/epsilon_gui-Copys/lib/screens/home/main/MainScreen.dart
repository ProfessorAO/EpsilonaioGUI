import 'package:epsilon_gui/providers/tabbar_index_provider.dart';
import 'package:epsilon_gui/screens/components/CustomPackages/OnHoverChange.dart';
//import 'package:epsilon_gui/screens/home/main_components/sideMenu.dart';
import 'package:epsilon_gui/screens/components/TopBar_.dart';
//import 'package:epsilon_gui/screens/home/main_components/sideMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:epsilon_gui/providers/release_data_provider.dart';


class MainScreen extends StatefulWidget{
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController page = PageController();
 initState(){
    context.read<ReleasesData>().getData();
    
    }
  @override
  int selectedIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 26, 59),
      body: SafeArea(
        child:  Row(
          children: [
           //SideMenu(color: Color.fromARGB(255, 22, 33, 71),
            //),
            
            
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

          

        
          context.watch<TabbarIndex>().this_TopBar,
          Stats(),
          Releases(),
          //sneakerNews(),
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
      left: MediaQuery.of(context).size.width * 0.01,
      top: MediaQuery.of(context).size.height * 0.08,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color.fromARGB(255, 17, 26, 59),
          border:  Border.all(color: Color.fromARGB(255, 25, 36, 78),width: 3)
          ),
        
        width: MediaQuery.of(context).size.width * 0.72,
        height: MediaQuery.of(context).size.height * 0.64 ,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB((MediaQuery.of(context).size.width *0.01), 0, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Baseline(
                    baseline: (MediaQuery.of(context).size.height *0.04) ,
                    baselineType: TextBaseline.alphabetic,
                  child: Text("Recent Checkouts",
                      style: TextStyle(fontSize: 25,
                          fontFamily: 'Audiowide',
                          color: Color.fromARGB(188, 255, 255, 255),
                      )
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                //color: Color.fromRGBO(26, 25, 25, 0.6),
                //height: MediaQuery.of(context).size.height * 1,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, (MediaQuery.of(context).size.height * 0.01), 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                     checkoutTitle(name: "Price"),
                       checkoutTitle(name: "Shoe Name"),
                       checkoutTitle(name: "Date/Time"),
                       checkoutTitle(name: "Store"),
                       checkoutTitle(name: "Result"),
                    ],
                  ),
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
                          top:MediaQuery.of(context).size.height * 0.45,
                          right: 10,
                          text: "Total Spent",
                          firstcolor:Color.fromARGB(255, 0, 85, 204),
                          secondcolor: const Color.fromRGBO(0, 102, 255, 1.0),
                          image:const AssetImage("assets/images/money.png"),),

          StatsWidget(
                          top:(MediaQuery.of(context).size.height * 0.585 ),
                          right: 10,
                          text: "Checkouts",
                          firstcolor:Color.fromARGB(255, 0, 156, 44),
                          secondcolor: const Color.fromRGBO(0, 255, 71, 1.0),
                          image:const AssetImage("assets/images/checkout.png"),),
                          

          StatsWidget(
                          top:(MediaQuery.of(context).size.height * 0.72 ),
                          right: 10,
                          text: "Failures",
                          firstcolor:Color.fromARGB(255, 199, 3, 3),
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
      left: (MediaQuery.of(context).size.width * 0.75),
      top:  top,
      right: right,
      child: InkWell(
        onTap: (){},
        child: Container(
          height: MediaQuery.of(context).size.height * 0.13,
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment(0.85,1),
              image: image,
              scale: MediaQuery.of(context).size.width /400 ,
            ),
            color: firstcolor,
            borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 90, 20),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: OnHoverChange(builder : (isHovered){
                final color = isHovered? Color.fromARGB(255, 15, 237, 120) : Color.fromARGB(250, 255, 255, 255);
                return Container(
                    child: Text(text,
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width *0.015,
                          color: color,
                          fontWeight: FontWeight.w600

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
      left : (MediaQuery.of(context).size.width * 0.75) ,
      top: MediaQuery.of(context).size.height * 0.08,
      right: 10,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35 ,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 25, 36, 78),
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
          calendarStyle:  CalendarStyle(
            selectedDecoration: BoxDecoration(color:Color.fromARGB(188, 255, 255, 255), shape: BoxShape.circle,border: Border.all(width: 5.0, color: Color.fromARGB(188, 255, 255, 255)),),
            todayDecoration:BoxDecoration(color:Color.fromARGB(188, 255, 255, 255), shape: BoxShape.circle,border: Border.all(width: 5.0, color: Color.fromARGB(188, 255, 255, 255)),),
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
            headerStyle: HeaderStyle(
              titleCentered: true,
              leftChevronIcon: Icon(Icons.chevron_left,color: Color.fromARGB(188, 255, 255, 255)) ,
              rightChevronIcon:Icon(Icons.chevron_right,color: Color.fromARGB(188, 255, 255, 255)) ,
              //titleTextFormatter: ,
              titleTextStyle: TextStyle(fontSize: 20 ,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(188, 255, 255, 255),
                )
            ),
            rowHeight: (MediaQuery.of(context).size.height * 0.04) , 
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
      left :  MediaQuery.of(context).size.width * 0.02 ,
      bottom: MediaQuery.of(context).size.height *0.3 ,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.27,
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(26, 25, 25, 0.6),
            borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: const Baseline(
          baselineType: TextBaseline.alphabetic,
          baseline: -22,
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
          left: MediaQuery.of(context).size.width *0.01,
          bottom: MediaQuery.of(context).size.height * 0.02,
          child : Container(
            width: MediaQuery.of(context).size.width * 0.72,
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 17, 26, 59),
                //borderRadius: BorderRadius.all(Radius.circular(7)),
                //border: Border.all(color:Color.fromARGB(255, 25, 36, 78),width: 3),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width *0.01, 0, 0, 0),
                  child: Align(
                    alignment:Alignment.topLeft ,
                    child: Baseline(
                      baseline: MediaQuery.of(context).size.height *0.035 ,
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
      
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: releaseData(index: 0,)),
                      SizedBox(width:MediaQuery.of(context).size.height * 0.01 ,),
                      Expanded(
                      flex: 6,
                      child: releaseData(index: 1,)),
                      SizedBox(width:MediaQuery.of(context).size.height *  0.01 ,),
                      Expanded(
                      flex: 6,
                      child: releaseData(index: 2,)),
                      SizedBox(width:MediaQuery.of(context).size.height * 0.01,),
                      Expanded(
                      flex: 6,
                      child: releaseData(index: 3,)),
                      SizedBox(width:MediaQuery.of(context).size.height * 0.01 ,),
                      Expanded(
                      flex: 6,
                      child: releaseData(index: 4,)),
                      SizedBox(width:MediaQuery.of(context).size.height *  0.01 ,),
                      Expanded(
                      flex: 6,
                      child: releaseData(index: 5,))
                    
                   
                  ],
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
    required this.index,
  });
  final int index ;
  @override
  Widget build(BuildContext context) {
    //List<Map<String,String>> data  = context.read<ReleasesData>().releasesData;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1975,
      child: Container(
         decoration: BoxDecoration(
          color:const Color.fromARGB(255, 25, 36, 78) ,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                 borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5)),
                  ),
              width: double.infinity,
              child: SvgPicture.asset('assets/images/result-min 1.svg',
                height: 90,
                color: Color.fromARGB(255, 15, 237, 120)),
              
              ) ,
            Text(context.read<ReleasesData>().releasesData[index]['name']!,style: TextStyle(color: Colors.white),),
            Spacer(),
            Text(context.read<ReleasesData>().releasesData[index]['date']!,style: TextStyle(color: Colors.white),),
            Spacer(),
            Text(context.read<ReleasesData>().releasesData[index]['price']!,style: TextStyle(color: Colors.white),)
            ],)

      ),
    );
  }
}






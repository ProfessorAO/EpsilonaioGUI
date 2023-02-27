import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecentCheckoutProvider with ChangeNotifier {
  List<DataRow> checkout_list = [];

  List<DataRow> get checkoutList => checkout_list;

  void createRecentCheckoutRow(
      String price, String product, String store, String profile, String date) {
    checkout_list.add(DataRow(cells: [
      DataCell(new SvgPicture.asset(
        'assets/images/result-min 1.svg',
        height: 30,
        color: Color.fromARGB(255, 15, 237, 120),
      )),
      DataCell(Text(
        price,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 13,
        ),
      )),
      DataCell(Text(
        product,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 13,
        ),
      )),
      DataCell(Text(
        store,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 13,
        ),
      )),
      DataCell(Text(
        profile,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 13,
        ),
      )),
      DataCell(Text(
        date,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 13,
        ),
      )),
    ]));
  }
}

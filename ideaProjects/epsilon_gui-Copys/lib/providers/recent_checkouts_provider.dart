import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecentCheckoutProvider with ChangeNotifier {
  static final RecentCheckoutProvider _instance =
      RecentCheckoutProvider._internal();
  RecentCheckoutProvider._internal();
  List<DataRow> checkout_list = [];

  List<DataRow> get checkoutList => checkout_list;
  static RecentCheckoutProvider get instance => _instance;

  void createRecentCheckoutRow(
      String price, String product, String store, String profile, String date) {
    checkout_list.add(RecentCheckoutRow(
            date: date,
            price: price,
            product: product,
            store: store,
            profile: profile)
        .toDataRow());
    notifyListeners();
  }
}

class RecentCheckoutRow {
  final String price;
  final String product;
  final String store;
  final String profile;
  final String date;

  const RecentCheckoutRow({
    required this.price,
    required this.product,
    required this.store,
    required this.profile,
    required this.date,
  });

  DataRow toDataRow() {
    return DataRow(cells: [
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
    ]);
  }
}

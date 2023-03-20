import 'package:epsilon_gui/providers/profile_provider.dart';
import 'package:epsilon_gui/screens/components/TopBar_.dart';
import 'package:epsilon_gui/providers/tasks_list_provider.dart';
import 'package:epsilon_gui/providers/task_inputs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ready/ready.dart';

class ProfileGroupProvider with ChangeNotifier {
  String profileGrouo_name = "";
  List<DataRow> all_profiles_data = [];

  List<DataRow> getProfileTableData(BuildContext context) {
    List<DataRow> data = [];
    DataRow dataRow_instance;
    var list = context.read<ProfileProvider>().all_profile_instances;
    for (ProfileInstance instance in list) {
      bool check = (!instance.checked);
      data.add(DataRow(
          onSelectChanged: ((value) {
            check = (value!);
            notifyListeners();
          }),
          selected: check,
          cells: [
            DataCell(Text(
              instance.ProfileID.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
            )),
            DataCell(Text(
              instance.cardName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
            )),
            DataCell(Text(
              instance.cardNumber,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
            )),
            DataCell(Text(
              instance.address,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
            )),
            DataCell(Text(
              instance.phone,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
            )),
          ]));
    }
    return data;
  }

//late int profileIds
}

// Widget createTaskGroup(BuildContext context) {
//     return Container(
//       child: TextButton(
//         style: TextButton.styleFrom(
//             foregroundColor: Colors.white,
//             minimumSize:
//                 Size(double.infinity, MediaQuery.of(context).size.height * 0.08)
//             //padding: const EdgeInsets.all(16.0),

//             ),
//         onPressed: () {
//           final snackBar = SnackBar(
//             duration: const Duration(seconds: 1),
//             backgroundColor: Colors.green,
//             content: Text('$taskgroup_name Used'),
//             action: SnackBarAction(
//               label: '',
//               onPressed: () {},
//             ),
//           );

//           ScaffoldMessenger.of(context).showSnackBar(snackBar);
//           context.read<TasksInputs>().setproduct(taskproduct);
//           context.read<TasksInputs>().setsize(tasksize);
//           context.read<TasksInputs>().setprofile(taskprofile);
//           context.read<TasksInputs>().setstore(taskstore);
//           context.read<TasksInputs>().setNum_of_tasks(tasknum);
//           context.read<TasksLists>().removeAllTasks();
//           context.read<TasksLists>().addTask(
//               context.read<TasksInputs>().tasks_num,
//               context.read<TasksInputs>().task_store,
//               context.read<TasksInputs>().product,
//               context.read<TasksInputs>().task_profile,
//               context.read<TasksInputs>().task_size,
//               context);
//         },
//         onLongPress: () {},
//         child: Row(
//           children: [
//             Align(
//                 alignment: Alignment.center,
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 25,
//                       height: 10,
//                       color: Colors.black,
//                       child: Text(
//                         tasknum.toString(),
//                         style: TextStyle(fontSize: 8),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 3,
//                     ),
//                     Container(
//                       width: 25,
//                       height: 10,
//                       color: Colors.black,
//                       child: Text(
//                         checkouts.toString(),
//                         style: TextStyle(fontSize: 8),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 3,
//                     ),
//                     Container(
//                       width: 25,
//                       height: 10,
//                       color: Colors.black,
//                       child: Text(
//                         fails.toString(),
//                         style: TextStyle(fontSize: 8),
//                       ),
//                     ),
//                   ],
//                 )),
//             Spacer(),
//             Align(
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   taskgroup_name,
//                   style: const TextStyle(fontSize: 17),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }

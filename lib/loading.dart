import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, snapshot) => Scaffold(
              body: Center(child: Lottie.asset("assets/IC.json")),
            ));
  }
}

// class _Mission extends State<Mission> {
//   TextEditingController Mission_Name = TextEditingController();
//   TimeOfDay Mission_Time = TimeOfDay.now();
//   CollectionReference NewMission = FirebaseFirestore.instance
//       .collection("${DateFormat('EEEE, d MMM, yyyy').format(DateTime.now())}");
//   CollectionReference missionComplete = FirebaseFirestore.instance
//       .collection("${DateFormat('d MMM, yyyy').format(DateTime.now())}");
//
//   Future<void> addMission() {
//     return NewMission.add({
//       'MissionName': Mission_Name.text,
//       'Hour': Mission_Time.hour,
//       'Minute': Mission_Time.minute,
//     })
//         .then((value) => print("Mission add"))
//         .catchError((error) => print("Failed to add mission: $error"));
//   }
//
//   Future<void> MissionComplete(int Mission_size , String? MissionName) {
//     return missionComplete
//         .add({
//       'MissionName': MissionName,
//       'MissionLength': Mission_size,
//       'at':Timestamp.now(),
//     })
//         .then((value) => print("Mission complete"))
//         .catchError((error) => print("Failed to complete mission: $error"));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var ScaffoldKey = GlobalKey<ScaffoldState>();
//     return Scaffold(
//       key: ScaffoldKey,
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: NestedScrollView(
//           headerSliverBuilder: (context, innerBoxIsScrolled) =>[
//             SliverToBoxAdapter(
//               child: Container(
//                 padding: EdgeInsets.all(15),
//                 child: Column(
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Shimmer.fromColors(
//                               highlightColor: Color.fromARGB(255, 1, 137, 121),
//                               baseColor: Colors.black,
//                               child: Text_App(
//                                   string:
//                                   "${DateFormat('EEEE, d MMM, yyyy').format(DateTime.now())}",
//                                   bold: true,
//                                   size: 20,
//                                   color: Color.fromARGB(255, 1, 137, 121)),
//                             ),
//                             Spacer(),
//                             defaultIconButton(
//                                 Onpressed: () async {
//                                   await showTimePicker(
//                                       context: context,
//                                       initialTime: TimeOfDay.now(),
//                                       initialEntryMode: TimePickerEntryMode.dial);
//                                 },
//                                 icon: Icons.watch_later_outlined),
//                             defaultIconButton(
//                                 Onpressed: () async {
//                                   await showDatePicker(
//                                       context: context,
//                                       initialDate: DateTime.now(),
//                                       firstDate: DateTime(2023),
//                                       lastDate: DateTime(2025));
//                                 },
//                                 icon: Icons.date_range_sharp),
//                             defaultIconButton(
//                                 Onpressed: () async {
//                                   await FirebaseAuth.instance.signOut();
//                                   PageTransition(
//                                       child: User_login(),
//                                       duration: Duration(
//                                           milliseconds: 500),
//                                       type:
//                                       PageTransitionType.fade);
//                                 },
//                                 icon: Icons.exit_to_app)
//                           ],
//                         ),
//                         Divider(),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           flex: 3,
//                           child: Form(
//                             child: defaultTextFormfield(
//                               LabelHint: "Mission name",
//                               Hint: "Mission name",
//                               LabelHintColor: Colors.black,
//                               prefix_color: Colors.black,
//                               Control: Mission_Name,
//                               Type: TextInputType.text,
//                               prefix: Icons.drive_file_rename_outline,
//                             ),
//                           ),
//                         ),
//                         Gap(10),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Mission Time",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               Gap(5),
//                               Container(
//                                 height: 57,
//                                 width: MediaQuery.sizeOf(context).width,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(color: Colors.grey)),
//                                 child: Container(
//                                   padding: EdgeInsets.all(10),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       InkWell(
//                                         onTap: () async {
//                                           final TimeOfDay? timeOfDay =
//                                           await showTimePicker(
//                                               context: context,
//                                               initialTime: Mission_Time,
//                                               initialEntryMode:
//                                               TimePickerEntryMode.dial);
//                                           if (timeOfDay != null) {
//                                             setState(() {
//                                               Mission_Time = timeOfDay;
//                                             });
//                                           }
//                                         },
//                                         child: Icon(Icons.alarm),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: Shimmer.fromColors(
//                             highlightColor: Color.fromARGB(255, 1, 137, 121),
//                             baseColor: Color.fromARGB(255, 0, 77, 66),
//                             child: MaterialButton(
//                               onPressed: () {
//                                 if (Mission_Name.text.isNotEmpty)
//                                   addMission();
//                                 else
//                                   defaultFlusbar(
//                                       message: "You must write the mission name",
//                                       Title: "Failed",
//                                       icon: Icons.warning_amber,
//                                       Second: 3)
//                                       .show(context);
//                               },
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Icon(Icons.add_circle_outline),
//                                   Gap(5),
//                                   Text(
//                                     "Add a new mission",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Shimmer.fromColors(
//                             highlightColor: Color.fromARGB(255, 1, 137, 121),
//                             baseColor: Color.fromARGB(255, 0, 77, 66),
//                             child: MaterialButton(
//                               onPressed: () async {
//                                 await Navigator.push(
//                                     context,
//                                     PageTransition(
//                                         child: Mission_Complete(),
//                                         duration: Duration(
//                                             milliseconds: 500),
//                                         type:
//                                         PageTransitionType.fade)
//                                 );
//                               },
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     "Mission complete >>>",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Divider(),
//
//                   ],
//                 ),
//               ),
//
//             )
//           ],
//           body: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection(
//                 "${DateFormat('EEEE, d MMM, yyyy').format(DateTime.now())}")
//                 .snapshots(),
//             builder: (context, AsyncSnapshot snapshot) {
//               if (!snapshot.hasData || snapshot.hasError)
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: Color.fromARGB(255, 1, 137, 121),
//                   ),
//                 );
//               else {
//                 final Mission_Information = snapshot.data!.docs;
//                 return ListView.builder(
//                   itemBuilder: (context, index) => Slidable(
//                     endActionPane:
//                     ActionPane(motion: ScrollMotion(), children: [
//                       SlidableAction(
//                         onPressed: (context) async {
//                           await FirebaseFirestore.instance
//                               .collection(
//                               "${DateFormat('EEEE, d MMM, yyyy').format(DateTime.now())}")
//                               .doc(Mission_Information[index].id)
//                               .delete();
//                         },
//                         icon: Icons.delete,
//                         foregroundColor: Colors.red,
//                         label: "Delete",
//                       ),
//                       SlidableAction(
//                         onPressed: (context) async {
//                           MissionComplete(Mission_Information.length,Mission_Information[index]["MissionName"]);
//                           await FirebaseFirestore.instance
//                               .collection(
//                               "${DateFormat('EEEE, d MMM, yyyy').format(DateTime.now())}")
//                               .doc(Mission_Information[index].id)
//                               .delete();
//                         },
//                         icon: Icons.done_rounded,
//                         foregroundColor: Colors.green,
//                         label: "Complete",
//                       ),
//                     ]),
//                     child: Container(
//                       padding: const EdgeInsets.all(10),
//                       margin: EdgeInsets.all(10),
//                       height: 80,
//                       width: MediaQuery.sizeOf(context).width,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           gradient: LinearGradient(colors: [
//                             Color.fromARGB(255, 0, 104, 91),
//                             Color.fromARGB(255, 2, 188, 166)
//                           ])),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text_App(
//                               string:
//                               "${Mission_Information[index]["MissionName"]}",
//                               color: Colors.white),
//                           SlideCountdownSeparated(
//                             duration: Duration(
//                               hours: Mission_Information[index]["Hour"] -
//                                   TimeOfDay.now().hour,
//                               minutes: Mission_Information[index]
//                               ["Minute"] -
//                                   TimeOfDay.now().minute,
//                             ),
//                             separatorType: SeparatorType.symbol,
//                             style: TextStyle(
//                                 fontFamily: "Manrope",
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                             separatorStyle: const TextStyle(
//                                 color: Colors.white, fontSize: 20),
//                             decoration:
//                             BoxDecoration(color: Colors.transparent),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   itemCount: Mission_Information.length,
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_appliction/mission/mission.dart';
import '../components/constants.dart';

class Mission_Complete extends StatefulWidget {
  @override
  State<Mission_Complete> createState() => _Mission_CompleteState();
}

class _Mission_CompleteState extends State<Mission_Complete> {
  List<QueryDocumentSnapshot> Data = [];
  int Missions_num = 0, a = 0;
  double b = 0;

  MissionComplete() async {
    QuerySnapshot Mission = await FirebaseFirestore.instance
        .collection("${DateFormat('EEEE, d MMM, yyyy').format(DateTime.now())}")
        .get();
    QuerySnapshot MissionComplete = await FirebaseFirestore.instance
        .collection("${DateFormat('d MMM, yyyy').format(DateTime.now())}")
        .orderBy("at")
        .get();
    Data.addAll(MissionComplete.docs);
    Missions_num = Mission.docs.length;
    b = (Data.length / (Missions_num + Data.length) * 100);
    a = b.toInt();
    setState(() {});
  }

  @override
  void initState() {
    MissionComplete();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 500)),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 0, 104, 91),
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: Shimmer.fromColors(
                    highlightColor: Color.fromARGB(255, 1, 137, 121),
                    baseColor: Colors.black,
                    child: Text_App(
                        string: "Mission Complete",
                        bold: true,
                        size: 17,
                        color: Color.fromARGB(255, 1, 137, 121)),
                  ),
                  leading: IconButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          PageTransition(
                              child: Mission(),
                              duration: Duration(milliseconds: 500),
                              type: PageTransitionType.fade));
                    },
                    icon: Icon(Icons.navigate_before),
                    color: Colors.black,
                  ),
                ),
                body: SafeArea(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height / 5,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 88, 79),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text_App(
                                        string: "I've completed",
                                        bold: true,
                                        color: Colors.white,
                                        size: 25),
                                    Text_App(
                                        string:
                                            "${Data.length} / ${Missions_num + Data.length} of my missions",
                                        bold: true,
                                        color: Colors.white,
                                        size: 22),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CircularPercentIndicator(
                                      animation: true,
                                      animationDuration: 100,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      radius: 60.0,
                                      lineWidth: 10,
                                      percent: b / 100,
                                      backgroundWidth: 5,
                                      center: Text_App(
                                          string: "${a}% ",
                                          size: 20,
                                          color: Colors.white,
                                          bold: true),
                                      progressColor: Colors.white,
                                      backgroundColor: Colors.grey.shade300,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) => Gap(10),
                            itemCount: Data.length,
                            itemBuilder: (context, index) => ListTile(
                              leading: Shimmer.fromColors(
                                  highlightColor:
                                  Color.fromARGB(255, 1, 137, 121),
                                  baseColor: Colors.black,
                                  child: Icon(Icons.check_circle_outline,color: Colors.black,)),
                              title: Shimmer.fromColors(
                                highlightColor:
                                    Color.fromARGB(255, 1, 137, 121),
                                baseColor: Colors.black,
                                child: Text_App(
                                    string: "${Data[index]["MissionName"]}",
                                    bold: true,
                                    size: 15,
                                    color: Color.fromARGB(255, 1, 137, 121)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }
}

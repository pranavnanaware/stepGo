import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:step/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:step/utils/firebase_utils.dart';
import 'package:step/utils/point_system.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  var db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String _status = '?', _steps = '?';
  int steps = 0;
  int level = 1;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    storeData(_steps);
    setState(() {
      _steps = event.steps.toString();
      steps = event.steps;
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    setState(() {
      _status = 'Pedestrian Status not available';
    });
  }

  void onStepCountError(error) {
    setState(() {
      _steps = '0';
    });
  }

  Future<void> initPlatformState() async {
    if (await Permission.activityRecognition.request().isGranted) {
      _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
      _pedestrianStatusStream
          .listen(onPedestrianStatusChanged)
          .onError(onPedestrianStatusError);
      _stepCountStream = Pedometer.stepCountStream;
      _stepCountStream.listen(onStepCount).onError(onStepCountError);
    } else {}
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: db.collection("users").doc(user?.email).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                shape: const Border(
                  bottom: BorderSide(color: secondaryColor),
                ),
                backgroundColor: primaryColor,
                title: Text(
                  "Today",
                  style: GoogleFonts.poppins(color: whiteColor),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, right: 15, left: 15),
                      child: Text(
                        _steps,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                    ),
                    Text(
                      "Total Steps",
                      style: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 100),
                    Text(
                      caluclateCoins(steps, level).toString(),
                      style: GoogleFonts.poppins(
                        height: 0.9,
                        color: tertiaryColor,
                        fontSize: 90,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "coins by steps",
                      style: GoogleFonts.poppins(
                        color: tertiaryColor,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: StepProgressIndicator(
                        totalSteps: maxCoin(level),
                        currentStep: caluclateCoins(steps, level).toInt(),
                        size: 8,
                        padding: 0,
                        selectedColor: tertiaryColor,
                        unselectedColor: secondaryColor,
                        roundedEdges: const Radius.circular(10),
                        selectedGradientColor: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [tertiaryColor, Colors.lightBlue],
                        ),
                        unselectedGradientColor: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [primaryColor, secondaryColor],
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      height: 80,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        border: Border.all(
                          color: secondaryColor,
                        ),
                        color: primaryColor,
                        // boxShadow: const <BoxShadow>[
                        //   BoxShadow(
                        //     color: secondaryColor,
                        //     offset: Offset(6, 6),
                        //     blurRadius: 25,
                        //   ),
                        //   BoxShadow(
                        //     color: secondaryColor,
                        //     offset: Offset(-6, -6),
                        //     blurRadius: 25,
                        //   ),
                        //],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, left: 15.0),
                            child: Text(
                              "Level ${snapshot.data!.data()["level"]}",
                              style: GoogleFonts.poppins(
                                  color: tertiaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 8),
                            child: Text(
                              levelMessage(level),
                              style: GoogleFonts.poppins(
                                color: whiteColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            border: Border.all(
                              color: secondaryColor,
                            ),
                            color: primaryColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 20),
                                child: Text(
                                  "Calories",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: whiteColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  calculateCalories(steps),
                                  style: GoogleFonts.poppins(
                                      fontSize: 30, color: whiteColor),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 50),
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            border: Border.all(
                              color: secondaryColor,
                            ),
                            color: primaryColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 20),
                                child: Text(
                                  "Distance Walked",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: whiteColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  " ${calculateDistance(steps)} Km ",
                                  style: GoogleFonts.poppins(
                                      fontSize: 20, color: whiteColor),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

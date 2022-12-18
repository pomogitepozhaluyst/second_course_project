import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/network/api_client.dart';
import 'package:second_course_project/training_class.dart';
import 'package:second_course_project/web/user_web.dart';

class TrainingScreenWeb extends StatefulWidget {
  final Training currentTraining;
  final Function(UserWeb) tmp;
  final UserWeb currentUser;
  const TrainingScreenWeb({super.key, required this.currentUser, required this.currentTraining, required this.tmp});
  @override
  State<TrainingScreenWeb> createState() => TrainingScreenWebState();
}

class TrainingScreenWebState extends State<TrainingScreenWeb> {
  int iteratorTraining = 0;

  @override
  void initState() {
    super.initState();
  }

  int currentTime = 0;
  int startTime = 0;
  bool timer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UserDecoration.mainColor,
      appBar: AppBar(
        title: Text(
          widget.currentTraining.name,
          style: TextStyle(
            color: UserDecoration.textTitleColor,
            fontSize: UserDecoration.textSize,
            fontFamily: UserDecoration.textStyle,
          ),
        ),
        backgroundColor: UserDecoration.secondColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => {
              Navigator.pop(context),
            },
            icon: Icon(
              Icons.arrow_back,
              color: UserDecoration.iconColor,
            ),
          )
        ],
      ),
      body: timer ? getBodyWithTimer() : getBodyWithoutTimer(),
      floatingActionButton: (!timer)
          ? FloatingActionButton(
              onPressed: nextIterationTraining,
              backgroundColor: UserDecoration.secondColor,
              child: Icon(
                Icons.navigate_next,
                color: UserDecoration.iconColor,
              ),
            )
          : const Center(),
    );
  }

  void nextIterationTraining() {
    if (iteratorTraining == widget.currentTraining.complexTraining.length - 1) {
      training(widget.currentTraining.difficulty);
      Navigator.pop(context);
      widget.tmp(widget.currentUser);
    } else {
      setState(() {
        iteratorTraining++;
        if (widget.currentTraining.complexTraining[iteratorTraining]['timer'] != 0) {
          timer = true;
          startTime = widget.currentTraining.complexTraining[iteratorTraining]['timer'];
          currentTime = widget.currentTraining.complexTraining[iteratorTraining]['timer'];
          startTimer();
        } else {
          startTime = 0;
          timer = false;
        }
      });
      //timer = false;
    }
  }

  Future<void> training(int addExp) async {
    widget.currentUser.exp += addExp;
    while (widget.currentUser.needExpToNextLevel <= widget.currentUser.exp) {
      updateLevel();
    }
    final apiClient = ApiClient();
    await apiClient.updateUser(widget.currentUser);
  }

  void startTimer() {
    try {
      CountdownTimer countDownTimer = CountdownTimer(
        Duration(seconds: startTime),
        const Duration(seconds: 1),
      );

      var sub = countDownTimer.listen(null);
      sub.onData((duration) {
        setState(() {
          currentTime = startTime - duration.elapsed.inSeconds;
        });
      });

      sub.onDone(() {
        print("Done");
        sub.cancel();
        timer = false;
      });
    } finally {}
  }

  void updateLevel() {
    widget.currentUser.exp -= widget.currentUser.needExpToNextLevel;
    widget.currentUser.needExpToNextLevel *= 2;
    widget.currentUser.level += 1;
  }

  Center getBodyWithTimer() {
    return Center(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.currentTraining.complexTraining[iteratorTraining]['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: UserDecoration.textSubStrColor,
                  fontFamily: UserDecoration.textStyle,
                  fontSize: UserDecoration.textSize,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                currentTime.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: UserDecoration.textSubStrColor,
                  fontFamily: UserDecoration.textStyle,
                  fontSize: UserDecoration.textSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Center getBodyWithoutTimer() {
    return Center(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.currentTraining.complexTraining[iteratorTraining]['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: UserDecoration.textSubStrColor,
                  fontFamily: UserDecoration.textStyle,
                  fontSize: UserDecoration.textSize,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

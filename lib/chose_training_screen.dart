import 'package:flutter/material.dart';
import 'package:second_course_project/User.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/training_class.dart';
import 'package:second_course_project/training_screen.dart';

class ChoseTrainingScreen extends StatefulWidget {
  final List<Training> allTraining;
  final Function() tmp;
  final User currentUser;
  const ChoseTrainingScreen({super.key, required this.currentUser, required this.allTraining, required this.tmp});
  @override
  State<ChoseTrainingScreen> createState() => ChoseTrainingScreenState();
}

class ChoseTrainingScreenState extends State<ChoseTrainingScreen> {
  late List<InkWell> shownAllTraining;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UserDecoration.mainColor,
      appBar: AppBar(
        title: Text(
          "Выбирете тренировку",
          style: TextStyle(
            fontFamily: UserDecoration.textStyle,
            color: UserDecoration.textTitleColor,
            fontSize: UserDecoration.textSize,
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
      body: ListView.builder(
          itemCount: widget.allTraining.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => goTraining(index),
              child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: UserDecoration.secondColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(
                            40,
                          ),
                          topRight: Radius.circular(
                            40,
                          ),
                        ),
                        child: widget.allTraining[index].imageTraining,
                      ),
                      Text(
                        widget.allTraining[index].name,
                        style: TextStyle(
                          fontFamily: UserDecoration.textStyle,
                          color: UserDecoration.textSubStrColor,
                          fontSize: UserDecoration.textSize,
                        ),
                      ),
                    ],
                  )),
            );
          }),
    );
  }

  void goTraining(int index) {
    setState(() {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrainingScreen(
              currentUser: widget.currentUser, currentTraining: widget.allTraining[index], tmp: widget.tmp),
        ),
      );
    });
  }
}

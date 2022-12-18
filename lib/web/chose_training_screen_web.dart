import 'package:flutter/material.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/training_class.dart';
import 'package:second_course_project/web/training_screen_web.dart';
import 'package:second_course_project/web/user_web.dart';

class ChoseTrainingScreenWeb extends StatefulWidget {
  final List<Training> allTraining;
  final Function(UserWeb) tmp;
  final UserWeb currentUser;
  const ChoseTrainingScreenWeb({super.key, required this.currentUser, required this.allTraining, required this.tmp});
  @override
  State<ChoseTrainingScreenWeb> createState() => ChoseTrainingScreenWebState();
}

class ChoseTrainingScreenWebState extends State<ChoseTrainingScreenWeb> {
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
          "Выберите тренировку",
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
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                color: UserDecoration.secondColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            widget.allTraining[index].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: UserDecoration.textStyle,
                              color: UserDecoration.textSubStrColor,
                              fontSize: UserDecoration.textSize,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            'Сложность: ${getDifficultyTraining(widget.allTraining[index].difficulty)}',
                            style: TextStyle(
                              fontFamily: UserDecoration.textStyle,
                              color: UserDecoration.textSubStrColor,
                              fontSize: UserDecoration.textSize,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () => goTraining(index),
                ),
              ),
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
          builder: (context) => TrainingScreenWeb(
              currentUser: widget.currentUser, currentTraining: widget.allTraining[index], tmp: widget.tmp),
        ),
      );
    });
  }

  String getDifficultyTraining(int difficulty) {
    String dif = '';
    switch (difficulty) {
      case 1:
        dif = 'легко';
        break;
      case 2:
        dif = 'Нормальная';
        break;
      case 7:
        dif = 'Сложная';
        break;
    }
    return dif;
  }
}

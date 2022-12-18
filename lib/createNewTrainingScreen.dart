/*import 'package:flutter/material.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/exercise.dart';
import 'package:second_course_project/training_class.dart';
import 'package:second_course_project/training_screen.dart';
import 'package:second_course_project/user.dart';

class ChoseTrainingScreen extends StatefulWidget {
  final List<Training> allTraining;
  final Function() tmp;
  final User currentUser;
  const ChoseTrainingScreen({super.key, required this.currentUser, required this.allTraining, required this.tmp});
  @override
  State<ChoseTrainingScreen> createState() => ChoseTrainingScreenState();
}

class ChoseTrainingScreenState extends State<ChoseTrainingScreen> {
  late List<Card> shownAllExercise;
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
          "Создание тренировки",
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
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
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

  Card getExercise(Exercise exercise) {
    return Card(
      child: Row(
        children: [
          Checkbox(
            value: exercise.isActive,
            onChanged: (value) {
              exercise.isActive = !exercise.isActive;
            },
            activeColor: UserDecoration.secondColor,
            shape: const CircleBorder(),
          ),
          Expanded(
            flex: 7,
            child: Text(
              'Использовать оригинальные цвета при входе?',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'montserrat',
                color: UserDecoration.textSubStrColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/

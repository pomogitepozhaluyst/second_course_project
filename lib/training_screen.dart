import 'package:flutter/material.dart';
import 'package:second_course_project/User.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/training_class.dart';
import 'package:sqflite/sqflite.dart';

class TrainingScreen extends StatefulWidget {
  final Training currentTraining;
  final Function() tmp;
  final User currentUser;
  const TrainingScreen({super.key, required this.currentUser, required this.currentTraining, required this.tmp});
  @override
  State<TrainingScreen> createState() => TrainingScreenState();
}

class TrainingScreenState extends State<TrainingScreen> {
  int iteratorTraining = 0;

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
      body: Center(
        child: Text(
          widget.currentTraining.complexTraining[iteratorTraining],
          style: TextStyle(
            color: UserDecoration.textSubStrColor,
            fontFamily: UserDecoration.textStyle,
            fontSize: UserDecoration.textSize,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: nextIterationTraining,
        backgroundColor: UserDecoration.secondColor,
        child: Icon(
          Icons.navigate_next,
          color: UserDecoration.iconColor,
        ),
      ),
    );
  }

  void nextIterationTraining() {
    if (iteratorTraining == widget.currentTraining.complexTraining.length - 1) {
      training(widget.currentTraining.giveExp);
      Navigator.pop(context);
      widget.tmp();
    } else {
      setState(() {
        iteratorTraining++;
      });
    }
  }

  Future<void> training(int addExp) async {
    widget.currentUser.exp += addExp;
    while (widget.currentUser.needExpToNextLevel <= widget.currentUser.exp) {
      updateLevel();
    }
    Database db = await openDatabase(
      'resoursec/data_base.db',
    );
    await db.update(
      'users',
      {
        'id': widget.currentUser.id,
        'name': widget.currentUser.name,
        'password': widget.currentUser.password,
        'level': widget.currentUser.level,
        'exp': widget.currentUser.exp,
        'needExpToNextLevel': widget.currentUser.needExpToNextLevel,
      },
      // Ensure that the Dog has a matching id.
      where: 'id = ${widget.currentUser.id}',
    );
    await db.close();
  }

  void updateLevel() {
    widget.currentUser.exp -= widget.currentUser.needExpToNextLevel;
    widget.currentUser.needExpToNextLevel *= 2;
    widget.currentUser.level += 1;
  }
}

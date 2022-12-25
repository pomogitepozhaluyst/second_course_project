import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:second_course_project/account_screen.dart';
import 'package:second_course_project/chose_training_screen.dart';
import 'package:second_course_project/data_popup_menu_item.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/pop_up_item_data.dart';
import 'package:second_course_project/training_class.dart';
import 'package:second_course_project/user.dart';
import 'package:sqflite/sqflite.dart';

class MyHomePage extends StatefulWidget {
  final User currentUser;
  final void Function() getNormalColor;
  final bool isUsedOriginalColor;
  const MyHomePage({
    super.key,
    required this.currentUser,
    required this.getNormalColor,
    required this.isUsedOriginalColor,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Training> allTraining = [];
  late Training firstTraining;
  late Training handTraining;
  late Training footTraining;
  late Training staminaTraining;
  late Training extremeTraining;
  late User currentUser = User(id: 0, level: 0, name: '', exp: 0, needExpToNextLevel: 0, password: '');
  void helpGetTraining() async {
    allTraining = await getTraining(widget.currentUser.id);
  }

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '0', _steps = '0', _dropSteps = '0', _prevDropSteps = '0';
  late StreamSubscription<StepCount> _stepStreamSubscription;

  @override
  void initState() {
    super.initState();
    setState(() {
      //getUserColorsFromLocalDataBase();
      helpGetTraining();
      currentUser = widget.currentUser;
      initPlatformState();
      getDropSteps();
      getSteps();
    });
  }

  Future<void> getDropSteps() async {
    Database db = await openDatabase(
      'resoursec/data_base.db',
    );
    List<Map> dropSteps2 = await db.query('pedometer', where: 'id = 1');
    _dropSteps = await dropSteps2[0]['steps'];
    print(_dropSteps);
    await db.close();
  }

  Future<void> dropCounter() async {
    _dropSteps = _steps;
    Database db = await openDatabase(
      'resoursec/data_base.db',
    );
    await db.update(
      'pedometer',
      {'id': 1, 'steps': _steps},
      where: 'id = 1',
    );
    await db.close();
  }

  bool isNumeric(String s) {
    if (s == '') {
      return false;
    }
    return double.tryParse(s) != null;
  }

  String getSteps() {
    if (isNumeric(_steps)) {
      return (int.parse(_steps) - int.parse(_dropSteps)).toString();
    } else {
      return 'Шагомер не работает';
    }
  }

  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps.toString();
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
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  Future<void> initPlatformState() async {
    _pedestrianStatusStream = await Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream.listen(onPedestrianStatusChanged).onError(onPedestrianStatusError);

    _stepCountStream = await Pedometer.stepCountStream;
    _stepStreamSubscription = await _stepCountStream.listen(onStepCount); //.onError(onStepCountError);
    _stepStreamSubscription.onError(onStepCountError);

    if (!mounted) return;
  }

  Future<void> getUserColorsFromLocalDataBase() async {
    if (!widget.isUsedOriginalColor) {
      Database db = await openDatabase(
        'resoursec/data_base.db',
      );
      List<Map> color = await db.query('userColor', where: 'id = ${widget.currentUser.id}');
      setState(() {
        UserDecoration.mainColor = Color(color[0]['mainColor']);
        UserDecoration.secondColor = Color(color[0]['secondColor']);
        UserDecoration.textTitleColor = Color(color[0]['textTitleColor']);
        UserDecoration.textSubStrColor = Color(color[0]['textSubStrColor']);
        UserDecoration.iconColor = Color(color[0]['iconColor']);
        UserDecoration.textStyle = color[0]['textStyle'];
      });

      await db.close();
    }
  }

  void goChoseTraining() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ChoseTrainingScreen(currentUser: currentUser, allTraining: allTraining, tmp: updateScreen),
        ),
      );
    });
  }

  void goAccount() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AccountScreen(currentUser: currentUser, updateMainScreen: updateScreen),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UserDecoration.mainColor,
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: UserDecoration.iconColor),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
            child: Center(
              child: Text(
                currentUser.level.toString(),
                style: TextStyle(
                  color: UserDecoration.iconColor,
                  fontSize: 20,
                  fontFamily: UserDecoration.textStyle,
                ),
              ),
            ),
          ),
        ),
        actions: [
          PopupMenuButton<PopupMenuItemData>(
            icon: Icon(Icons.more_vert, color: UserDecoration.iconColor),
            color: UserDecoration.secondColor,
            onSelected: (item) => item.onClicked(),
            itemBuilder: (context) => [
              DataPopupMenuItem(
                data: PopupMenuItemData(
                  title: Text(
                    'В личный кабинет',
                    style: TextStyle(color: UserDecoration.textSubStrColor),
                  ),
                  icon: Icons.account_circle,
                  onClicked: goAccount,
                ),
              ),
              DataPopupMenuItem(
                data: PopupMenuItemData(
                  title: Text(
                    'Выйти',
                    style: TextStyle(color: UserDecoration.textSubStrColor),
                  ),
                  icon: Icons.arrow_back,
                  onClicked: () {
                    setState(() {
                      UserDecoration.returnDefaultStyle();
                    });
                    widget.getNormalColor();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
        title: Text(
          currentUser.name,
          style: TextStyle(
            color: UserDecoration.textTitleColor,
            fontSize: UserDecoration.textSize,
            fontFamily: UserDecoration.textStyle,
          ),
        ),
        backgroundColor: UserDecoration.secondColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                color: UserDecoration.secondColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  onTap: () {
                    setState(() {
                      goChoseTraining();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 300.0,
                      child: Center(
                        child: Text(
                          'Выбрать тренировку',
                          style: TextStyle(
                            fontFamily: 'montserrat',
                            color: UserDecoration.textSubStrColor,
                            fontSize: UserDecoration.textSize,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Количество шагов:',
                style: TextStyle(
                  fontFamily: 'montserrat',
                  color: UserDecoration.textSubStrColor,
                  fontSize: UserDecoration.textSize,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                getSteps(),
                style: TextStyle(
                  fontFamily: 'montserrat',
                  color: UserDecoration.textSubStrColor,
                  fontSize: UserDecoration.textSize,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                color: UserDecoration.secondColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  onTap: () {
                    setState(() {
                      dropCounter();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: 300.0,
                      child: Center(
                        child: Text(
                          'Сбросить шагомер',
                          style: TextStyle(
                            fontFamily: 'montserrat',
                            color: UserDecoration.textSubStrColor,
                            fontSize: UserDecoration.textSize,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateScreen(User user) {
    setState(() {
      //UserDecoration.secondColor = Color(0x00000000);
      widget.currentUser.level;
      currentUser = user;
    });
  }

  Future<List<Training>> getTraining(int id) async {
    Database db = await openDatabase(
      'resoursec/data_base.db',
    );
    List<Map> allTraining = await db.query(
      'training',
      where: 'idUser =$id OR idUser IS null',
    );
    List<Training> trainings = [];
    for (int i = 0; i < allTraining.length; i++) {
      trainings.add(Training(
          name: allTraining[i]['name'],
          complexTraining: await getExercise(allTraining[i]['id']),
          difficulty: allTraining[i]['difficult']));
    }
    return trainings;
  }

  Future<List<Map>> getExercise(int id) async {
    Database db = await openDatabase(
      'resoursec/data_base.db',
    );
    List<Map> allExercise = await db.query('exercise', where: 'id =$id', orderBy: 'length(name) DESC');
    return allExercise;
  }
}

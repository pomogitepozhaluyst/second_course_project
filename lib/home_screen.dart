import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    setState(() {
      getUserColorsFromLocalDataBase();
      helpGetTraining();
      currentUser = widget.currentUser;
    });

    /*User.level = 0;
    User.name = "test";*/
    /*  firstTraining = Training(
      name: "firstTraining",
      complexTraining: [
        "присесть 5 раз",
        "Отожмитесь 5 раз",
      ],
      imageTraining: Image.asset('assets/images/firstTraining.jpg'),
      difficulty: 30,
    );

    staminaTraining = Training(
        name: "staminaTraining",
        complexTraining: ["присесть 500 раз", "Отожмитесь 500 раз", "Сделайте 500 раз пресса"],
        imageTraining: Image.asset('assets/images/staminaTraining.jpg'),
        difficulty: 500);

    handTraining = Training(
      name: "handTraining",
      complexTraining: [
        "держите планку 1 минуту",
        "Отожмитесь 20 раз",
      ],
      imageTraining: Image.asset('assets/images/handTraining.webp'),
      difficulty: 100,
    );

    footTraining = Training(
      name: "footTraining",
      complexTraining: [
        "присесть 20 раз",
        "Ложитесь на землю, и подымайте ноги 20 раз",
      ],
      imageTraining: Image.asset('assets/images/footTraining.webp'),
      difficulty: 100,
    );
    extremeTraining = Training(
      name: "extremeTraining",
      complexTraining: [
        "присесть 20 раз",
        "Ложитесь на землю, и подымайте ноги 20 раз",
      ],
      imageTraining: Image.asset('assets/images/footTraining.webp'),
      difficulty: 1000000000000000000,
    );
    allTraining.addAll([
      firstTraining,
      staminaTraining,
      handTraining,
      footTraining,
      extremeTraining,
    ]);*/
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
        /*actions: [
          Container(
            margin: const EdgeInsets.only(right: 10, top: 3, bottom: 3),
            decoration: BoxDecoration(
                border: Border.all(color: UserDecoration.iconColor),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: IconButton(
                icon: Icon(
                  Icons.account_circle,
                  color: UserDecoration.iconColor,
                  size: 30,
                ),
                onPressed: goAccount,
              ),
            ),
          ),
        ],*/
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
    List<Map> allTraining = await db.query('training', where: 'idUser =$id OR idUser IS null');
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
    List<Map> allExercise = await db.query('exercise', where: 'id =$id');
    return allExercise;
  }
}

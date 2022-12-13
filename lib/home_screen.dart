import 'package:flutter/material.dart';
import 'package:second_course_project/User.dart';
import 'package:second_course_project/account_screen.dart';
import 'package:second_course_project/chose_training_screen.dart';
import 'package:second_course_project/data_popup_menu_item.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/pop_up_item_data.dart';
import 'package:second_course_project/training_class.dart';
import 'package:sqflite/sqflite.dart';

class MyHomePage extends StatefulWidget {
  final User currentUser;
  final void Function() getNormalColor;
  const MyHomePage({
    super.key,
    required this.currentUser,
    required this.getNormalColor,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late User thisUser;

  List<Training> allTraining = [];
  late Training firstTraining;
  late Training handTraining;
  late Training footTraining;
  late Training staminaTraining;

  @override
  void initState() {
    super.initState();
    setState(() {
      getUserColorsFromLocalDataBase();
    });

    /*User.level = 0;
    User.name = "test";*/
    firstTraining = Training(
      name: "firstTraining",
      complexTraining: [
        "присесть 5 раз",
        "Отожмитесь 5 раз",
      ],
      imageTraining: Image.asset('assets/images/firstTraining.jpg'),
      giveExp: 30,
    );

    staminaTraining = Training(
        name: "staminaTraining",
        complexTraining: ["присесть 500 раз", "Отожмитесь 500 раз", "Сделайте 500 раз пресса"],
        imageTraining: Image.asset('assets/images/staminaTraining.jpg'),
        giveExp: 500);

    handTraining = Training(
      name: "handTraining",
      complexTraining: [
        "держите планку 1 минуту",
        "Отожмитесь 20 раз",
      ],
      imageTraining: Image.asset('assets/images/handTraining.webp'),
      giveExp: 100,
    );

    footTraining = Training(
      name: "footTraining",
      complexTraining: [
        "присесть 20 раз",
        "Ложитесь на землю, и подымайте ноги 20 раз",
      ],
      imageTraining: Image.asset('assets/images/footTraining.webp'),
      giveExp: 100,
    );
    allTraining.addAll([
      firstTraining,
      staminaTraining,
      handTraining,
      footTraining,
    ]);
  }

  Future<void> getUserColorsFromLocalDataBase() async {
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

    db.close();
  }

  void goChoseTraining() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ChoseTrainingScreen(currentUser: widget.currentUser, allTraining: allTraining, tmp: updateScreen),
        ),
      );
    });
  }

  void goAccount() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AccountScreen(currentUser: widget.currentUser, updateMainScreen: updateScreen),
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
                widget.currentUser.level.toString(),
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
          widget.currentUser.name,
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
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                setState(() {
                  goChoseTraining();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 300.0,
                  height: 70.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: UserDecoration.secondColor,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
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
          ],
        ),
      ),
    );
  }

  void updateScreen() {
    setState(() {
      //UserDecoration.secondColor = Color(0x00000000);
      widget.currentUser.level;
    });
  }
}

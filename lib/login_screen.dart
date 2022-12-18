import 'package:flutter/material.dart';
import 'package:second_course_project/check_account_screen.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/registration_screen.dart';
import 'package:second_course_project/web/check_account_web.dart';
import 'package:second_course_project/web/registration_screen_web.dart';
import 'package:sqflite/sqflite.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  StateLoginScreen createState() => StateLoginScreen();
}

class StateLoginScreen extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    checkCreationTable();
  }

  Future<void> insertExercise(int id, String name, int timer) async {
    Database db = await openDatabase(
      'resoursec/data_base.db',
    );
    await db.execute('INSERT OR IGNORE INTO exercise(id, name, timer) VALUES($id, "$name", $timer)');
    await db.close();
  }

  Future<void> checkCreationTable() async {
    Database db = await openDatabase(
      'resoursec/data_base.db',
    ); /*
    db.execute('DROP TABLE users');
    db.execute('DROP TABLE userColor');
*/
    await db.execute(
        'CREATE TABLE IF NOT EXISTS userColor(id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,mainColor INTEGER NOT NULL, secondColor INTEGER NOT NULL, textTitleColor INTEGER NOT NULL, textStyle TEXT NOT NULL, textSubStrColor INTEGER NOT NULL,   iconColor INTEGER NOT NULL, textSize INTEGER)');

    await db.execute(
        'CREATE TABLE IF NOT EXISTS users (id	INTEGER NOT NULL UNIQUE, name	TEXT NOT NULL, email TEXT NOT NULL UNIQUE, password	TEXT NOT NULL,level	INTEGER NOT NULL, exp	INTEGER NOT NULL, needExpToNextLevel INTEGER NOT NULL, PRIMARY KEY(id AUTOINCREMENT))');

    //await db.execute('drop table exercise');
    //await db.execute('drop table Training');

    //await db.execute('drop table training');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS training (id	INTEGER NOT NULL  UNIQUE PRIMARY KEY AUTOINCREMENT, idUser INTEGER, name	TEXT NOT NULL, difficult INTEGER, pathImage TEXT)');
    //await db.execute('drop table exercise');
    await db.execute('CREATE TABLE IF NOT EXISTS exercise (id	INTEGER NOT NULL, name	TEXT NOT NULL, timer INTEGER)');
    /*await db.execute(
        'CREATE TABLE IF NOT EXISTS exerciseToTraining (idTraining	INTEGER NOT NULL, idExercise	INTEGER NOT NULL, CONSTRAINT new_pk PRIMARY KEY(idTraining, idExercise))');
    */
    await db.execute(
        'CREATE TABLE IF NOT EXISTS prevTraining (idTraining	INTEGER NOT NULL, idUser	INTEGER NOT NULL, data INTEGER NOT NULL)');
    await db.execute('INSERT OR IGNORE INTO training(id, name, difficult) VALUES(4, "Жиросжигающие упражнения", 2)');
    await db.execute(
        'INSERT OR IGNORE INTO training(id, name, difficult) VALUES(2, "Упражнения для поддержания формы", 2)');
    await db.execute(
        'INSERT OR IGNORE INTO training(id, name, difficult) VALUES(3, "Упражнения для увеличения мышечной массы", 2)');
    await db.execute('INSERT OR IGNORE INTO training(id, name, difficult) VALUES(1, "Утренняя разминка", 1)');
    await db.execute('INSERT OR IGNORE INTO training(id, name, difficult) VALUES(5, "Тренировка на выносливость", 7)');

    await insertExercise(
        1,
        'Данный комлекс упражнений поможет хорошо себя чувствовать целый день.\nНе Рекомендуется делать перерыв между упражнениями.\nДля продолжения нажмите на кнопку внизу экрана',
        0);
    await insertExercise(1, 'Выполняйте отжимания 10 раз', 0);
    await insertExercise(1, 'Выполняйте приседания 10 раз', 0);
    await insertExercise(1, 'Выполняйте скручивание 10 раз', 0);

    await insertExercise(
        4,
        'Данный комлекс упражнений поможет избавиться от лишненего жира.\nРекомендуется соблюдать интервал 30 секунд между упражнениями.\nДля продолжения нажмите на кнопку внизу экрана',
        0);
    await insertExercise(4, 'Выполняйте выпрыгивание из положения сидя 20 раз', 0);
    await insertExercise(4, 'Выполняйте отжимание от пола 20 раз', 0);
    await insertExercise(4, 'Выполняйте горизонтальную стойку 20 секунд', 20);
    await insertExercise(4, 'Выполняйте бег на месте из положения сидя 20 секунд', 20);
    await insertExercise(4, 'Выполняйте планку с прыжками 30 секунд', 30);
    await insertExercise(4, 'Выполняйте планку с подтягиванием коленей к груди 30 секунд', 30);

    await insertExercise(
        2,
        'Данный комлекс упражнений поможет поддеражть вашу форму.\nРекомендуется соблюдать интервал 30 секунд между упражнениями.\nДля продолжения нажмите на кнопку внизу экрана',
        0);
    await insertExercise(2, 'Выполняйте приседания 30 раз', 0);
    await insertExercise(2, 'Выполняйте отжимания 30 раз', 0);
    await insertExercise(2, 'Удерживайте планку 45 секунд', 45);
    await insertExercise(2, 'Выполняйте отжимания в упоре на стульях 30 раз', 0);

    await insertExercise(
        3,
        'Данный комлекс упражнений поможет увеличить мышечную массу.\nРекомендуется соблюдать интервал 30 секунд между упражнениями.\nДля продолжения нажмите на кнопку внизу экрана',
        0);
    await insertExercise(3, 'Выполняйте отжимания 50 раз', 0);
    await insertExercise(3, 'Выполняйте приседания 50 раз', 0);
    await insertExercise(3, 'Выполняйте скручивание 50 раз', 0);
    await insertExercise(3, 'Выполняйте упражнение лодочка 50 раз', 0);

    await insertExercise(
        5,
        'Данный комлекс упражнений поможет увеличить свою выносливость.\n Рекомендуется соблюдать интервал 30 секунд между упражнениями.\nДля продолжения нажмите на кнопку внизу экрана',
        0);
    await insertExercise(5, 'Выполняйте выпрыгивание из положения сидя 70 раз', 0);
    await insertExercise(5, 'Выполняйте отжимание от пола 70 раз', 0);
    await insertExercise(5, 'Выполняйте горизонтальную стойку 50 секунд', 50);
    await insertExercise(5, 'Выполняйте бег на месте из положения сидя 50 секунд', 50);
    await insertExercise(5, 'Выполняйте планку с прыжками 60 секунд', 60);
    await insertExercise(5, 'Выполняйте планку с подтягиванием коленей к груди 60 секунд', 60);
    await insertExercise(5, 'Выполняйте приседания 70 раз', 0);

    /*
    db.insert('training', {
      'name': 'Первая тренировка',
      'difficult': 1,
      'pathImage': 'assets/images/firstTraining.jpg',
    });
    await db.insert('exercise', {
      'id': 1,
      'name': 'Присядьте 20 раз',
      'timer': 0,
    });
    await db.insert('exercise', {
      'id': 1,
      'name': 'Отожмитесь 10 раз',
      'timer': 0,
    });
    await db.insert('exercise', {
      'id': 1,
      'name': 'Держите планку на локтях 30 секунд',
      'timer': 30,
    });*/
    await db.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UserDecoration.mainColor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Center(
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
                            goRegistrationScreenWeb();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: 250.0,
                            child: Center(
                              child: Text(
                                'Регистрация в онлайн режим',
                                textAlign: TextAlign.center,
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
                            goCheckAccountScreen();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: 250.0,
                            child: Center(
                              child: Text(
                                'Вход в оффлайн режим',
                                textAlign: TextAlign.center,
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
                            goCheckAccountScreenWeb();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: 250.0,
                            child: Center(
                              child: Text(
                                'Вход в онлайн режим',
                                textAlign: TextAlign.center,
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
                            goRegistrationScreen();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: 250.0,
                            child: Center(
                              child: Text(
                                'Регистрация в оффлайн режим',
                                textAlign: TextAlign.center,
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
          ),
        ),
      ),
    );
  }

  void goRegistrationScreen() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegistrationScreen(
            getNormalColor: getNormalColor,
          ),
        ),
      );
    });
  }

  void getNormalColor() {
    setState(() {
      UserDecoration.returnDefaultStyle();
    });
  }

  void goCheckAccountScreen() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckAccountScreen(getNormalColor: getNormalColor),
        ),
      );
    });
  }

  void goRegistrationScreenWeb() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegistrationScreenWeb(getNormalColor: getNormalColor),
        ),
      );
    });
  }

  void goCheckAccountScreenWeb() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthorisationScreenWeb(getNormalColor: getNormalColor),
        ),
      );
    });
  }
}

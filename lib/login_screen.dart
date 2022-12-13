import 'package:flutter/material.dart';
import 'package:second_course_project/check_account_screen.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/registration_screen.dart';
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

  Future<void> checkCreationTable() async {
    Database db = await openDatabase(
      'resoursec/data_base.db',
    );
    /*db.execute('DROP TABLE users');
    db.execute('DROP TABLE userColor');
*/
    await db.execute(
        'CREATE TABLE IF NOT EXISTS userColor(id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,mainColor INTEGER NOT NULL, secondColor INTEGER NOT NULL, textTitleColor INTEGER NOT NULL, textStyle TEXT NOT NULL, textSubStrColor INTEGER NOT NULL,   iconColor INTEGER NOT NULL, textSize INTEGER)');

    await db.execute(
        'CREATE TABLE IF NOT EXISTS users (id	INTEGER NOT NULL UNIQUE, name	TEXT NOT NULL, email TEXT NOT NULL UNIQUE, password	TEXT NOT NULL,level	INTEGER NOT NULL, exp	INTEGER NOT NULL, needExpToNextLevel INTEGER NOT NULL, PRIMARY KEY(id AUTOINCREMENT))');
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
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        goCheckAccountScreen();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 200.0,
                        height: 50.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: UserDecoration.secondColor,
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Вход',
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
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        goRegistrationScreen();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 200.0,
                        height: 50.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: UserDecoration.secondColor,
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Регистрация',
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
          builder: (context) => const RegistrationScreen(),
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
}

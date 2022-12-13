import 'package:flutter/material.dart';
import 'package:second_course_project/User.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/home_screen.dart';
import 'package:sqflite/sqflite.dart';

class CheckAccountScreen extends StatefulWidget {
  final void Function() getNormalColor;
  const CheckAccountScreen({super.key, required this.getNormalColor});

  @override
  StateCheckAccountScreen createState() => StateCheckAccountScreen();
}

class StateCheckAccountScreen extends State<CheckAccountScreen> {
  String? errorMessageOnEmptyPasswordInputField;
  String? errorMessageOnEmptyEmailInputField;
  late String emailFromInputField;
  late String passwordFromInputField;

  @override
  void initState() {
    super.initState();
    emailFromInputField = '';
    passwordFromInputField = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UserDecoration.mainColor,
      appBar: AppBar(
        title: Text(
          "Авторизация",
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
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: (String value) {
                    emailFromInputField = value;
                  },
                  style: TextStyle(
                    color: UserDecoration.textSubStrColor,
                  ),
                  maxLength: 40,
                  decoration: InputDecoration(
                    errorText: errorMessageOnEmptyEmailInputField,
                    hintText: 'Введите email',
                    hintStyle: TextStyle(fontSize: UserDecoration.textSize, color: UserDecoration.textSubStrColor),
                    counterStyle: TextStyle(color: UserDecoration.textSubStrColor),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0x8076758a)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: UserDecoration.textSubStrColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: (String value) {
                    passwordFromInputField = value;
                  },
                  style: TextStyle(
                    color: UserDecoration.textSubStrColor,
                  ),
                  maxLength: 40,
                  decoration: InputDecoration(
                    errorText: errorMessageOnEmptyPasswordInputField,
                    hintText: 'Введите пароль',
                    hintStyle: TextStyle(fontSize: UserDecoration.textSize, color: UserDecoration.textSubStrColor),
                    counterStyle: TextStyle(color: UserDecoration.textSubStrColor),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0x8076758a)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: UserDecoration.textSubStrColor),
                    ),
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    findUserIndDataBase();
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
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Войти',
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
    );
  }

  Future<void> findUserIndDataBase() async {
    bool errorsFromInitField = false;
    if (passwordFromInputField.isEmpty) {
      errorMessageOnEmptyPasswordInputField = 'Введите пароль';
      errorsFromInitField = true;
    }
    if (emailFromInputField.isEmpty) {
      errorMessageOnEmptyEmailInputField = 'Введите email';
      errorsFromInitField = true;
    }
    if (errorsFromInitField) {
      return;
    }
    Database db = await openDatabase(
      'resoursec/data_base.db',
    );
    List<Map> user =
        await db.query(r'users ', where: 'email = "$emailFromInputField" AND password = "$passwordFromInputField"');
    if (user.length == 1) {
      goHomePage(user[0]);
    } else {
      setState(() {
        errorMessageOnEmptyEmailInputField = 'Ошибка в логине или пароле';
        errorMessageOnEmptyPasswordInputField = 'Ошибка в логине или пароле';
      });
    }
    await db.close();
  }

  void goHomePage(Map user) {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            getNormalColor: widget.getNormalColor,
            currentUser: User(
              id: user['id'],
              name: user['name'],
              exp: user['exp'],
              level: user['level'],
              needExpToNextLevel: user['needExpToNextLevel'],
              password: user['password'],
            ),
          ),
        ),
      );
    });
  }
}

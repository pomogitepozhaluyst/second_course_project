import 'package:flutter/material.dart';
import 'package:second_course_project/decoration.dart';
import 'package:sqflite/sqflite.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  @override
  StateRegistrationScreen createState() => StateRegistrationScreen();
}

class StateRegistrationScreen extends State<RegistrationScreen> {
  String? errorMessageOnEmptyPasswordInputField;
  String? errorMessageOnEmptyEmailInputField;
  String nameFromInputField = '';
  String passwordFromInputField = '';
  String emailFromInputField = '';

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
          "Регистрация",
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
            onPressed: () => Navigator.pop(context),
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
                    nameFromInputField = value;
                  },
                  style: TextStyle(
                    color: UserDecoration.textSubStrColor,
                  ),
                  maxLength: 40,
                  decoration: InputDecoration(
                    hintText: 'Введите Имя',
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
                  maxLength: 40,
                  style: TextStyle(
                    color: UserDecoration.textSubStrColor,
                  ),
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
                    registration();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 300.0,
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
                          'зарегистрироваться',
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

  Future<void> registration() async {
    errorMessageOnEmptyEmailInputField = null;
    errorMessageOnEmptyPasswordInputField = null;
    bool errorsFromInitField = false;
    if (emailFromInputField.isEmpty) {
      errorMessageOnEmptyEmailInputField = 'почта не может быть пустой';
      errorsFromInitField = true;
    }
    if (passwordFromInputField.isEmpty) {
      errorMessageOnEmptyPasswordInputField = 'пароль не может быть пустым';
      errorsFromInitField = true;
    }

    if (errorsFromInitField) {
      return;
    }
    Database db = await openDatabase(
      'resoursec/data_base.db',
    );
    List<Map> tmp = await db.query('users', where: 'email = "$emailFromInputField"');
    if (tmp.isNotEmpty) {
      db.close();
      errorMessageOnEmptyEmailInputField = 'Такая почта уже используется';
      return;
    }
    db.insert(r'users ', {
      'name': nameFromInputField,
      'email': emailFromInputField,
      'password': passwordFromInputField,
      'level': 0,
      'exp': 0,
      'needExpToNextLevel': 100,
    });
    List<Map> tmp2 = await db.query('users', where: 'email = "$emailFromInputField"');
    db.insert('userColor', {
      'id': tmp2[0]['id'],
      'mainColor': 0xFF090100,
      'secondColor': 0xFF28262c,
      'textTitleColor': 0xFFffffff,
      'textSubStrColor': 0xFF76758a,
      'iconColor': 0xFF777086,
      'textStyle': 'montserrat',
    });
    db.close();
    returnBackScreen();
  }

  void returnBackScreen() {
    Navigator.of(context).pop();
  }
}

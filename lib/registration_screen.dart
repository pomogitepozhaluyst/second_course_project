import 'package:crypt/crypt.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/home_screen.dart';
import 'package:second_course_project/user.dart';
import 'package:sqflite/sqflite.dart';

class RegistrationScreen extends StatefulWidget {
  final void Function() getNormalColor;

  const RegistrationScreen({
    super.key,
    required this.getNormalColor,
  });
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
                    fontSize: UserDecoration.textSize,
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
              /* Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: (String value) {
                    nameFromInputField = value;
                  },
                  style: TextStyle(
                    color: UserDecoration.textSubStrColor,
                    fontSize: UserDecoration.textSize,
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
              ),*/
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: (String value) {
                    passwordFromInputField = value;
                  },
                  maxLength: 40,
                  style: TextStyle(
                    color: UserDecoration.textSubStrColor,
                    fontSize: UserDecoration.textSize,
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
                        registration();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 300.0,
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

    if (!EmailValidator.validate(emailFromInputField)) {
      errorMessageOnEmptyEmailInputField = 'Введите правильную почту';
      return;
    }
    Database db = await openDatabase(
      'resoursec/data_base.db',
    );
    List<Map> tmp = await db.query('users', where: 'email = "$emailFromInputField"');
    if (tmp.isNotEmpty) {
      db.close();
      setState(() {
        errorMessageOnEmptyEmailInputField = 'Такая почта уже используется';
      });
      return;
    }
    passwordFromInputField = Crypt.sha256(passwordFromInputField).toString();
    print(passwordFromInputField);

    await db.insert(r'users ', {
      'name': nameFromInputField,
      'email': emailFromInputField,
      'password': passwordFromInputField,
      'level': 0,
      'exp': 0,
      'needExpToNextLevel': 10,
    });
    List<Map> tmp2 = await db.query('users', where: 'email = "$emailFromInputField"');
    await db.insert('userColor', {
      'id': tmp2[0]['id'],
      'mainColor': 0xFF090100,
      'secondColor': 0xFF28262c,
      'textTitleColor': 0xFFffffff,
      'textSubStrColor': 0xFF76758a,
      'iconColor': 0xFF777086,
      'textStyle': 'montserrat',
    });
    List<Map> user =
        await db.query(r'users ', where: 'email = "$emailFromInputField" AND password = "$passwordFromInputField"');
    await db.close();
    goHomePage(user[0]);
  }

  void returnBackScreen() {
    Navigator.of(context).pop();
  }

  void goHomePage(Map user) {
    //Navigator.of(context).pop();
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            getNormalColor: widget.getNormalColor,
            isUsedOriginalColor: false,
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

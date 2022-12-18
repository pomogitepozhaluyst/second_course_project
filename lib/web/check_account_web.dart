import 'package:flutter/material.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/network/api_client.dart';
import 'package:second_course_project/web/home_screen_web.dart';
import 'package:second_course_project/web/user_web.dart';

class AuthorisationScreenWeb extends StatefulWidget {
  final void Function() getNormalColor;

  const AuthorisationScreenWeb({
    super.key,
    required this.getNormalColor,
  });
  @override
  StateAuthorisationScreenWeb createState() => StateAuthorisationScreenWeb();
}

class StateAuthorisationScreenWeb extends State<AuthorisationScreenWeb> {
  String? errorMessageOnEmptyPasswordInputField;
  String? errorMessageOnEmptyEmailInputField;
  String passwordFromInputField = '';
  String emailFromInputField = '';

  String baseApi = 'http://10.0.2.2:8000/api/auth/users/';

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
                        authorisation();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 300.0,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> authorisation() async {
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

    final ApiClient apiClient = ApiClient();
    final tmp = await apiClient.authUser(email: emailFromInputField, password: passwordFromInputField);
    if (tmp is String) {
      setState(() {
        errorMessageOnEmptyEmailInputField = tmp;
      });
    } else {
      goHomePage(tmp);
    }
  }

  void returnBackScreen() {
    Navigator.of(context).pop();
  }

  void goHomePage(UserWeb user) {
    //Navigator.of(context).pop();
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            getNormalColor: widget.getNormalColor,
            currentUser: user,
          ),
        ),
      );
    });
  }
}

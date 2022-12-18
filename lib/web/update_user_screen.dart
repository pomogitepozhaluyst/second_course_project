import 'package:flutter/material.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/network/api_client.dart';
import 'package:second_course_project/web/user_web.dart';

class UpdateUserScreen extends StatefulWidget {
  final UserWeb currentUser;
  final void Function(UserWeb) updateUser;
  const UpdateUserScreen({
    super.key,
    required this.currentUser,
    required this.updateUser,
  });
  @override
  StateUpdateUserScreen createState() => StateUpdateUserScreen();
}

class StateUpdateUserScreen extends State<UpdateUserScreen> {
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
          "Обновление пользователя",
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
                        registration();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 300.0,
                        child: Center(
                          child: Text(
                            'Обновить',
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
    var apiClient = ApiClient();
    final user = await apiClient.updateUser2(
      widget.currentUser.token,
      nameFromInputField,
      emailFromInputField,
      passwordFromInputField,
    );
    if (user is String) {
      setState(() {
        errorMessageOnEmptyEmailInputField = user;
        errorsFromInitField = true;
      });
      return;
    }
    widget.updateUser(user);
    goHomePage();
  }

  void returnBackScreen() {
    Navigator.of(context).pop();
  }

  void goHomePage() {
    Navigator.of(context).pop();
  }
}

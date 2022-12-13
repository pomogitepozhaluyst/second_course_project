import 'package:flutter/material.dart';
import 'package:second_course_project/User.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/input_window.dart';
import 'package:sqflite/sqflite.dart';

class SettingScreen extends StatefulWidget {
  final Function() updateMainScreen;
  final User currentUser;
  const SettingScreen({super.key, required this.currentUser, required this.updateMainScreen});
  @override
  StateSettingScreen createState() => StateSettingScreen();
}

class StateSettingScreen extends State<SettingScreen> {
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
          "Найстройка",
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
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              choseColorInBlock("Выберите цвет фона", choseFirstColor),
              choseColorInBlock("Выберите второй основный цвет", choseSecondColor),
              choseColorInBlock("Выберите цвет заголовка текста", choseTextTitleColor),
              choseColorInBlock("Выберите цвет Иконок", choseIconColor),
              choseColorInBlock("Выберите цвет основного текста", choseTextSubStrColor),
            ],
          );
        },
      ),
    );
  }

  void choseFirstColor(int value) {
    setState(() {
      UserDecoration.mainColor = Color(value);
      updateDataBaseColor();
      widget.updateMainScreen();
    });
  }

  Column choseColorInBlock(String titleName, Function(int) choseColor) {
    return Column(
      children: [
        Center(
          child: Text(
            titleName,
            style: TextStyle(
              fontFamily: UserDecoration.textStyle,
              color: UserDecoration.textSubStrColor,
              fontSize: UserDecoration.textSize,
            ),
          ),
        ),
        Card(
          color: UserDecoration.secondColor,
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        choseColor(0xFFFF0000);
                        print(UserDecoration.mainColor.value);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF0000),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: const Color(0xff000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
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
                        widget.updateMainScreen();
                        choseColor(0xFF00D109);
                        print(UserDecoration.mainColor.value);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF00D109),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: const Color(0xff000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
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
                        widget.updateMainScreen();
                        choseColor(0xFFFAEF00);
                        print(UserDecoration.mainColor.value);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAEF00),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: const Color(0xff000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
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
                        widget.updateMainScreen();
                        choseColor(0xFFF39400);
                        print(UserDecoration.mainColor.value);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF39400),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: const Color(0xff000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
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
                        widget.updateMainScreen();
                        choseColor(0xFFDE00DA);
                        print(UserDecoration.mainColor.value);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFDE00DA),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: const Color(0xff000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        choseColor(0xFF0008D2);
                        widget.updateMainScreen();
                        print(UserDecoration.mainColor.value);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF0008D2),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: const Color(0xff000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
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
                        choseColor(0xFFFF0247);
                        widget.updateMainScreen();
                        print(UserDecoration.mainColor.value);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF0247),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: const Color(0xff000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return InputWindow(
                              title: 'Выбор цвета Фона',
                              hintText: 'Введите цвет в шестнадцатеричной системе',
                              submit: choseColor,
                            );
                          },
                        );

                        print(UserDecoration.mainColor.value);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: Container(
                          child: Center(
                            child: Text("HEX"),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: const Color(0xff000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void choseSecondColor(int value) {
    setState(() {
      UserDecoration.secondColor = Color(value);
      updateDataBaseColor();
      widget.updateMainScreen();
    });
  }

  void choseTextTitleColor(int value) {
    setState(() {
      UserDecoration.textTitleColor = Color(value);
      updateDataBaseColor();
      widget.updateMainScreen();
    });
  }

  void choseTextSubStrColor(int value) {
    setState(() {
      UserDecoration.textSubStrColor = Color(value);
      updateDataBaseColor();
      widget.updateMainScreen();
    });
  }

  void choseIconColor(int value) {
    setState(() {
      UserDecoration.iconColor = Color(value);
      updateDataBaseColor();
      widget.updateMainScreen();
    });
  }

  Future<void> updateDataBaseColor() async {
    Database db = await openDatabase(
      'resoursec/data_base.db',
    );
    await db.update(
      'userColor',
      {
        'id': widget.currentUser.id,
        'mainColor': UserDecoration.mainColor.value,
        'secondColor': UserDecoration.secondColor.value,
        'textTitleColor': UserDecoration.textTitleColor.value,
        'textSubStrColor': UserDecoration.textSubStrColor.value,
        'iconColor': UserDecoration.iconColor.value,
        'textStyle': UserDecoration.textStyle,
      },
      // Ensure that the Dog has a matching id.
      where: 'id = ${widget.currentUser.id}',
    );
    db.close();
  }
}

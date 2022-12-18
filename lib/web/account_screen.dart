import 'package:flutter/material.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/web/update_user_screen.dart';
import 'package:second_course_project/web/user_web.dart';

class AccountScreenWeb extends StatefulWidget {
  final Function(UserWeb) updateMainScreen;
  final UserWeb currentUser;
  const AccountScreenWeb({
    super.key,
    required this.currentUser,
    required this.updateMainScreen,
  });

  @override
  State<AccountScreenWeb> createState() => AccountScreenWebState();
}

class AccountScreenWebState extends State<AccountScreenWeb> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UserDecoration.mainColor,
      appBar: AppBar(
        title: Text(
          "Ваш прогресс",
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "Уровень: ${widget.currentUser.level}",
                style: TextStyle(
                  fontFamily: UserDecoration.textStyle,
                  color: UserDecoration.textSubStrColor,
                  fontSize: UserDecoration.textSize,
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Column(
                children: [
                  Text(
                    'Опыт: ${widget.currentUser.exp.toInt()}/${widget.currentUser.needExpToNextLevel.toInt()}',
                    style: TextStyle(
                      fontFamily: UserDecoration.textStyle,
                      color: UserDecoration.textSubStrColor,
                      fontSize: UserDecoration.textSize,
                    ),
                  ),
                  LinearProgressIndicator(
                    value: widget.currentUser.exp / widget.currentUser.needExpToNextLevel,
                    backgroundColor: UserDecoration.secondColor.withOpacity(0.2),
                    color: UserDecoration.secondColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
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
                            goUpdateAccount();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: 300.0,
                            child: Center(
                              child: Text(
                                'Изменить данные',
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goSettingScreen,
        backgroundColor: UserDecoration.secondColor,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(
          Icons.settings,
          color: UserDecoration.iconColor,
        ),
      ),
    );
  }

  void goUpdateAccount() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateUserScreen(currentUser: widget.currentUser, updateUser: widget.updateMainScreen),
        ),
      );
    });
  }

  void goSettingScreen() {
    /* setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SettingScreen(currentUser: widget.currentUser, updateMainScreen: updateAccountScreen),
        ),
      );
    });*/
  }

  void updateAccountScreen() {
    setState(() {
      widget.updateMainScreen(widget.currentUser);
    });
  }
}

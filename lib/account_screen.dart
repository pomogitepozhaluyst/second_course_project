import 'package:flutter/material.dart';
import 'package:second_course_project/User.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/setting_screen.dart';

class AccountScreen extends StatefulWidget {
  final Function() updateMainScreen;
  final User currentUser;
  const AccountScreen({
    super.key,
    required this.currentUser,
    required this.updateMainScreen,
  });

  @override
  StateAccountScreen createState() => StateAccountScreen();
}

class StateAccountScreen extends State<AccountScreen> with TickerProviderStateMixin {
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
                    backgroundColor: UserDecoration.secondColor.withOpacity(0.7),
                    color: UserDecoration.secondColor,
                  ),
                ],
              ),
            )
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

  void goSettingScreen() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SettingScreen(currentUser: widget.currentUser, updateMainScreen: updateAccountScreen),
        ),
      );
    });
  }

  void updateAccountScreen() {
    setState(() {
      widget.updateMainScreen();
    });
  }
}

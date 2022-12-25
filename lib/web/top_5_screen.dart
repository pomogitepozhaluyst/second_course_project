import 'package:flutter/material.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/network/api_client.dart';
import 'package:second_course_project/web/top_users.dart';

class TopFiveScreen extends StatefulWidget {
  const TopFiveScreen({
    super.key,
  });
  @override
  StateTopFiveScreen createState() => StateTopFiveScreen();
}

class StateTopFiveScreen extends State<TopFiveScreen> {
  String? errorMessageOnEmptyPasswordInputField;
  String? errorMessageOnEmptyEmailInputField;
  String passwordFromInputField = '';
  String emailFromInputField = '';

  String baseApi = 'http://10.0.2.2:8000/api/auth/users/';

  late Future<List<Container>> _top;
  @override
  void initState() {
    super.initState();
    _top = getTopFive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UserDecoration.mainColor,
      appBar: AppBar(
        title: Text(
          "Топ 5",
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
          child: FutureBuilder<List<Container>>(
            future: _top,
            builder: (BuildContext context, AsyncSnapshot<List<Container>> snapshot) {
              if (!snapshot.hasData) {
                // data loaded:
                return Column(mainAxisAlignment: MainAxisAlignment.center, children: const []);
              } else {
                return Column(mainAxisAlignment: MainAxisAlignment.center, children: snapshot.data!);
              }
            },
          ),
        ),
      ),
    );
  }

  Future<List<Container>> getTopFive() async {
    final apiClient = ApiClient();
    List<TopUsers> users = await apiClient.getTop5();
    List<Container> top5 = [];
    top5.add(
      Container(
        padding: const EdgeInsets.all(10),
        child: Card(
          color: UserDecoration.secondColor,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Text(
                    'Уровень',
                    style: TextStyle(
                      fontFamily: UserDecoration.textStyle,
                      color: UserDecoration.textSubStrColor,
                      fontSize: UserDecoration.textSize,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Text(
                    'Имя',
                    style: TextStyle(
                      fontFamily: UserDecoration.textStyle,
                      color: UserDecoration.textSubStrColor,
                      fontSize: UserDecoration.textSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    for (int i = 0; i < 5; i++) {
      top5.add(
        Container(
          padding: const EdgeInsets.all(10),
          child: Card(
            color: UserDecoration.secondColor,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        users[i].level.toString(),
                        style: TextStyle(
                          fontFamily: UserDecoration.textStyle,
                          color: UserDecoration.textSubStrColor,
                          fontSize: UserDecoration.textSize,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      users[i].name,
                      style: TextStyle(
                        fontFamily: UserDecoration.textStyle,
                        color: UserDecoration.textSubStrColor,
                        fontSize: UserDecoration.textSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return top5;
  }

  void returnBackScreen() {
    Navigator.of(context).pop();
  }
}

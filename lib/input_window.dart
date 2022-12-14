import 'package:flutter/material.dart';

class InputWindow extends StatefulWidget {
  final String hintText;
  final String title;
  final String startInput;
  final Function(int) submit;

  const InputWindow({
    super.key,
    required this.title,
    required this.hintText,
    required this.submit,
    this.startInput = '',
  });

  @override
  InputWindowState createState() => InputWindowState();
}

class InputWindowState extends State<InputWindow> {
  String? errorMessage;
  late String stringFromInputField;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    stringFromInputField = widget.startInput;
    controller = TextEditingController();
    controller.text = stringFromInputField;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        onChanged: (String value) {
          stringFromInputField = value;
        },
        controller: controller,
        maxLength: 6,
        decoration: InputDecoration(
          errorText: errorMessage,
          hintText: widget.hintText,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            errorMessage = null;
            stringFromInputField = '';
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            if (stringFromInputField.length < 6) {
              setState(() {
                errorMessage = 'Поле не может быть пустым';
              });
            } else if (stringFromInputField.length == 6) {
              Navigator.of(context).pop();
              widget.submit(int.parse('0xFF$stringFromInputField'));
            }
          },
          child: const Text('Ок'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:second_course_project/decoration.dart';
import 'package:second_course_project/pop_up_item_data.dart';

class DataPopupMenuItem extends PopupMenuItem<PopupMenuItemData> {
  final PopupMenuItemData data;

  DataPopupMenuItem({super.key, required this.data})
      : super(
          value: data,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Icon(
                  data.icon,
                  color: UserDecoration.iconColor,
                ),
              ),
              Expanded(
                flex: 5,
                child: data.title,
              )
            ],
          ),
        );
}

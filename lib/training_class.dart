import 'package:flutter/material.dart';

class Training {
  final String name;
  final List<String> complexTraining;
  final Image imageTraining;
  final int giveExp;
  const Training({
    required this.name,
    required this.complexTraining,
    required this.imageTraining,
    required this.giveExp,
  });
}

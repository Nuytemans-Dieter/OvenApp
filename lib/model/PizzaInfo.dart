import 'package:flutter/material.dart';
import 'package:oven_app/model/TimerHelper.dart';

class PizzaInfo {
  String title;
  IconData icon;

  final TimerHelper timerHelper = TimerHelper();

  PizzaInfo(this.title, this.icon);
}

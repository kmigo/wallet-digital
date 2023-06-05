import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet_digital/utils/app_routes.dart';

import 'dart:async';
import '../app/blocs/authententication/bloc.dart';
import '../core/domain/entities/user.dart';
part 'buttons/button.dart';
part 'carrousel.dart';

part 'text_input.dart';
part 'text.dart';
part 'app_bar.dart';
part 'circular_progress_indicator.dart';
part 'error_try_again.dart';
part 'top_scroll_behavior.dart';
part 'card.dart';
part 'empty.dart';
class TopColors {
  static const Color thirdColor = Colors.white;
  static const Color primaryColor = Colors.black;
  static const Color redColor = Colors.red;
  static const Color greenColor = Colors.green;
  static const Color lightGreen = Colors.lightGreen;
  static const Color greyColor = Colors.grey;
  static const Color blueGrey = Colors.blueGrey;
}
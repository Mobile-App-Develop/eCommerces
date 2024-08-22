import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marting/consts/color.dart';

Widget loadingIndicator(){
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}
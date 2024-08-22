import 'package:marting/consts/consts.dart';

Widget buttonWidget({onpress, color, textcolor, String? title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      onPressed: onpress,
      child: title!.text.color(textcolor).make());
}

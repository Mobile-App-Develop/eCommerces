import 'package:marting/consts/consts.dart';
import 'package:marting/consts/style.dart';

Widget homeButton({width, height, icon, String? title, onPress}) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icTodaysDeal,
          width: 26,
        ),
        10.heightBox,
        title!.text.fontFamily(semibold).color(darkFontGrey).make(),
      ],
    ),
  ).box.roundedSM.white.shadowSm.size(width, height).make();
}

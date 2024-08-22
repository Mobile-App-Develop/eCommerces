import 'package:flutter/services.dart';
import 'package:marting/consts/consts.dart';
import 'package:marting/widgets/button.dart';

Widget exitDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.color(darkFontGrey).size(18).bold.make(),
        Divider(),
        10.heightBox,
        "Are you sure you went to exit?"
            .text
            .color(darkFontGrey)
            .size(16)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buttonWidget(
                color: redColor,
                onpress: () {
                  SystemNavigator.pop();
                },
                textcolor: whiteColor,
                title: "Yes"),
            buttonWidget(
                color: redColor,
                onpress: () {
                  Navigator.pop(context);
                },
                textcolor: whiteColor,
                title: "No"),
          ],
        )
      ],
    ).box.color(lightGrey).padding(EdgeInsets.all(12)).shadowSm.make(),
  );
}

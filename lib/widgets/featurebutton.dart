import 'package:marting/consts/consts.dart';
import 'package:marting/screens/catagory_files/category_detail.dart';

Widget featureButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(icon, width: 60, fit: BoxFit.fill),
      10.widthBox,
      title!.text.make(),
    ],
  )
      .box
      .white
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .rounded
      .width(200)
      .padding(EdgeInsets.all(4))
      .outerShadow
      .make()
      .onTap(() {
    Get.to(() => catagoryDetail(title: title));
  });
}

import 'package:marting/consts/consts.dart';

Widget orderPlaceDetail({title_1, title_2, det_1, det_2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title_1".text.make(),
            "$det_1".text.color(Colors.red).make(),
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title_2".text.make(),
              "$det_2".text.color(Colors.red).make(),
            ],
          ),
        ),
        Column(),
      ],
    ),
  );
}

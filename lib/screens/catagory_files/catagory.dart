import 'package:marting/consts/consts.dart';
import 'package:marting/consts/list.dart';
import 'package:marting/consts/style.dart';
import 'package:marting/firbase/controller/product_controller.dart';
import 'package:marting/screens/catagory_files/category_detail.dart';
import 'package:marting/widgets/bg_widget.dart';

class catogry extends StatefulWidget {
  const catogry({super.key});

  @override
  State<catogry> createState() => _catogryState();
}

class _catogryState extends State<catogry> {
  @override
  Widget build(BuildContext context) {
    var controller =Get.put(ProductController());
    return bgwidget(
      child: Scaffold(
        appBar: AppBar(
          title: catagory.text.white.fontFamily(bold).make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: GridView.builder(shrinkWrap: true,
              itemCount: 9,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 200),
              itemBuilder: (context, index) {
            return Column(
              children: [
                Image.asset(catagoriesimg[index], height: 120,width: 200,fit: BoxFit.cover,),
                10.heightBox,
                "${catagorieslist[index]}".text.color(darkFontGrey).align(TextAlign.center).make()
              ],
            ).box.white.roundedSM.clip(Clip.antiAlias).outerShadow.make().onTap(() {
              controller.getSubCatagories(catagorieslist[index]);
              Get.to(()=> catagoryDetail(title: catagorieslist[index]));
            });
              }),
        ),
      ),
    );
  }
}

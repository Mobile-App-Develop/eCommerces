import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marting/consts/consts.dart';
import 'package:marting/consts/style.dart';
import 'package:marting/screens/catagory_files/item_detail.dart';
import 'package:marting/services/firbase_services.dart';
import 'package:marting/widgets/bg_widget.dart';
import 'package:marting/widgets/loading_indicator.dart';

import '../../firbase/controller/product_controller.dart';

class catagoryDetail extends StatefulWidget {
  final String? title;

  const catagoryDetail({super.key, required this.title});

  @override
  State<catagoryDetail> createState() => _catagoryDetailState();
}

class _catagoryDetailState extends State<catagoryDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCatagory(widget.title);
  }

  switchCatagory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = Firestoreservices.getSubCatagoryProducts(title);
    } else {
      productMethod = Firestoreservices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();

  dynamic productMethod;

  @override
  Widget build(BuildContext context) {
    return bgwidget(
        child: Scaffold(
            appBar: AppBar(
              title: widget.title!.text.fontFamily(semibold).white.make(),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(
                          controller.subcat.length,
                          (index) => "${controller.subcat[index]}"
                                  .text
                                  .size(12)
                                  .color(darkFontGrey)
                                  .makeCentered()
                                  .box
                                  .white
                                  .size(100, 50)
                                  .rounded
                                  .margin(EdgeInsets.symmetric(horizontal: 4))
                                  .make()
                                  .onTap(() {
                                switchCatagory("${controller.subcat[index]}");
                                setState(() {});
                              }))),
                ),
                20.heightBox,
                StreamBuilder(
                    stream: productMethod,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                          child: Center(
                            child: loadingIndicator(),
                          ),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Expanded(
                          child: "No product found"
                              .text
                              .color(darkFontGrey)
                              .makeCentered(),
                        );
                      } else {
                        var data = snapshot.data!.docs;
                        return Expanded(
                            child: Container(
                          color: lightGrey,
                          child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 250,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(data[index]['p_imags'][0],
                                        width: 200,
                                        height: 150,
                                        fit: BoxFit.cover),
                                    "${data[index]['p_name']}"
                                        .text
                                        .center
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "${data[index]['p_price']}"
                                        .numCurrency
                                        .text
                                        .fontFamily(semibold)
                                        .center
                                        .color(redColor)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .roundedSM
                                    .outerShadow
                                    .padding(EdgeInsets.all(12))
                                    .margin(EdgeInsets.symmetric(horizontal: 4))
                                    .make()
                                    .onTap(() {
                                  controller.checkIffav(data[index]);
                                  Get.to(
                                    () => itemDetail(
                                        title: "${data[index]['p_name']}",
                                        data: data[index]),
                                  );
                                });
                              }),
                        ));
                      }
                    }),
              ],
            )));
  }
}

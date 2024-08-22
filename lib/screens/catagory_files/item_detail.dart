import 'package:marting/consts/consts.dart';
import 'package:marting/consts/style.dart';
import 'package:marting/firbase/controller/product_controller.dart';
import 'package:marting/screens/chat_screen/chat_screen.dart';
import 'package:marting/widgets/button.dart';

import '../../consts/list.dart';

class itemDetail extends StatelessWidget {
  final String? title;
  final dynamic data;

  const itemDetail({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    // print(Colors.purple.value);
    var controller = Get.find<ProductController>();

    return WillPopScope(
      onWillPop: () async {
        controller.resetValue();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValue();
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.share)),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishList(data.id, context);
                    } else {
                      controller.addToWishList(data.id, context);
                    }
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: controller.isFav.value ? redColor : darkFontGrey,
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //swiper selection
                      VxSwiper.builder(
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          height: 350,
                          itemCount: data["p_imags"].length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data["p_imags"][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),

                      //title and detail section
                      10.heightBox,
                      title!.text
                          .size(16)
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: VxRating(
                          isSelectable: false,
                          value: double.parse(data['p_rating']),
                          onRatingUpdate: (value) {},
                          normalColor: textfieldGrey,
                          selectionColor: golden,
                          maxRating: 5,
                          count: 5,
                          size: 20,
                        ),
                      ),
                      10.heightBox,
                      "${data['p_price']}"
                          .numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              "Seller".text.bold.make(),
                              "${data['p_saller']}".text.make(),
                              5.heightBox,
                              "In House Brand"
                                  .text
                                  .color(darkFontGrey)
                                  .size(16)
                                  .fontFamily(semibold)
                                  .make(),
                            ],
                          )),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ),
                          ).onTap(() {
                            Get.to(
                              () => const Chat_Screen(),
                              arguments: [data['p_saller'], data['vendor_id']],
                            );
                          })
                        ],
                      )
                          .box
                          .height(60)
                          .color(textfieldGrey)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .make(),

                      //okkkkkkkkkkk

                      //8.19 colore section
                      20.heightBox,
                      Obx(
                        () => Column(children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                  children: List.generate(
                                      data['p_colors'].length,
                                      (index) => Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              VxBox()
                                                  .size(40, 40)
                                                  .roundedFull
                                                  .color(Color(data['p_colors']
                                                          [index])
                                                      .withOpacity(1.0))
                                                  .margin(const EdgeInsets
                                                      .symmetric(horizontal: 4))
                                                  .make()
                                                  .onTap(() {
                                                controller
                                                    .changColorIndex(index);
                                              }),
                                              Visibility(
                                                  visible: index ==
                                                      controller
                                                          .colorIndex.value,
                                                  child: Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                  )),
                                            ],
                                          ))),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          //okkkkkkkkkkk

                          //quatinty row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Quanity".text.color(textfieldGrey).make(),
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.decreaseQuenty();
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.remove)),
                                    controller.quatinty.value.text
                                        .size(16)
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          controller.increaseQuenty(
                                              int.parse(data['p_quatinty']));
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.add)),
                                    10.widthBox,
                                    "(${data['p_quatinty']} Availables)"
                                        .text
                                        .bold
                                        .color(textfieldGrey)
                                        .make(),
                                  ],
                                ),
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          Row(children: [
                            SizedBox(
                              width: 100,
                              child:
                                  "Total".text.bold.color(darkFontGrey).make(),
                            ),
                            "${controller.totalPrice.value}"
                                .numCurrency
                                .text
                                .color(redColor)
                                .size(16)
                                .fontFamily(bold)
                                .make(),
                          ]).box.padding(EdgeInsets.all(8)).make(),
                        ]).box.padding(EdgeInsets.all(8)).make(),
                      ),
                      //Description section
                      10.heightBox,
                      'Description'.text.bold.make(),
                      10.heightBox,
                      "${data['p_description']}"
                          .text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .make(),
                      //button section
                      10.heightBox,
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          itemButtonDetail.length,
                          (index) => ListTile(
                            title: itemButtonDetail[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            trailing: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ),

                      //product may you like
                      20.heightBox,
                      productlike.text.size(16).color(darkFontGrey).make(),
                      10.heightBox,
                      //copy from home screen
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              6,
                              (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(imgP1,
                                          width: 150, fit: BoxFit.cover),
                                      10.heightBox,
                                      "Laptop 1TB hardDisk"
                                          .text
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "Rs 889989".text.color(Colors.red).make(),
                                    ],
                                  )
                                      .box
                                      .white
                                      .roundedSM
                                      .padding(const EdgeInsets.all(4))
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .make()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: buttonWidget(
                  color: redColor,
                  textcolor: whiteColor,
                  title: "Add to Cart",
                  onpress: () {
                    if (controller.quatinty > 0) {
                      controller.addToCart(
                          context: context,
                          vendorID: data['vendor_id'],
                          color: data['p_colors'][controller.colorIndex.value],
                          img: data['p_imags'][0],
                          qty: controller.quatinty.value,
                          sellerName: data['p_saller'],
                          title: data['p_name'],
                          tprice: controller.totalPrice.value);
                      VxToast.show(context, msg: "Add to Cart");
                    } else {
                      VxToast.show(context, msg: "Quenty cant not be add 0");
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

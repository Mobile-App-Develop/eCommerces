import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marting/consts/consts.dart';
import 'package:marting/consts/style.dart';
import 'package:marting/firbase/controller/cart_controller.dart';
import 'package:marting/firbase/firbase_console.dart';
import 'package:marting/screens/profile/cart/shipping_screen.dart';
import 'package:marting/services/firbase_services.dart';
import 'package:marting/widgets/button.dart';
import 'package:marting/widgets/loading_indicator.dart';

class carts extends StatelessWidget {
  const carts({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: buttonWidget(
              color: redColor,
              onpress: () {
                Get.to(() => const ShippingDetails());
              },
              textcolor: whiteColor,
              title: "Proceed to Shopping"),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shoping  Cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: Firestoreservices.getcart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is empty".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                              "${data[index]['img']}",
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            title:
                                "${data[index]['title']} (x${data[index]['qty']})"
                                    .text
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                            subtitle: "${data[index]['tprice']}"
                                .numCurrency
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            trailing: Icon(
                              Icons.delete,
                              color: redColor,
                            ).onTap(() {
                              Firestoreservices.delectDoucment(data[index].id);
                            }),
                          );
                        },
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total Pricessss"
                              .text
                              .bold
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                          Obx(() => "${controller.totalp.value}"
                              .numCurrency
                              .text
                              .bold
                              .color(redColor)
                              .fontFamily(semibold)
                              .make()),
                        ],
                      )
                          .box
                          .padding(EdgeInsets.all(12))
                          .roundedSM
                          .color(golden)
                          .width(context.screenWidth - 60)
                          .make(),
                      10.heightBox,
                    ],
                  ),
                );
              }
            }));
  }
}

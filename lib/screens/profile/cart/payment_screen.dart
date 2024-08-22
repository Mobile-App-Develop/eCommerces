import 'package:marting/consts/consts.dart';
import 'package:marting/consts/list.dart';
import 'package:marting/firbase/controller/cart_controller.dart';
import 'package:marting/screens/home_files/home.dart';
import 'package:marting/screens/home_files/home_screen.dart';
import 'package:marting/widgets/loading_indicator.dart';

import '../../../widgets/button.dart';

class paymentmethods extends StatelessWidget {
  const paymentmethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
          backgroundColor: whiteColor,
          bottomNavigationBar: SizedBox(
            height: 60,
            child: controller.placingOrder.value
                ? Center(
                    child: loadingIndicator(),
                  )
                : buttonWidget(
                    onpress: () async {
                      await controller.placeMyOrder(
                          orderPyamentMethod:paymentMethods[
                          controller.paymentindex.value],
                          totalAmount: controller.totalp.value);
                      await controller.clearCart();
                      VxToast.show(context, msg: "Order Placed Successfully");
                       Get.offAll( homes());
                    },
                    color: redColor,
                    textcolor: whiteColor,
                    title: "Place  my order..."),
          ),
          appBar: AppBar(
            title: "Chose Payment Methodsss".text.make(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx(
              () => Column(
                children: List.generate(paymentMethodImg.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      controller.changPaymentIndex(index);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: controller.paymentindex.value == index
                                ? redColor
                                : Colors.transparent,
                            width: 4,
                          )),
                      child: Stack(alignment: Alignment.topRight, children: [
                        Image.asset(
                          paymentMethodImg[index],
                          width: double.infinity,
                          height: 120,
                          colorBlendMode: controller.paymentindex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentindex.value == index
                              ? Colors.black.withOpacity(0.4)
                              : Colors.transparent,
                          fit: BoxFit.cover,
                        ),
                        controller.paymentindex.value == index
                            ? Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                    activeColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    value: true,
                                    onChanged: (value) {}),
                              )
                            : Container(),
                        Positioned(
                            bottom: 0,
                            right: 10,
                            child: paymentMethods[index]
                                .text
                                .color(Colors.white)
                                .size(16)
                                .make()),
                      ]),
                    ),
                  );
                }),
              ),
            ),
          )),
    );
  }
}

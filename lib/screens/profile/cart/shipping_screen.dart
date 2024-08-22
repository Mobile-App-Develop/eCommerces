import 'package:marting/consts/consts.dart';
import 'package:marting/firbase/controller/cart_controller.dart';
import 'package:marting/screens/profile/cart/payment_screen.dart';
import 'package:marting/widgets/button.dart';
import 'package:marting/widgets/custom_Textfield.dart';
class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller =Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info".text.make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: buttonWidget(
          onpress: (){
            if(controller.addressController.text.length >10 ){
              Get.to(() => paymentmethods());
            }else{
            VxToast.show(context, msg: "Please fill the  form");}


          },
          color: redColor,
          textcolor: whiteColor,
          title: "Continue..."),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextField(hint: "Address", isPass: false, title: "Address",controller: controller.addressController),
            customTextField(hint: "City",isPass: false,title: "City", controller: controller.cityController),
            customTextField(hint: "State",isPass: false, title: "State", controller: controller.stateController),
            customTextField(hint: "Postal Code", isPass: false, title: "Postal Code", controller: controller.postalCodeController),
            customTextField(hint: "Phone", isPass: false, title: "Phone", controller: controller.phoneController)
          ],
        ),
      ),


    );
  }
}

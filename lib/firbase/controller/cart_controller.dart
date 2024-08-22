import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marting/consts/consts.dart';
import 'package:marting/firbase/firbase_console.dart';
import 'package:marting/screens/home_files/home_controller.dart';

class CartController extends GetxController {
  var totalp = 0.obs;

  //text controllers for shipping details
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentindex = 0.obs;
  late dynamic productSnapshot;
  var products = [];
  var vendors = [];

  var placingOrder = false.obs;

  calculate(data) {
    totalp.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalp.value = totalp.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changPaymentIndex(index) {
    paymentindex.value = index;
  }

  placeMyOrder({required orderPyamentMethod, required totalAmount}) async {
    placingOrder(true);
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_by': currentUser!.uid,
      'order_by_address': addressController.text,
      'order_by_city': cityController.text,
      'order_by_email': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_phone': phoneController.text,
      'order_by_postalcode': postalCodeController.text,
      'order_by_state': stateController.text,
      'order_code': '0938833',
      'order_confirmed': false,
      'order_date': FieldValue.serverTimestamp(),
      'order_delivered': false,
      'order_placed': true,
      'orders': FieldValue.arrayUnion(products),
      'shipping_method': "Home Dilevery",
      'payment_method': orderPyamentMethod,
      'order_on_delivered': false,
      'total_amount': totalAmount,
      'vendors': FieldValue.arrayUnion(vendors),
    });
    placingOrder(false);
  }

  getProductDetails() {
    vendors.clear();
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'tprice': productSnapshot[i]['tprice']
      });
      vendors.add(productSnapshot[i]['vendor_id']);
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}

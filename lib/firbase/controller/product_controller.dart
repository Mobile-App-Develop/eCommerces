import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marting/consts/consts.dart';
import 'package:marting/firbase/firbase_console.dart';
import 'package:marting/model/catagory_model.dart';
import 'package:marting/model/catagory_model.dart';
import 'package:marting/model/catagory_model.dart';

import '../../model/catagory_model.dart';
import '../../model/catagory_model.dart';
import '../../model/catagory_model.dart';

class ProductController extends GetxController {
  var quatinty = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var subcat = [];
  var isFav = false.obs;

  getSubCatagories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/catgory_model.json");
    var decoded = catagoryModelFromJson(data);
    var s = decoded.catagory.where((element) => element.name == title).toList();
    for (var e in s[0].subcatagory) {
      subcat.add(e);
    }
  }

  changColorIndex(index) {
    colorIndex.value = index;
  }

  increaseQuenty(totalQuanty) {
    if (quatinty.value < totalQuanty) {
      quatinty.value++;
    }
  }

  decreaseQuenty() {
    if (quatinty.value > 0) {
      quatinty.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quatinty.value;
  }

  addToCart({title, img, sellerName, color, qty, tprice, context, vendorID}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellerName': sellerName,
      'color': color,
      'qty': qty,
      'vendor_id':vendorID,
      'tprice': tprice,
      'added_by': currentUser!.uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }
  resetValue(){
    totalPrice.value=0;
    quatinty.value=0;
    colorIndex.value=0;
  }
  addToWishList(docId,context)async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayUnion([currentUser!.uid
      ])
    },SetOptions(merge: true));
    isFav (true);
    VxToast.show(context, msg: "Added to Wishlist");

  }
  removeFromWishList(docId, context)async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayRemove([currentUser!.uid
      ])
    },SetOptions(merge: true));
    isFav (false);
VxToast.show(context, msg: "Remove from Wishlist");

  }
  checkIffav(data)async{
    if(data['p_wishlist'].contains(currentUser!.uid)){
      isFav(true);
    }else{
      isFav(false);
    }

  }
}

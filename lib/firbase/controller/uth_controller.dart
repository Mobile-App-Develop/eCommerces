import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:marting/consts/consts.dart';
import 'package:marting/firbase/firbase_console.dart';

class AuthController extends GetxController {
  var isloading=false.obs;
//Text controoler
var emailController =TextEditingController();
var passwordController =TextEditingController();

  // login method
  Future<UserCredential?> loginMethod({ context}) async {
    UserCredential? userCredential;
    try {
      await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

// Signup method
Future<UserCredential?> signupMethod({email, password, context}) async {
  UserCredential? userCredential;
  try {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    VxToast.show(context, msg: e.toString());
  }
  return userCredential;
}
//storing data method

storeUserData({name, password, email}) async {
  DocumentReference store = await firestore.collection(usersCollection).doc(
      currentUser!.uid);
  store.set({
    'name': name,
    'password': password,
    'email': email,
    'imgurl': '',
    'id': currentUser!.uid,
    'cart_count' : '00',
    'order_count' : '00',
    'wish_list' : '00',



  });
}

//signout method

signoutMethod(context) async {
  try {
    await auth.signOut();
  }
  catch
  (  e  ){VxToast.show(context, msg: e.toString());
}}}
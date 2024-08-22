import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore= FirebaseFirestore.instance;
User? currentUser = auth.currentUser;
//collection
const usersCollection ="users";
const productsCollection="product2";
const cartCollection="cart";
const chatCollection="Chats";
const messageCollection="Messages";

const ordersCollection="Orders";


import 'package:marting/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:marting/firbase/firbase_console.dart';
import 'package:marting/screens/home_files/home_controller.dart';

class ChatsController extends GetxController {
  @override
  void onInit() {
    getchatId();
    super.onInit();
  }
  var chats = firestore.collection(chatsCollection);
  var frindName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var senderName = Get
      .find<HomeController>()
      .username;
  var currentId = currentUser!.uid;
  var messageController = TextEditingController();
  dynamic chatDocId;
  var isLoading = false.obs;
  getchatId() async {
    isLoading(true);
    await chats.where('users', isEqualTo: {
      friendId: null,
      currentId: null
    }
    ).limit(1).get().then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        chatDocId = snapshot.docs.single.id;
      } else {
        chats.add({
          'created_on': null,
          'last_msg': '',
          'users': {friendId: null, currentId: null},
          'told': '',
          'fromId': '',
          'friend_name': frindName,
          'sender_name': senderName,
        }).then((value) {
          {
            chatDocId = value.id;
          }
        }
        );
      }
    });
    isLoading(false);
  }

  sendMsg(String msg) async {
    if (msg
        .trim()
        .isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'told': friendId,
        'fromId': currentId,
      });
      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,

      });
    }
  }
}





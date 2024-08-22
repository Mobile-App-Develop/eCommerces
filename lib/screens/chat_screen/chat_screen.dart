import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marting/consts/consts.dart';
import 'package:marting/consts/style.dart';
import 'package:marting/firbase/controller/chat_controller.dart';
import 'package:marting/firbase/firbase_console.dart';
import 'package:marting/screens/chat_screen/component/sender_bubles.dart';
import 'package:marting/services/firbase_services.dart';
import 'package:marting/widgets/loading_indicator.dart';

class Chat_Screen extends StatelessWidget {
  const Chat_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "${controller.frindName}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: loadingIndicator(),
                    )
                  : Expanded(
                      child:
                      StreamBuilder(
                          stream: Firestoreservices.getChatMessages(
                              controller.chatDocId.toString()),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: loadingIndicator(),
                              );
                            } else if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: "Send a Message....".text.make(),
                              );
                            } else {
                              return ListView(
                                children:
                                snapshot.data!.docs
                                    .mapIndexed((currentValue, index) {
                                  var data = snapshot.data!.docs[index];

                                  return Align ( alignment:
                                      data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                                  child: senderBubble(data));
                                }).toList(),
                              );
                            }
                          }),
                    ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controller.messageController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey)),
                      hintText: "Type a message....."),
                )),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.messageController.text);
                      controller.messageController.clear();
                    },
                    icon: Icon(Icons.send, color: redColor)),
              ],
            )
                .box
                .height(80)
                .padding(EdgeInsets.all(12))
                .margin(EdgeInsets.only(bottom: 8))
                .make(),
          ],
        ),
      ),
    );
  }
}

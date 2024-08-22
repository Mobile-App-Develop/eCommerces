import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marting/consts/consts.dart';
import 'package:marting/consts/style.dart';
import 'package:marting/screens/chat_screen/chat_screen.dart';
import 'package:marting/services/firbase_services.dart';
import 'package:marting/widgets/loading_indicator.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "My Messages".text.fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: Firestoreservices.getAllMessages(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Messages Yet".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int indext) {
                        return Card(
                          child: ListTile(
                              onTap: () {
                                Get.to(
                                  () => Chat_Screen(),
                                  arguments: [
                                    data[indext]['friend_name'],
                                    data[indext]['told'],
                                  ],
                                );
                              },
                              leading: CircleAvatar(
                                backgroundColor: redColor,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              title: "${data[indext]['friend_name']}"
                                  .text
                                  .bold
                                  .make(),
                              subtitle:
                                  "${data[indext]['last_msg']}".text.make()),
                        );
                      },
                    ))
                  ],
                ),
              );
            }
          }),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marting/consts/consts.dart';
import 'package:marting/consts/style.dart';
import 'package:marting/services/firbase_services.dart';
import 'package:marting/widgets/loading_indicator.dart';

import 'order_detail.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "My Orders".text.fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: Firestoreservices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Orders Yet".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: "${index + 1}".text.color(darkFontGrey).xl.make(),
                  title: data[index]['order_code']
                      .toString()
                      .text
                      .color(redColor)
                      .make(),
                  subtitle: data[index]['total_amount']
                      .toString()
                      .numCurrency
                      .text
                      .make(),
                  trailing: IconButton(
                      onPressed: () {
                        Get.to(() => OrderDetails(
                              data: data[index],
                            ));
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.green,
                      )),
                );
              },
            );
          }
        },
      ),
    );
  }
}

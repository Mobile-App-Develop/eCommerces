import 'package:intl/intl.dart' as intl;
import 'package:marting/consts/consts.dart';
import 'package:marting/consts/style.dart';
import 'package:marting/screens/order_screen/compnent_order/order_place_detail.dart';
import 'package:marting/screens/order_screen/compnent_order/order_status.dart';

class OrderDetails extends StatelessWidget {
  final dynamic data;

  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Orders Detail"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(children: [
            orderStatus(
                color: redColor,
                icon: Icons.done,
                title: "Placed",
                showDone: data['order_placed']),
            orderStatus(
                color: Colors.blue,
                icon: Icons.thumb_up,
                title: "Confirmed",
                showDone: data['order_confirmed']),
            orderStatus(
                color: redColor,
                icon: Icons.car_crash,
                title: "On Dilivery",
                showDone: data['order_on_delivered']),
            orderStatus(
                color: redColor,
                icon: Icons.done_all_rounded,
                title: "Dilivery",
                showDone: data['order_delivered']),
            Divider(),
            10.heightBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                orderPlaceDetail(
                  title_1: "Order Code",
                  det_1: data['order_code'],
                  title_2: "Shipping Method",
                  det_2: data['shipping_method'],
                ),
                orderPlaceDetail(
                  title_1: "Order Date",
                  det_1: intl.DateFormat()
                      .add_yMd()
                      .format((data['order_date'].toDate())),
                  title_2: "Payment Method",
                  det_2: data['payment_method'],
                ),
                orderPlaceDetail(
                  title_1: "Payment Status",
                  det_1: "Unpaid",
                  title_2: "Dilivery Status",
                  det_2: ''
                      'Order placed',
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 56.0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          "Shipping  Address".text.bold.make(),
                          "${data['order_by_name']}".text.make(),
                          "${data['order_by_email']}".text.make(),
                          "${data['order_by_address']}".text.make(),
                          "${data['order_by_city']}".text.make(),
                          "${data['order_by_state']}".text.make(),
                          "${data['order_by_phone']}".text.make(),
                          "${data['order_by_postalcode']}".text.make(),
                        ],
                      ),
                      SizedBox(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Total Amount".text.bold.make(),
                            "${data['total_amount']}"
                                .text
                                .color(redColor)
                                .bold
                                .make()
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ).box.outerShadowMd.color(Colors.white).make(),
            Divider(),
            10.heightBox,
            "Ordered Product".text.size(18).color(darkFontGrey).makeCentered(),
            10.heightBox,
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(data['orders'].length, (index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetail(
                          title_1: data['orders'][index]['title'],
                          title_2: data['orders'][index]['tprice'],
                          det_1: "${data['orders'][index]['qty']}x",
                          det_2: "Refundable"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 56.0),
                        child: Container(
                          height: 20,
                          width: 30,
                          color: Color(data['orders'][index]['color']),
                        ),
                      ),
                      Divider(),
                    ]);
              }).toList(),
            ).box.outerShadowMd.white.margin(EdgeInsets.only(bottom: 4)).make(),
            20.heightBox,
          ]),
        ),
      ),
    );
  }
}

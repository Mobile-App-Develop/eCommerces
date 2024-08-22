import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marting/consts/consts.dart';
import 'package:marting/services/firbase_services.dart';
import 'package:marting/widgets/loading_indicator.dart';

import '../../consts/style.dart';
import '../catagory_files/item_detail.dart';

class SearchScreen extends StatelessWidget {
  final String? title;

  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: title!.text.color(darkFontGrey).make(),
        ),
        body: FutureBuilder(
          future: Firestoreservices.searchProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Product Found".text.makeCentered();
            } else {
              var data = snapshot.data!.docs;
              var filtered = data
                  .where(
                    (element) => element['p_name']
                        .toString()
                        .toLowerCase()
                        .contains(title!.toLowerCase()),
                  )
                  .toList();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 300),
                    children: filtered
                        .mapIndexed(
                          (currentValue, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(filtered[index]['p_imags'][0],
                                  width: 130, height: 130, fit: BoxFit.cover),
                              Spacer(),
                              "${filtered[index]['p_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "${filtered[index]['p_price']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(redColor)
                                  .make(),
                            ],
                          )
                              .box
                              .white
                              .roundedSM
                              .padding(EdgeInsets.all(12))
                              .margin(EdgeInsets.symmetric(horizontal: 4))
                              .make()
                              .onTap(() {
                            Get.to(() => itemDetail(
                                  title: "${filtered[index]['p_name']}",
                                  data: filtered[index],
                                ));
                          }),
                        )
                        .toList()),
              );
            }
          },
        ));
  }
}

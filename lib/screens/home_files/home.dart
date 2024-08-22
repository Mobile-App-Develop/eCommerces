import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marting/consts/consts.dart';
import 'package:marting/consts/list.dart';
import 'package:marting/consts/style.dart';
import 'package:marting/screens/catagory_files/item_detail.dart';
import 'package:marting/screens/home_files/search_screen.dart';
import 'package:marting/services/firbase_services.dart';
import 'package:marting/widgets/featurebutton.dart';
import 'package:marting/widgets/home_button.dart';
import 'package:marting/widgets/loading_indicator.dart';

import 'home_controller.dart';

class homes extends StatefulWidget {
  const homes({super.key});

  @override
  State<homes> createState() => _homeState();
}

class _homeState extends State<homes> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();

    return Container(
      padding: EdgeInsets.all(12),
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search).onTap(() {
                    if (controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                            title: controller.searchController.text,
                          ));
                    }
                  }),
                  filled: true,
                  fillColor: lightGrey,
                  hintText: searchanythig,
                  hintStyle: TextStyle(
                    color: textfieldGrey,
                  ),
                ),
              ),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: sliderlist.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Image.asset(
                            sliderlist[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .roundedSM
                              .margin(EdgeInsets.symmetric(horizontal: 16))
                              .make(),
                        );
                      }),
                  10.heightBox,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          2,
                          (index) => homeButton(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 2.5,
                              icon: index == 0 ? icTodaysDeal : icFlashDeal,
                              title: index == 0 ? todayadeal : flashsale))),
                  10.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: sliderlist2.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Image.asset(
                            sliderlist2[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .roundedSM
                              .margin(EdgeInsets.symmetric(horizontal: 16))
                              .make(),
                        );
                      }),
                  10.heightBox,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => homeButton(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth / 3.5,
                                icon: index == 0
                                    ? icTopCategories
                                    : index == 1
                                        ? icBrands
                                        : icWholeSale,
                                title: index == 0
                                    ? icTopCategories
                                    : index == 1
                                        ? brand
                                        : topsaller,
                              ))),
                  10.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: featurecatagory.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make()),
                  10.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  featureButton(
                                      icon: featureimg1[index],
                                      title: featuretitle1[index]),
                                  10.heightBox,
                                  featureButton(
                                      icon: featureimg2[index],
                                      title: featuretitle2[index]),
                                ],
                              )),
                    ),
                  ),
                  20.heightBox,
                  Container(
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: redColor,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          featureproduct.text.white
                              .size(18)
                              .fontFamily(bold)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                                future: Firestoreservices.getFeaturedProducts(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: loadingIndicator(),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return "No Featured Product"
                                        .text
                                        .white
                                        .makeCentered();
                                  } else {
                                    var featuredData = snapshot.data!.docs;
                                    return Row(
                                      children: List.generate(
                                        featuredData.length,
                                        (index) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                                featuredData[index]['p_imags']
                                                    [0],
                                                width: 130,
                                                height: 130,
                                                fit: BoxFit.cover),
                                            10.heightBox,
                                            "${featuredData[index]['p_name']}"
                                                .text
                                                .fontFamily(semibold)
                                                .color(darkFontGrey)
                                                .make(),
                                            10.heightBox,
                                            "${featuredData[index]['p_price']}"
                                                .text
                                                .fontFamily(semibold)
                                                .color(redColor)
                                                .make(),
                                          ],
                                        )
                                            .box
                                            .rounded
                                            .white
                                            .margin(EdgeInsets.symmetric(
                                                horizontal: 4))
                                            .padding(EdgeInsets.all(8))
                                            .make()
                                            .onTap(() {
                                          Get.to(() => itemDetail(
                                                title:
                                                    "${featuredData[index]['p_name']}",
                                                data: featuredData[index],
                                              ));
                                        }),
                                      ),
                                    );
                                  }
                                }),
                          ),
                        ]),
                  ),
                  20.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: sliderlist2.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Image.asset(
                            sliderlist2[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .roundedSM
                              .margin(EdgeInsets.symmetric(horizontal: 16))
                              .make(),
                        );
                      }),
                  //All products section
                  20.heightBox,
                  StreamBuilder(
                      stream: Firestoreservices.allProducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndicator();
                        } else {
                          var allproductsData = snapshot.data!.docs;
                          return GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allproductsData.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 300),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                        allproductsData[index]['p_imags'][0],
                                        width: 130,
                                        height: 130,
                                        fit: BoxFit.cover),
                                    Spacer(),
                                    "${allproductsData[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "${allproductsData[index]['p_price']}"
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
                                        title:
                                            "${allproductsData[index]['p_name']}",
                                        data: allproductsData[index],
                                      ));
                                });
                              });
                        }
                      })
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

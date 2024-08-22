import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marting/consts/consts.dart';
import 'package:marting/consts/style.dart';
import 'package:marting/firbase/controller/profile_controller.dart';
import 'package:marting/firbase/controller/uth_controller.dart';
import 'package:marting/firbase/firbase_console.dart';
import 'package:marting/screens/login.dart';
import 'package:marting/screens/profile/edit_profile.dart';
import 'package:marting/services/firbase_services.dart';
import 'package:marting/widgets/bg_widget.dart';
import 'package:marting/widgets/loading_indicator.dart';

import '../../consts/list.dart';
import '../../widgets/detailcart.dart';
import '../chat_screen/messaging_screen.dart';
import '../order_screen/order_screen.dart';
import '../wish_list/wish_list.dart';

class accounts extends StatefulWidget {
  const accounts({super.key});

  @override
  State<accounts> createState() => _accountState();
}

class _accountState extends State<accounts> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(profileController());
    return bgwidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: Firestoreservices.getuser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                child: Column(
                  children: [
                    //edit profile section
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          )).onTap(() {
                        controller.nameController.text = data["name"];

                        Get.to(() => Edit_profile_screen(data: data));
                      }),
                    ),

                    //user detail section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          data['imgurl'] == ''
                              ? Image.asset(imgProfile2,
                                      width: 100, fit: BoxFit.cover)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make()
                              : Image.network(data['imgurl'],
                                      width: 100, fit: BoxFit.cover)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make(),
                          10.widthBox,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .white
                                  .make(),
                              "${data['email']}".text.white.make(),
                            ],
                          )),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.white),
                            ),
                            onPressed: () async {
                              await Get.put(AuthController())
                                  .signoutMethod(context);
                              Get.offAll(() => LoginScreen());
                            },
                            child:
                                "Logout".text.fontFamily(semibold).white.make(),
                          ),
                        ],
                      ),
                    ),
                    20.heightBox,
                    FutureBuilder(
                      future: Firestoreservices.getCounts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: loadingIndicator(),
                          );
                        } else {
                          var countData = snapshot.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detailcart(
                                  count: countData[0].toString(),
                                  title: "In your Cart",
                                  width: context.screenWidth / 3.4),
                              detailcart(
                                  count: countData[1].toString(),
                                  title: "In your Wish List",
                                  width: context.screenWidth / 3.4),
                              detailcart(
                                  count: countData[2].toString(),
                                  title: "In your Order",
                                  width: context.screenWidth / 3.4),
                            ],
                          );
                        }
                      },
                    ),

                    ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: lightGrey,
                              );
                            },
                            itemCount: profileButtonList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Get.to(() => OrderScreen());
                                      break;
                                    case 1:
                                      Get.to(() => WishListScreen());
                                      break;
                                    case 2:
                                      Get.to(() => MessagesScreen());
                                      break;
                                  }
                                },
                                leading: Image.asset(
                                  profileButtonIcons[index],
                                  width: 22,
                                ),
                                title: "${profileButtonList[index]}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                              );
                            })
                        .box
                        .rounded
                        .white
                        .margin(EdgeInsets.all(12))
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .shadowSm
                        .make()
                        .box
                        .color(redColor)
                        .make(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

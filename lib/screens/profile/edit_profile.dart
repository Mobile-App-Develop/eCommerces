import 'dart:io';
import 'package:flutter/material.dart';
import 'package:marting/consts/consts.dart';
import 'package:marting/firbase/controller/profile_controller.dart';
import 'package:marting/widgets/bg_widget.dart';
import 'package:marting/widgets/button.dart';
import 'package:marting/widgets/custom_Textfield.dart';

class Edit_profile_screen extends StatelessWidget {
  final dynamic data;

  const Edit_profile_screen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<profileController>();
    // controller.nameController.text=data['name'];
    // controller.passController.text=data['password'];

    return bgwidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //if data image url and controller path is empty
            data['imgurl'] == '' && controller.profileImagePath.isEmpty
                ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make()
                //if data is not empty butt controller path is empty

                : data['imgurl'] != '' &&  controller.profileImagePath.isEmpty
                    ? Image.network(
                        data['imgurl'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    //if both are  empty
                    : Image.file(
                        File(controller.profileImagePath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            buttonWidget(
                color: redColor,
                onpress: () {
                  controller.changeImage(context);
                },
                title: "change"),
            Divider(),
            20.heightBox,
            customTextField(
                controller: controller.nameController,
                hint: namehint,
                title: name,
                isPass: false),
            10.heightBox,
            customTextField(
                controller: controller.oldpassController,
                hint: passwordhint,
                title: oldpass,
                isPass: true),
            10.heightBox,
            customTextField(
                controller: controller.newpassController,
                hint: passwordhint,
                title: newpass,
                isPass: true),
            20.heightBox,
            controller.isloading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: buttonWidget(
                        color: redColor,
                        onpress: () async {


                          controller.isloading(true);
                          //if image is not selected
                          if(controller.profileImagePath.value.isNotEmpty){
                            await controller.uploadProfileImage();
                          }else{
                            controller.profileImageLink=data['imgurl'];
                          }
                          //if old password matches with database
                          if( data['password']==controller.oldpassController.text){
                            await controller.changeAuthPassword(
                              email: data['email'],
                              password: controller.oldpassController.text,
                              newpassword: controller.newpassController.text

                            );
                            await controller.updateProfile(
                                imgUrl: controller.profileImageLink,
                                name: controller.nameController.text,
                                password: controller.newpassController.text);
                            VxToast.show(context, msg: "Updated");
                          }else{
                            VxToast.show(context, msg: "Wrong Old Password");
                            controller.isloading(false);
                          }
                         },
                        textcolor: whiteColor,
                        title: "Save")),
          ],
        )
            .box
            .shadowSm
            .white
            .roundedSM
            .padding(EdgeInsets.all(16))
            .margin(EdgeInsets.only(top: 50, left: 10, right: 10))
            .make(),
      ),
    ));
  }
}

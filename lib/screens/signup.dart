import 'package:marting/consts/consts.dart';
import 'package:marting/consts/style.dart';
import 'package:marting/firbase/controller/uth_controller.dart';
import 'package:marting/screens/home_files/home.dart';
import 'package:marting/widgets/bg_widget.dart';
import 'package:marting/widgets/button.dart';
import 'package:marting/widgets/custom_Textfield.dart';
import '../firbase/firbase_console.dart';
import '../widgets/app_logo.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordretypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgwidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                (context.screenWidth * 0.1).heightBox,
                applogowidget(),
                10.heightBox,
                "log in to $appname".text.white.make(),
                10.heightBox,
                Obx(()=>
                   Column(
                    children: [
                      customTextField(title: name,
                          hint: namehint,
                          controller: nameController, isPass:false),
                      customTextField(title: email,
                          hint: emailhint,
                          controller: emailController, isPass:false),
                      customTextField(title: password,
                          hint: passwordhint,
                          controller: passwordController, isPass:true),
                      customTextField(title: retypepassword,
                          hint: passwordhint,
                          controller: passwordretypeController, isPass:true),


                      10.heightBox,
                      Row(
                          children: [
                            Checkbox(
                                checkColor: redColor,
                                value: isCheck,
                                onChanged: (newValue) {
                                  setState(() {

                                  });
                                  isCheck = newValue;
                                }),


                            Expanded(
                              child: RichText(text: TextSpan(children: [
                                TextSpan(
                                    text: "I agree to the ", style: TextStyle(
                                  fontFamily: bold, color: fontGrey,
                                )),
                                TextSpan(text: termcontion, style: TextStyle(
                                  fontFamily: bold, color: redColor,
                                )),
                                TextSpan(text: " & ", style: TextStyle(
                                  fontFamily: bold, color: Colors.black,
                                )),
                                TextSpan(text: privacypolicy, style: TextStyle(
                                  fontFamily: bold, color: Colors.red,
                                )),
                              ])),
                            ),
                          ]),
                      10.heightBox,
                       controller.isloading.value? const CircularProgressIndicator(
                         valueColor: AlwaysStoppedAnimation(redColor),):
                       buttonWidget(
                          color: isCheck == true ? golden : lightGrey,
                          textcolor: whiteColor,
                          title: signups,
                          onpress: () async {
                            if(isCheck != false){
                              controller.isloading(true);
                              try{
                                await controller.signupMethod(context: context,
                                    email: emailController.text,
                                    password: passwordController.text).then((
                                    value) {
                                  return controller.storeUserData(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text);
                                }

                                ).then((value){
                                  VxToast.show(context, msg: logged);
                                  Get.offAll(()=>const homes());
                                });
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                                controller.isloading(false);
                              }
                            }
                            Get.to(() => const Signup());
                          }).box.width(context.screenWidth - 50).make(),
                      10.heightBox,

                      RichText(text: TextSpan(children: [
                        TextSpan(text: "Already have a Account",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(text: login, style: TextStyle(
                            color: redColor
                        )),


                      ])).onTap(() {
                        Get.back();
                      })


                    ],
                  )
                      .box
                      .rounded
                      .white
                      .padding(EdgeInsets.all(16))
                      .width(context.width - 70)
                      .make(),
                ),
              ],
            ),
          ),
        ));
  }
}

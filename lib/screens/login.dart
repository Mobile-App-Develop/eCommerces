import 'package:marting/consts/consts.dart';
import 'package:marting/consts/list.dart';
import 'package:marting/firbase/controller/uth_controller.dart';
import 'package:marting/screens/home_files/home.dart';
import 'package:marting/screens/home_files/home_screen.dart';
import 'package:marting/screens/signup.dart';
import 'package:marting/widgets/bg_widget.dart';
import 'package:marting/widgets/button.dart';
import 'package:marting/widgets/custom_Textfield.dart';
import '../widgets/app_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var controller =Get.put(AuthController());
    return bgwidget(
        child: Scaffold(resizeToAvoidBottomInset: false,
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
                  customTextField(title: email, hint: emailhint,isPass:false, controller: controller.emailController),
                  customTextField(title: password, hint: passwordhint, isPass:true, controller: controller.passwordController),
                  10.heightBox,
                  Align(
                      alignment: Alignment.topRight,
                      child: forgetpassword.text.make()),
                  10.heightBox,
                  controller.isloading.value? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ):
                  buttonWidget(

                          color: redColor,
                          textcolor: whiteColor,
                          title: login,
                          onpress: ()async {
                            controller.isloading(true);
                            await controller.loginMethod(context: context).then((value) {
                              if(value != null){
                                VxToast.show(context, msg: logged);
                                Get.offAll(()=> const homes());
                                // Get.to(()=>const HomeScreen());

                              }else{
                                controller.isloading(false);
                              }
                            });

                          })
                      .box
                      .roundedFull
                      .width(context.screenWidth - 50)
                      .make(),
                  10.heightBox,
                  notlogin.text.make(),

                  10.heightBox,
                  buttonWidget(
                      color: golden,
                      textcolor: whiteColor,
                       title: signups,
                      onpress: () {
                        Get.to(() => const Signup());
                      })
                      .box
                      .roundedFull
                      .width(context.screenWidth - 50)
                      .make(),
                  10.heightBox,
                  loginwith.text.make(),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    List.generate(3, (index) => CircleAvatar(backgroundColor: lightGrey,
                      radius: 25,
                      child: Image.asset(sociallist[index],width: 25,


                      ),
                    )
                  ),),

                ],
              )
                  .box
                  .rounded
                  .white
                  .padding(const EdgeInsets.all(16))
                  .width(context.width - 70)
                  .make(),
            ),
          ],
        ),
      ),
    ));
  }
}

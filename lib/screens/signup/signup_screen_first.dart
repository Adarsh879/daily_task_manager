import 'package:daily_task_manager/controller/auth_controller.dart';
import 'package:daily_task_manager/controller/form_controllers/login_form_controller.dart';
import 'package:daily_task_manager/screens/login.dart';
import 'package:daily_task_manager/values/values.dart';
import 'package:daily_task_manager/widgets/clip_shadow_path.dart';
import 'package:daily_task_manager/widgets/custom_clipper.dart';
import 'package:daily_task_manager/widgets/custom_divider.dart';
import 'package:daily_task_manager/widgets/cutomButton.dart';
import 'package:daily_task_manager/widgets/loader.dart';
import 'package:daily_task_manager/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreenFirst extends StatelessWidget {
  const SignUpScreenFirst({super.key});

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    AuthController loginAuthController = Get.find<AuthController>();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          height: heightOfScreen,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: heightOfScreen * 0.5,
                  width: widthOfScreen,
                  decoration: const BoxDecoration(
                    gradient: Gradients.signupBackgroundGradient,
                  ),
                ),
              ),
              Positioned(
                child: ClipShadowPath(
                  shadow: const BoxShadow(
                    color: AppColors.deepLimeGreen,
                    offset: Offset(4, 4),
                    blurRadius: 4,
                    spreadRadius: 8,
                  ),
                  clipper: WaveShapeClipper(),
                  child: Container(
                    height: heightOfScreen * 0.9,
                    width: widthOfScreen,
                    decoration: const BoxDecoration(
                      gradient: Gradients.curvesGradient3,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () => Get.offAndToNamed('/login'),
                    icon: Icon(Icons.arrow_back),
                    style: ButtonStyle(
                      iconSize: MaterialStateProperty.all<double?>(30),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(AppColors.black),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 75,
                // left: 0,
                // right: 0,
                child: SizedBox(
                  width: widthOfScreen,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              StringConst.HELLO_2,
                              style: Styles.customTextStyle2(
                                  color: AppColors.white,
                                  fontSize: Sizes.HEADLINE_1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SpaceH16(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              StringConst.GET_STARTED,
                              style: Styles.customTextStyle2(
                                  color: AppColors.white,
                                  fontSize: Sizes.HEADLINE_2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SpaceH30(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomButton(
                                title: StringConst.SIGN_UP_2,
                                elevation: Sizes.ELEVATION_12,
                                textStyle: Styles.customTextStyle2(
                                    color: AppColors.deepLimeGreen,
                                    fontSize: Sizes.TEXT_SIZE_22),
                                color: AppColors.white,
                                onPressed: () => Get.toNamed("/signup2"),
                              ),
                              const SpaceH16(),
                              Text(
                                StringConst.OR,
                                style: Styles.customTextStyle(
                                    color: AppColors.white,
                                    fontSize: Sizes.HEADLINE_3),
                              ),
                              const SpaceH16(),
                              CustomButton(
                                title: StringConst.SIGN_UP_WITH_GOOGLE,
                                hasIcon: true,
                                color: AppColors.white,
                                elevation: Sizes.ELEVATION_12,
                                // borderRadius: Sizes.r,
                                borderSide: Borders.defaultPrimaryBorder,
                                textStyle: Styles.customTextStyle2(
                                    color: AppColors.blackShade5,
                                    fontSize: Sizes.HEADLINE_2),
                                icon: Image.asset(
                                  ImagePath.GOOGLE_LOGO,
                                  height: Sizes.HEIGHT_24,
                                  width: Sizes.WIDTH_24,
                                ),
                                onPressed: loginAuthController.signInWithGoogle,
                              ),
                              const SpaceH16(),
                              InkWell(
                                onTap: () => Get.offAllNamed("/login"),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            StringConst.ALREADY_HAVE_AN_ACCOUNT,
                                        style: Styles.customTextStyle(
                                          color: AppColors.black,
                                          fontSize: Sizes.TEXT_SIZE_16,
                                        ),
                                      ),
                                      TextSpan(
                                        text: StringConst.LOG_IN,
                                        style: Styles.customTextStyle(
                                          color: AppColors.deepDarkGreen,
                                          fontSize: Sizes.TEXT_SIZE_16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() =>
                  loginAuthController.isLoading.value ? Loader() : SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}

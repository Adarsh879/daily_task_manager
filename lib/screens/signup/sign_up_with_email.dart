import 'package:daily_task_manager/controller/auth_controller.dart';
import 'package:daily_task_manager/controller/form_controllers/login_form_controller.dart';
import 'package:daily_task_manager/controller/form_controllers/signup_form_controller.dart';
import 'package:daily_task_manager/values/values.dart';
import 'package:daily_task_manager/widgets/custom_clipper.dart';
import 'package:daily_task_manager/widgets/custom_text_form_field.dart';
import 'package:daily_task_manager/widgets/cutomButton.dart';
import 'package:daily_task_manager/widgets/loader.dart';
import 'package:daily_task_manager/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpEmail extends StatefulWidget {
  @override
  _SignUpEmailState createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  bool onCheck = false;
  final authController = Get.put(AuthController());
  final signUpFormController = Get.put(SignUpFormController());
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                child: ClipPath(
                  clipper: WaveShapeClipper1(),
                  child: Container(
                    height: heightOfScreen * 0.5,
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
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back),
                    style: ButtonStyle(
                      iconSize: MaterialStateProperty.all<double?>(30),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(AppColors.black),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(Sizes.PADDING_0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: heightOfScreen * 0.5 * 0.6,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: widthOfScreen * 0.15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            StringConst.SIGN,
                            style: Styles.customTextStyle(
                              fontSize: Sizes.HEADLINE_1,
                              color: AppColors.deepBrown,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: StringConst.SIG,
                                  style: Styles.customTextStyle(
                                    fontSize: Sizes.HEADLINE_1,
                                    color: Colors.transparent,
                                  ).copyWith(
                                    height: 0.7,
                                  ),
                                ),
                                TextSpan(
                                  text: StringConst.UP,
                                  style: Styles.customTextStyle(
                                    fontSize: Sizes.HEADLINE_1,
                                    color: AppColors.deepBrown,
                                  ).copyWith(
                                    height: 0.7,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: heightOfScreen * 0.05,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_20),
                      child: Form(
                        child: _buildForm(_formKey),
                        key: _formKey,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => authController.isLoading.value ? Loader() : SizedBox()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(GlobalKey<FormState> formKey) {
    ThemeData theme = Theme.of(context);
    var widthOfScreen = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        CustomTextFormField(
          hasTitle: true,
          title: StringConst.EMAIL_2,
          titleStyle: Styles.customTextStyle(
            fontSize: Sizes.TEXT_SIZE_14,
            color: AppColors.deepDarkGreen,
          ),
          textInputType: TextInputType.text,
          hintTextStyle: Styles.customTextStyle(
            color: AppColors.greyShade7,
          ),
          enabledBorder: Borders.customUnderlineInputBorder(
            color: AppColors.lighterBlue2,
          ),
          focusedBorder: Borders.customUnderlineInputBorder(
            color: AppColors.lightGreenShade1,
          ),
          textStyle: Styles.customTextStyle(
            color: AppColors.blackShade10,
          ),
          hintText: StringConst.EMAIL_HINT_TEXT,
          onChanged: (value) => signUpFormController.setEmail(value),
          validator: signUpFormController.validateEmail,
        ),
        SpaceH16(),
        CustomTextFormField(
          hasTitle: true,
          title: StringConst.PASSWORD,
          titleStyle: Styles.customTextStyle(
            fontSize: Sizes.TEXT_SIZE_14,
            color: AppColors.deepDarkGreen,
          ),
          textInputType: TextInputType.text,
          hintTextStyle: Styles.customTextStyle(
            color: AppColors.greyShade7,
          ),
          enabledBorder: Borders.customUnderlineInputBorder(
            color: AppColors.lighterBlue2,
          ),
          focusedBorder: Borders.customUnderlineInputBorder(
            color: AppColors.lightGreenShade1,
          ),
          textStyle: Styles.customTextStyle(
            color: AppColors.blackShade10,
          ),
          hintText: StringConst.PASSWORD_HINT_TEXT,
          obscured: true,
          maxLines: 1,
          onChanged: (value) => signUpFormController.setPassword(value),
          validator: signUpFormController.validatePassword,
        ),
        SpaceH16(),
        CustomTextFormField(
          hasTitle: true,
          title: StringConst.CONFIRM_PASSWORD,
          titleStyle: Styles.customTextStyle(
            fontSize: Sizes.TEXT_SIZE_14,
            color: AppColors.deepDarkGreen,
          ),
          textInputType: TextInputType.text,
          hintTextStyle: Styles.customTextStyle(color: AppColors.greyShade7),
          enabledBorder: Borders.customUnderlineInputBorder(
            color: AppColors.lighterBlue2,
          ),
          focusedBorder: Borders.customUnderlineInputBorder(
            color: AppColors.lightGreenShade1,
          ),
          textStyle: Styles.customTextStyle(color: AppColors.blackShade10),
          hintText: StringConst.PASSWORD_HINT_TEXT,
          obscured: true,
          maxLines: 1,
          onChanged: (value) => signUpFormController.setConfirmPassword(value),
          validator: signUpFormController.confirmPassword,
        ),
        const SpaceH30(),
        Container(
          width: widthOfScreen * 0.6,
          child: CustomButton(
            title: StringConst.SIGN_UP,
            color: AppColors.deepLimeGreen,
            elevation: Sizes.ELEVATION_16,
            textStyle: Styles.customTextStyle2(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: Sizes.HEADLINE_2,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                authController.signUp(signUpFormController.emailValue,
                    signUpFormController.passwordVaue);
              }
            },
          ),
        ),
        const SpaceH16(),
        InkWell(
          onTap: () => Get.offNamedUntil("/login", (route) => false),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: StringConst.ALREADY_HAVE_AN_ACCOUNT,
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
        )
      ],
    );
  }
}

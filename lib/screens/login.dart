import 'package:daily_task_manager/controller/auth_controller.dart';
import 'package:daily_task_manager/controller/form_controllers/login_form_controller.dart';
import 'package:daily_task_manager/controller/form_controllers/login_form_controller.dart';
import 'package:daily_task_manager/values/values.dart';
import 'package:daily_task_manager/widgets/custom_clipper.dart';
import 'package:daily_task_manager/widgets/custom_text_form_field.dart';
import 'package:daily_task_manager/widgets/cutomButton.dart';
import 'package:daily_task_manager/widgets/loader.dart';
import 'package:daily_task_manager/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool onCheck = false;
  final authController = Get.put(AuthController());
  final loginFormController = Get.put(LoginFormController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var heightOfScreen = MediaQuery.of(context).size.height;
    var widthOfScreen = MediaQuery.of(context).size.width;
    // GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    // loginAuthFormController.setFormKey(_formKey);

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
                  clipper: ReverseWaveShapeClipper(),
                  child: Container(
                    height: heightOfScreen * 0.5,
                    width: widthOfScreen,
                    decoration: BoxDecoration(
                      gradient: Gradients.curvesGradient3,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.all(Sizes.PADDING_0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: heightOfScreen * 0.5 * 0.90,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: widthOfScreen * 0.15),
                      child: Text(
                        StringConst.LOG_IN,
                        style: Styles.customTextStyle(
                          fontSize: Sizes.HEADLINE_1,
                          color: AppColors.deepBrown,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: heightOfScreen * 0.05,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_20),
                      child: Form(
                          // autovalidateMode: AutovalidateMode.always,
                          key: _formKey,
                          child: _buildForm()),
                    )
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

  Widget _buildForm() {
    ThemeData theme = Theme.of(context);
    var widthOfScreen = MediaQuery.of(context).size.width;
    var heightOfScreen = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        CustomTextFormField(
          hasTitle: true,
          title: StringConst.EMAIL_2,
          titleStyle: Styles.customTextStyle(
            color: AppColors.deepDarkGreen,
            fontSize: Sizes.TEXT_SIZE_14,
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
          onChanged: (value) => loginFormController.setEmail(value),
          validator: (value) => loginFormController.validateEmail(value),
        ),
        // Obx(
        //   () => Text(
        //     loginFormController.emailError.value ?? '',
        //     style: TextStyle(color: Colors.red),
        //   ),
        // ),
        SpaceH16(),
        CustomTextFormField(
          hasTitle: true,
          title: StringConst.PASSWORD,
          titleStyle: Styles.customTextStyle(
            color: AppColors.deepDarkGreen,
            fontSize: Sizes.TEXT_SIZE_14,
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
          onChanged: (value) => loginFormController.setPassword(value),
          validator: (value) => loginFormController.validatePassword(value),
          maxLines: 1,
        ),
        SpaceH20(),
        Container(
          width: widthOfScreen * 0.6,
          child: CustomButton(
            title: StringConst.LOG_IN_4,
            color: AppColors.deepLimeGreen,
            elevation: Sizes.ELEVATION_16,
            textStyle: Styles.customTextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: Sizes.TEXT_SIZE_16,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                authController.logIn(loginFormController.emailValue,
                    loginFormController.passwordVaue);
              }
            },
          ),
        ),
        const SpaceH16(),
        Text(
          StringConst.OR,
          style: Styles.customTextStyle(
              color: AppColors.black, fontSize: Sizes.HEADLINE_3),
        ),
        const SpaceH16(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              title: StringConst.SIGN_IN_WITH_GOOGLE,
              hasIcon: true,
              color: AppColors.white,
              elevation: Sizes.ELEVATION_12,
              // borderRadius: Sizes.r,
              borderSide: Borders.defaultPrimaryBorder,
              textStyle: Styles.customTextStyle2(
                  color: AppColors.blackShade5, fontSize: Sizes.HEADLINE_2),
              icon: Image.asset(
                ImagePath.GOOGLE_LOGO,
                height: Sizes.HEIGHT_24,
                width: Sizes.WIDTH_24,
              ),
              onPressed: authController.signInWithGoogle,
            ),
          ],
        ),
        SizedBox(
          height: heightOfScreen * 0.04,
        ),
        InkWell(
          onTap: () => Get.toNamed("/signup1"),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: StringConst.DONT_HAVE_AN_ACCOUNT,
                  style: Styles.customTextStyle(
                    color: AppColors.black,
                    fontSize: Sizes.TEXT_SIZE_16,
                  ),
                ),
                TextSpan(
                  text: StringConst.SIGN_UP,
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
        SpaceH16(),
      ],
    );
  }

  @override
  void dispose() {
    // loginAuthFormController.close();
    super.dispose();
  }
}

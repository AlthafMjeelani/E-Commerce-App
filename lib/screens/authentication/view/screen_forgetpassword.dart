import 'package:ecommerse/helpers/colors_widget.dart';
import 'package:ecommerse/helpers/spacing_widget.dart';
import 'package:ecommerse/screens/authentication/controller/forgot_password_provider.dart';
import 'package:ecommerse/screens/authentication/model/enum/otp_enum_model.dart';
import 'package:ecommerse/screens/authentication/view/screen_otp.dart';
import 'package:ecommerse/widget/long_button_widget.dart';
import 'package:ecommerse/widget/textfeild_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class ScreenForgrtPassword extends StatelessWidget {
  const ScreenForgrtPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final data =
        Provider.of<ScreenForgotPasswordProvider>(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.kBlackColor,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.kBgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextfeildWidget(
                controller: data.emailController,
                text: 'email',
                obscureText: false,
              ),
              AppSpacing.ksizedBox20,
              LongButtonWidget(
                text: 'Continue',
                onTap: () {
                  data.navigatorToOtp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

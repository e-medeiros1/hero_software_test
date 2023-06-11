import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_software_test/app/core/styles/color_style.dart';
import 'package:hero_software_test/app/core/styles/text_styles.dart';
import 'package:hero_software_test/app/core/widgets/custom_elevated_button.dart';

class PasswordConfirmationPage extends StatelessWidget {
  const PasswordConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quase tudo pronto!',
                  style: context.textStyles.textTitle
                      .copyWith(color: context.colors.secondary),
                ),
                const SizedBox(height: 20),
                Text(
                  'Cheque sua caixa de e-mails e siga os passos para alterar sua senha. Em seguida, faça o login novamente na nossa plataforma.',
                  style: context.textStyles.textRegular
                      .copyWith(fontSize: 18, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 20),
                const Spacer(),
                CustomElevatedButton(
                    onPressed: () => Get.offNamed('/login'),
                    buttonTitle: 'CONFIRMAR'),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

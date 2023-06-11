import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_software_test/app/core/helper/size_extensions.dart';
import 'package:hero_software_test/app/core/styles/color_style.dart';
import 'package:hero_software_test/app/core/styles/text_styles.dart';
import 'package:hero_software_test/app/core/widgets/custom_elevated_button.dart';
import 'package:hero_software_test/app/core/widgets/custom_text_field.dart';
import 'package:validatorless/validatorless.dart';

import '../../controller/user_auth_controller.dart';

class EmailConfirmationPage extends StatefulWidget {
  const EmailConfirmationPage({super.key});

  @override
  State<EmailConfirmationPage> createState() => _EmailConfirmationPageState();
}

class _EmailConfirmationPageState extends State<EmailConfirmationPage> {
  final userAuthController = Get.put(UserAuthController());
  final emailEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailEC.dispose();
    super.dispose();
  }

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
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Digite seu e-mail',
                    style: context.textStyles.textTitle
                        .copyWith(color: context.colors.secondary),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Digite o e-mail cadastrado para receber as instruções de redefinição. Fique tranquilo, você poderá alterá-la em poucos passos.',
                    style: context.textStyles.textRegular
                        .copyWith(fontSize: 18, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: emailEC,
                    keyboardType: TextInputType.emailAddress,
                    isMandatory: false,
                    fieldWidth: context.percentWidth(.9),
                    hintText: 'E-mail',
                    validation: Validatorless.required('E-mail obrigatório'),
                  ),
                  const Spacer(),
                  CustomElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          userAuthController.resetPassword(
                            email: emailEC.text.trim(),
                          );
                        }
                      },
                      buttonTitle: 'PRÓXIMO'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

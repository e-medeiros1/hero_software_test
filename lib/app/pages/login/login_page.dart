// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_software_test/app/controller/user_auth_controller.dart';
import 'package:hero_software_test/app/core/functions/fetch_data_from_api.dart';
import 'package:hero_software_test/app/core/helper/size_extensions.dart';
import 'package:hero_software_test/app/core/styles/color_style.dart';
import 'package:hero_software_test/app/core/styles/text_styles.dart';
import 'package:hero_software_test/app/core/widgets/container_logo.dart';
import 'package:hero_software_test/app/core/widgets/custom_elevated_button.dart';
import 'package:hero_software_test/app/core/widgets/custom_text_field.dart';
import 'package:hero_software_test/app/pages/login/components/custom_checkbox.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/widgets/custom_footer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool? isChecked = false;
  bool passwordVisibility = false;

  //Transformando em stateful para usar o dispose nas controllers
  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAuthController = Get.put(UserAuthController());
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: context.colors.primary,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ContainerLogo(label: ' Acesse sua conta'),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _emailEC,
                    keyboardType: TextInputType.emailAddress,
                    label: 'E-mail',
                    hintText: 'E-mail',
                    fieldWidth: context.percentWidth(.9),
                    validation: Validatorless.multiple([
                      Validatorless.required('E-mail obrigatório'),
                      Validatorless.email('E-mail incorreto'),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _passwordEC,
                    keyboardType: TextInputType.emailAddress,
                    label: 'Senha',
                    hintText: 'Senha',
                    fieldWidth: context.percentWidth(.9),
                    obscureText: !passwordVisibility,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          passwordVisibility = !passwordVisibility;
                        });
                      },
                      child: Icon(
                        passwordVisibility == true
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey.shade500,
                        size: 22,
                      ),
                    ),
                    validation: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.min(6, 'Mínimo de 6 caracteres requerido'),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lembrar-me',
                          style: context.textStyles.textRegular
                              .copyWith(fontSize: 17),
                        ),
                        CustomCheckbox(
                          boolValue: isChecked,
                          onChanged: (bool? newValue) {
                            setState(() {
                              isChecked = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        userAuthController.loginWithEmailAndPassword(
                            emailAddress: _emailEC.text.trim(),
                            password: _passwordEC.text.trim());
                      }
                    },
                    buttonTitle: 'ENTRAR',
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () => Get.toNamed('/email'),
                      child: Text(
                        'Esqueci minha senha',
                        style: context.textStyles.textMedium.copyWith(
                            color: context.colors.secondary,
                            fontSize: 17,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomFooter(
                      onPressed: () => Get.toNamed('/register'),
                      label: 'Novo por aqui?',
                      buttonLabel: 'CADASTRE-SE'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

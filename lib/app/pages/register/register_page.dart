import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_software_test/app/controller/user_auth_controller.dart';
import 'package:hero_software_test/app/core/helper/size_extensions.dart';
import 'package:hero_software_test/app/core/styles/color_style.dart';
import 'package:hero_software_test/app/core/styles/text_styles.dart';
import 'package:hero_software_test/app/core/widgets/container_logo.dart';
import 'package:hero_software_test/app/core/widgets/custom_elevated_button.dart';
import 'package:hero_software_test/app/core/widgets/custom_text_field.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/widgets/custom_footer.dart';
import 'components/custom_date_of_birth_component.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userAuthController = Get.put(UserAuthController());
  bool passwordVisibility = false;
  bool confirmPasswordVisibility = false;
  final formKey = GlobalKey<FormState>();

  final _usernameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    _usernameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: context.colors.primary,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ContainerLogo(
                      label:
                          ' Olá, que bom ter você aqui!\n Bem-vindo ao CARROCASH!'),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _usernameEC,
                    keyboardType: TextInputType.name,
                    label: 'Nome completo',
                    hintText: 'Nome completo',
                    fieldWidth: context.percentWidth(.9),
                    validation: Validatorless.multiple([
                      Validatorless.required('Nome obrigatório'),
                      Validatorless.min(3, 'Mínimo requirido de 3 caracteres')
                    ]),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    label: 'CPF',
                    hintText: 'CPF',
                    fieldWidth: context.percentWidth(.9),
                    validation: Validatorless.multiple([
                      Validatorless.required('CPF obrigatório'),
                      Validatorless.cpf('CPF inválido'),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Data de nascimento',
                            style: context.textStyles.textMedium.copyWith(
                              color: context.colors.secondary,
                              fontSize: 17,
                            ),
                          ),
                          TextSpan(
                            text: ' *',
                            style: context.textStyles.textExtraBold.copyWith(
                              color: context.colors.blue,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDateOfBirthComponent(
                          hintText: 'DD',
                          fieldWidth: context.percentWidth(.25),
                          validation: Validatorless.required('Obrigatório'),
                        ),
                        CustomDateOfBirthComponent(
                          hintText: 'MM',
                          fieldWidth: context.percentWidth(.25),
                          validation: Validatorless.required('Obrigatório'),
                        ),
                        CustomDateOfBirthComponent(
                          hintText: 'AAAA',
                          fieldWidth: context.percentWidth(.25),
                          validation: Validatorless.required('Obrigatório'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    keyboardType: TextInputType.phone,
                    label: 'Celular',
                    hintText: 'DDD + Celular',
                    fieldWidth: context.percentWidth(.9),
                    validation: Validatorless.multiple([
                      Validatorless.required('Número obrigatório'),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _emailEC,
                    keyboardType: TextInputType.emailAddress,
                    label: 'E-mail',
                    hintText: 'E-mail',
                    fieldWidth: context.percentWidth(.9),
                    validation: Validatorless.multiple([
                      Validatorless.required('Email obrigatório'),
                      Validatorless.email('E-mail inválido')
                    ]),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField.password(
                    controller: _passwordEC,
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
                    keyboardType: TextInputType.emailAddress,
                    label: 'Senha',
                    hintText: 'Mínimo 6 caracteres',
                    fontSize: 17,
                    fieldWidth: context.percentWidth(.9),
                    validation: Validatorless.multiple([
                      Validatorless.required('Senha obrigatório'),
                      Validatorless.min(6, 'Mínimo de 6 caracteres'),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField.password(
                    controller: _confirmPasswordEC,
                    obscureText: !confirmPasswordVisibility,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          confirmPasswordVisibility =
                              !confirmPasswordVisibility;
                        });
                      },
                      child: Icon(
                        confirmPasswordVisibility == true
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey.shade500,
                        size: 22,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    label: 'Confirma senha',
                    hintText: 'Mínimo 6 caracteres',
                    fontSize: 17,
                    fieldWidth: context.percentWidth(.9),
                    validation: Validatorless.multiple([
                      Validatorless.required('Senha obrigatório'),
                      Validatorless.min(6, 'Mínimo de 6 caracteres'),
                      Validatorless.compare(
                          _passwordEC, 'As senhas não coincidem'),
                    ]),
                  ),
                  const SizedBox(height: 40),
                  CustomElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          userAuthController.createAccount(
                            username: _usernameEC.text.trim(),
                            emailAddress: _emailEC.text.trim(),
                            password: _passwordEC.text.trim(),
                          );
                        }
                      },
                      buttonTitle: 'Próximo'),
                  const SizedBox(height: 40),
                  CustomFooter(
                      onPressed: () => Get.toNamed('/login'),
                      label: 'Possui uma conta?',
                      buttonLabel: 'ENTRAR'),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

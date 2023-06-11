import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hero_software_test/app/core/styles/color_style.dart';
import 'package:hero_software_test/app/core/styles/text_styles.dart';

import '../../../controller/user_auth_controller.dart';
import '../../../core/widgets/container_logo.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.user,
    required this.userAuthController,
  });

  final User? user;
  final UserAuthController userAuthController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 1,
      child: Column(
        children: [
          const ContainerLogo(label: 'Seja bem vindo!'),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(
                    Icons.person,
                    color: Colors.grey.shade200,
                    size: 40,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  '${user!.email}',
                  style: context.textStyles.textRegular.copyWith(fontSize: 17),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Divider(),
          InkWell(
            onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      title: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'Tem certeza que deseja sair do aplicativo ',
                              style: context.textStyles.textMedium.copyWith(
                                  color: context.colors.secondary,
                                  fontSize: 18,
                                  letterSpacing: .5),
                            ),
                            TextSpan(
                              text: 'CARROCASH?',
                              style: context.textStyles.textBold.copyWith(
                                  color: context.colors.black,
                                  fontSize: 18,
                                  letterSpacing: .5),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'CANCELAR',
                            style: context.textStyles.textBold.copyWith(
                                fontSize: 17, color: context.colors.blue),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            userAuthController.signOut(context: context);
                          },
                          child: Text(
                            'SAIR',
                            style: context.textStyles.textBold.copyWith(
                                fontSize: 17, color: Colors.red.shade700),
                          ),
                        ),
                      ],
                    )),
            child: ListTile(
              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),
              title: Text(
                'Sair do aplicativo',
                style: context.textStyles.textRegular
                    .copyWith(color: Colors.red, fontSize: 17),
              ),
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
          ),
          const Divider(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

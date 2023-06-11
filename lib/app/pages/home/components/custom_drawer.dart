import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                  style: context.textStyles.textBold.copyWith(fontSize: 17),
                ),
              ],
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () => userAuthController.signOut(context: context),
            child: const ListTile(
              trailing: Icon(
                Icons.arrow_forward_ios,
              ),
              title: Text('Sair'),
              leading: Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
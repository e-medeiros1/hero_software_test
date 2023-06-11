import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_software_test/app/controller/user_auth_controller.dart';
import 'package:hero_software_test/app/core/styles/color_style.dart';
import 'package:hero_software_test/app/core/styles/text_styles.dart';
import 'package:hero_software_test/app/repository/api_repository.dart';

import 'components/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final apiRepository = Get.put(ApiRepository());
  final userAuthController = Get.put(UserAuthController());
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    apiRepository.fetchDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer:
            CustomDrawer(user: user, userAuthController: userAuthController),
        appBar: AppBar(
          backgroundColor: context.colors.secondary,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            'Página inicial',
            style: context.textStyles.textTitle,
          ),
        ),
        body: FutureBuilder(
          future: apiRepository.fetchDataFromAPI(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: context.colors.primary),
              );
            } else {
              return ListView.builder(
                itemCount: apiRepository.listData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      apiRepository.listData[index]['name'].toString(),
                    ),
                    subtitle: Text(
                      'Placa do veículo: ${apiRepository.listData[index]['plate'].toString().toUpperCase()}',
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

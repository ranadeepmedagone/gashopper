import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gashopper/app/core/theme/app_theme.dart';
import 'package:get/get.dart';

import 'app/bindings/initial_bindings.dart';
import 'app/modules/registration/registration_controller.dart';
import 'app/modules/registration/registration_screen.dart';
import 'app/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.lazyPut(() => RegistrationController(), fenix: true);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      title: 'Gashopper',
      debugShowCheckedModeBanner: false,
      theme: GashopperTheme.mainTheme(),
      builder: (context, child) {
        if (child == null) return const SizedBox.shrink();

        // Apply fixed text scaling
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child,
        );
      },
      home: RegistrationScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

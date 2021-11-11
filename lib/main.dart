import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled2/controllers/task_controller.dart';
import 'package:untitled2/db/db_helper.dart';
import 'package:untitled2/services/theme_services.dart';

import 'package:untitled2/ui/home_page.dart';
import 'package:untitled2/ui/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DbHelper.initDb();
  final _taskController=Get.put(TaskController());
   _taskController.getTasks();





  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemesApp.light ,
      darkTheme: ThemesApp.dark,

      themeMode:ThemeService().theme ,

      home:HomePage() ,
    );
  }
}

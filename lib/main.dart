import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:time_lens/pages/history/logic.dart';
import 'package:time_lens/pages/home/add_time_logic.dart';
import 'package:time_lens/pages/home/add_time_spent_page.dart';
import 'package:time_lens/pages/home/add_time_tool.dart';
import 'package:time_lens/pages/home/home_logic.dart';
import 'package:time_lens/pages/home/index_tab_page.dart';
import 'package:time_lens/pages/leave/leave_binding.dart';
import 'package:time_lens/pages/leave/leave_view.dart';
import 'package:time_lens/pages/set/logic.dart';
import 'package:time_lens/res/style.dart';

import 'db/db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DatabaseService().init());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // 设置状态栏文字和图标颜色为亮色（白色）
  ));
  //禁止横屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/init',
      getPages: Paes,
      builder: (context, child) {
        return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
            child: Scaffold(
              // Global GestureDetector that will dismiss the keyboard
              resizeToAvoidBottomInset: false,
              body: KeyboardDismissOnTap(
                child: FlutterEasyLoading(
                  child: child,
                ),
              ),
            ));
      },
      theme: AppStyle.lightTheme,
      // themeMode: ThemeMode.light,
      //页面跳转风格
      defaultTransition: Transition.cupertino,
    );
  }
}

List<GetPage<dynamic>> Paes = [
  GetPage(
      name: '/init',
      page: () => const LeaveView(),
    binding: LeaveBinding()
  ),
  GetPage(
      name: '/home',
      page: () => const HomeScreenPage(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<LLHomeLogic>(() => LLHomeLogic());
          Get.lazyPut<HistoryLogic>(() => HistoryLogic());
          Get.lazyPut<SettingLogic>(() => SettingLogic());
        },
      )),
  GetPage(
      name: '/addT',
      page: () => const AddTimeSpentPage(),
      binding: BindingsBuilder(
            () {
          Get.lazyPut<AddTimeLogic>(() => AddTimeLogic());
        },
      )),
  GetPage(
      name: '/tbto',
      page: () => const AddTimeTool(),
  ),
];

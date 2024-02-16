// ignore_for_file: use_key_in_widget_constructors

import 'package:arknights_gacha_statistics/theme/global_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

import 'pages/home/home.dart';

void main(List<String> args) async {
  await initWindow();
  runApp(Main());
}

// 初始化窗口干的事
Future<void> initWindow() async {
  const Size size = Size(750, 600);
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size: size,
    center: true,
    skipTaskbar: false,
  );
  /*
  这里等待waitUntilReadyToShow方法执行完再show，目的是为了防止展示完默认的窗口设置，然后又更新成自己设置的窗口
   */
  await windowManager.waitUntilReadyToShow(windowOptions);
  /* 保证show在runApp之前就执行完就没出现过白屏问题了。 */
  await windowManager.show();
}

/* stateful widget
  state类可以with WindowListener来监听窗口行为。
 */
class Main extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainState();
}

class _MainState extends State with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(theme: theme, home: Material(child: Home()));
  }
}

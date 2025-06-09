import 'package:apk_analyzer/pages/apk_info_page.dart';
import 'package:apk_analyzer/pages/apk_table_page.dart';
import 'package:apk_analyzer/pages/frida_page.dart';
import 'package:apk_analyzer/utils/get_apk_info.dart';
import 'package:apk_analyzer/utils/my_logger.dart';
import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'pages/apk_input_page.dart';

void main() async {
  await initLogFile();
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    size:Size(800, 600),
    center: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, ()async{
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'App Analyzer',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
          textTheme: TextTheme().useSystemChineseFont(Brightness.light),
        ),
        home: ApkInputPage(),
        routes: <String, WidgetBuilder>{
          "/ApkInput": (context) => ApkInputPage(),
          "/Home": (context) => MyHomePage(),
        },
        
      ),
      
    );
  }
}

class MyAppState extends ChangeNotifier {
  GetApkInfo? apkParser;

  void setApkParser(GetApkInfo a) {
    apkParser = a;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final a = ModalRoute.of(context)?.settings.arguments; //接收参数
    var appState = context.watch<MyAppState>();
    if (a is GetApkInfo) {
      //判断参数类型
      appState.setApkParser(a);
    }
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = ApkInfoPage();
        break;
      case 1:
        page = ApkTablePage();
        break;
      case 2:
        page = FridaPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // The container for the current page, with its background color
    // and subtle switching animation.
    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  indicatorColor: Colors.cyan,
                  backgroundColor: const Color.fromARGB(255, 213, 239, 227),
                  minWidth: 50,
                  minExtendedWidth: 50,
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.android),
                      label: Text('分析结果'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.list),
                      label: Text('详细信息'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.code),
                      label: Text("Frida功能")
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(child: mainArea),
            ],
          );
        },
      ),
      floatingActionButton: const GlobalHomeButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}


class GlobalHomeButton extends StatelessWidget {
  const GlobalHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // 返回主页并清除路由堆栈
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      
      backgroundColor: Colors.blue,
      heroTag: 'globalHomeButton', // 唯一标识
      child: const Icon(Icons.home),
    );
  }
}
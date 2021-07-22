import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:flutter_in_action_source_code/generated/l10n.dart';
import 'package:flutter_in_action_source_code/routes/align.dart';
import 'package:flutter_in_action_source_code/routes/animated_switcher_counter.dart';
import 'package:flutter_in_action_source_code/routes/animated_widgets.dart';
import 'package:flutter_in_action_source_code/routes/animation_switcher.dart';
import 'package:flutter_in_action_source_code/routes/button.dart';
import 'package:flutter_in_action_source_code/routes/camera.dart';
import 'package:flutter_in_action_source_code/routes/custom_paint.dart';
import 'package:flutter_in_action_source_code/routes/custom_ui_framework.dart';
import 'package:flutter_in_action_source_code/routes/decoratedbox.dart';
import 'package:flutter_in_action_source_code/routes/dialog.dart';
import 'package:flutter_in_action_source_code/routes/dio_test.dart';
import 'package:flutter_in_action_source_code/routes/file_operation.dart';
import 'package:flutter_in_action_source_code/routes/future_and_stream_builder.dart';
import 'package:flutter_in_action_source_code/routes/gradient_button.dart';
import 'package:flutter_in_action_source_code/routes/gradient_circular_progress.dart';
import 'package:flutter_in_action_source_code/routes/grow_transition.dart';
import 'package:flutter_in_action_source_code/routes/hero_animation.dart';
import 'package:flutter_in_action_source_code/routes/http_client.dart';
import 'package:flutter_in_action_source_code/routes/image_icon.dart';
import 'package:flutter_in_action_source_code/routes/image_internal.dart';
import 'package:flutter_in_action_source_code/routes/inheritedwidget.dart';
import 'package:flutter_in_action_source_code/routes/notification.dart';
import 'package:flutter_in_action_source_code/routes/offstage.dart';
import 'package:flutter_in_action_source_code/routes/padding.dart';
import 'package:flutter_in_action_source_code/routes/platform_view.dart';
import 'package:flutter_in_action_source_code/routes/pointer.dart';
import 'package:flutter_in_action_source_code/routes/progress.dart';
import 'package:flutter_in_action_source_code/routes/provider.dart';
import 'package:flutter_in_action_source_code/routes/row_column.dart';
import 'package:flutter_in_action_source_code/routes/scaffold.dart';
import 'package:flutter_in_action_source_code/routes/scale_animation.dart';
import 'package:flutter_in_action_source_code/routes/scale_animation_animatedbuilder.dart';
import 'package:flutter_in_action_source_code/routes/scale_animation_animatedwidget.dart';
import 'package:flutter_in_action_source_code/routes/size_constraints.dart';
import 'package:flutter_in_action_source_code/routes/stagger_animation.dart';
import 'package:flutter_in_action_source_code/routes/switch_checkbox.dart';
import 'package:flutter_in_action_source_code/routes/table.dart';
import 'package:flutter_in_action_source_code/routes/test.dart';
import 'package:flutter_in_action_source_code/routes/text.dart';
import 'package:flutter_in_action_source_code/routes/context.dart';
import 'package:flutter_in_action_source_code/routes/router.dart';
import 'package:flutter_in_action_source_code/routes/state.dart';
import 'package:flutter_in_action_source_code/routes/textfield.dart';
import 'package:flutter_in_action_source_code/routes/theme.dart';
import 'package:flutter_in_action_source_code/routes/turn_box.dart';
import 'package:flutter_in_action_source_code/widgets/base_app_bar.dart';
import 'package:flutter_in_action_source_code/widgets/page_scaffold.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'common.dart';
import 'http.dart';

void main() async {
  dio.interceptors..add(CookieManager(CookieJar()))..add(LogInterceptor());
  runApp(MyApp());
  cameras = await availableCameras();
  PaintingBinding.instance!.imageCache!.maximumSize = 2000; //最多2000张
  PaintingBinding.instance!.imageCache!.maximumSizeBytes = 200 << 20; //200 M
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizationDelegate(),
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('en', 'US'), const Locale('zh', 'CN')],
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  void _openPage(BuildContext context, PageInfo pageInfo) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      if (!pageInfo.withScaffold) {
        return pageInfo.builder(context);
      }
      return PageScaffold(
        pageInfo.title,
        pageInfo.builder(context),
        pageInfo.padding,
      );
    }));
  }

  List<Widget> _generateItem(BuildContext context, List<PageInfo> children) {
    return children.map<Widget>((page) {
      return ListTile(
          title: Text(page.title),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            _openPage(context, page);
          });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTool.initBar(S.of(context).title),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text('第一个Flutter应用'),
            children: _generateItem(
                context, [PageInfo('路由传值', (context) => RouterTestRoute())]),
          ),
          ExpansionTile(
              title: Text('基础组件'),
              children: _generateItem(context, [
                PageInfo('Context测试', (context) => ContextRoute(),
                    withScaffold: false),
                PageInfo('Widget树中获取State对象', (context) => RetrieveStateRoute(),
                    withScaffold: false),
                PageInfo('文本、字体样式', (context) => TextRoute()),
                PageInfo('按钮', (context) => ButtonRoute()),
                PageInfo('图片伸缩', (context) => ImageAndIconRoute()),
                PageInfo('单选开关和复选框', (context) => SwitchAndCheckBoxRoute()),
                PageInfo('输入框', (context) => FocusTestRoute()),
                PageInfo('进度条', (context) => ProgressRoute()),
              ])),
          ExpansionTile(
              title: Text('布局类组件'),
              children: _generateItem(context, [
                PageInfo('Column居中', (context) => CenterColumnRoute()),
                PageInfo("表格布局", (context) => TableRoute()),
                PageInfo("对齐及相对定位", (ctx) => AlignRoute()),
              ])),
          ExpansionTile(
            title: Text('容器类组件'),
            children: _generateItem(context, [
              PageInfo('填充Padding', (context) => PaddingTestRoute()),
              PageInfo("尺寸限制类容器", (context) => SizeConstraintsRoute(),
                  withScaffold: false),
              PageInfo('OffStage', (context) => SpreadWidget()),
              PageInfo("DecoratedBox", (context) => DecoratedBoxRoute()),
              PageInfo('Scaffold、TabBar、底部导航', (context) => ScaffoldRoute(),
                  withScaffold: false),
            ]),
          ),
          ExpansionTile(
            title: Text('功能性组件'),
            children: _generateItem(context, [
              PageInfo('数据共享(inheritedWidget)',
                  (context) => InheritedWidgetTestRoute()),
              PageInfo("跨组件状态管理(Provider)", (context) => ProviderRoute()),
              PageInfo("主题-Theme", (context) => ThemeTestRoute(),
                  withScaffold: false),
              PageInfo("FutureBuilder和StreamBuilder",
                  (context) => FutureAndStreamBuilderRoute()),
              PageInfo("对话框", (context) => DialogTestRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text("事件处理与通知"),
            children: _generateItem(context, [
              PageInfo("原生指针事件", (context) => PointerRoute()),
              PageInfo("通知(Notification)", (context) => NotificationRoute())
            ]),
          ),
          ExpansionTile(
              title: Text("自定义组件"),
              children: _generateItem(context, [
                PageInfo("GradientButton", (context) => GradientButtonRoute()),
                PageInfo("Material APP", (ctx) => ScaffoldRoute(),
                    withScaffold: false),
                PageInfo("旋转容器：TurnBox", (ctx) => TurnBoxRoute()),
                PageInfo("CustomPaint", (ctx) => CustomPaintRoute()),
                PageInfo(
                    "自绘控件：圆形渐变进度条", (ctx) => GradientCircularProgressRoute()),
                PageInfo("自定义UI框架", (ctx) => CustomHome()),
                PageInfo("测试", (ctx) => TestRoute()),
              ])),
          ExpansionTile(
            title: Text("文件操作与网络请求"),
            children: _generateItem(context, [
              PageInfo("文件操作", (ctx) => FileOperationRoute(),
                  withScaffold: false),
              PageInfo("通过HttpClient发起HTTP请求", (ctx) => HttpClientTestRoute()),
              PageInfo("通过Dio发起HTTP请求", (ctx) => DioTestRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text("Flutter原理"),
            children: _generateItem(context, [
              PageInfo("图片加载原理与缓存", (ctx) => ImageInternalTestRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text("动画"),
            children: _generateItem(context, [
              PageInfo("放大动画-原始版", (ctx) => ScaleAnimationRoute(),
                  withScaffold: false),
              PageInfo("放大动画-AnimatedWidget版", (ctx) => ScaleAnimationRoute1()),
              PageInfo(
                  "放大动画-AnimatedBuilder版", (ctx) => ScaleAnimationRoute2()),
              PageInfo("放大动画-GrowTransition版", (ctx) => GrowTransitionRoute()),
              PageInfo("Hero动画", (ctx) => HeroAnimationRoute()),
              PageInfo("交织动画(Stagger Animation)", (ctx) => StaggerRoute()),
              PageInfo("动画切换组件(AnimatedSwitcher)",
                  (ctx) => AnimatedSwitcherCounterRoute()),
              PageInfo("动画切换组件高级用法", (ctx) => AnimatedSwitcherRoute()),
              PageInfo("动画过渡组件", (ctx) => AnimatedWidgetsTest()),
            ]),
          ),
          ExpansionTile(
            title: Text("包与插件"),
            children: _generateItem(context, [
              PageInfo("相机", (ctx) => CameraExampleHome(), withScaffold: false),
              PageInfo("PlatformView示例（webview）", (ctx) => PlatformViewRoute(),
                  padding: false),
            ]),
          ),
        ],
      ),
    );
  }
}

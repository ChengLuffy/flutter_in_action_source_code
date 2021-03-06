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
  PaintingBinding.instance!.imageCache!.maximumSize = 2000; //??????2000???
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
            title: Text('?????????Flutter??????'),
            children: _generateItem(
                context, [PageInfo('????????????', (context) => RouterTestRoute())]),
          ),
          ExpansionTile(
              title: Text('????????????'),
              children: _generateItem(context, [
                PageInfo('Context??????', (context) => ContextRoute(),
                    withScaffold: false),
                PageInfo('Widget????????????State??????', (context) => RetrieveStateRoute(),
                    withScaffold: false),
                PageInfo('?????????????????????', (context) => TextRoute()),
                PageInfo('??????', (context) => ButtonRoute()),
                PageInfo('????????????', (context) => ImageAndIconRoute()),
                PageInfo('????????????????????????', (context) => SwitchAndCheckBoxRoute()),
                PageInfo('?????????', (context) => FocusTestRoute()),
                PageInfo('?????????', (context) => ProgressRoute()),
              ])),
          ExpansionTile(
              title: Text('???????????????'),
              children: _generateItem(context, [
                PageInfo('Column??????', (context) => CenterColumnRoute()),
                PageInfo("????????????", (context) => TableRoute()),
                PageInfo("?????????????????????", (ctx) => AlignRoute()),
              ])),
          ExpansionTile(
            title: Text('???????????????'),
            children: _generateItem(context, [
              PageInfo('??????Padding', (context) => PaddingTestRoute()),
              PageInfo("?????????????????????", (context) => SizeConstraintsRoute(),
                  withScaffold: false),
              PageInfo('OffStage', (context) => SpreadWidget()),
              PageInfo("DecoratedBox", (context) => DecoratedBoxRoute()),
              PageInfo('Scaffold???TabBar???????????????', (context) => ScaffoldRoute(),
                  withScaffold: false),
            ]),
          ),
          ExpansionTile(
            title: Text('???????????????'),
            children: _generateItem(context, [
              PageInfo('????????????(inheritedWidget)',
                  (context) => InheritedWidgetTestRoute()),
              PageInfo("?????????????????????(Provider)", (context) => ProviderRoute()),
              PageInfo("??????-Theme", (context) => ThemeTestRoute(),
                  withScaffold: false),
              PageInfo("FutureBuilder???StreamBuilder",
                  (context) => FutureAndStreamBuilderRoute()),
              PageInfo("?????????", (context) => DialogTestRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text("?????????????????????"),
            children: _generateItem(context, [
              PageInfo("??????????????????", (context) => PointerRoute()),
              PageInfo("??????(Notification)", (context) => NotificationRoute())
            ]),
          ),
          ExpansionTile(
              title: Text("???????????????"),
              children: _generateItem(context, [
                PageInfo("GradientButton", (context) => GradientButtonRoute()),
                PageInfo("Material APP", (ctx) => ScaffoldRoute(),
                    withScaffold: false),
                PageInfo("???????????????TurnBox", (ctx) => TurnBoxRoute()),
                PageInfo("CustomPaint", (ctx) => CustomPaintRoute()),
                PageInfo(
                    "????????????????????????????????????", (ctx) => GradientCircularProgressRoute()),
                PageInfo("?????????UI??????", (ctx) => CustomHome()),
                PageInfo("??????", (ctx) => TestRoute()),
              ])),
          ExpansionTile(
            title: Text("???????????????????????????"),
            children: _generateItem(context, [
              PageInfo("????????????", (ctx) => FileOperationRoute(),
                  withScaffold: false),
              PageInfo("??????HttpClient??????HTTP??????", (ctx) => HttpClientTestRoute()),
              PageInfo("??????Dio??????HTTP??????", (ctx) => DioTestRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text("Flutter??????"),
            children: _generateItem(context, [
              PageInfo("???????????????????????????", (ctx) => ImageInternalTestRoute()),
            ]),
          ),
          ExpansionTile(
            title: Text("??????"),
            children: _generateItem(context, [
              PageInfo("????????????-?????????", (ctx) => ScaleAnimationRoute(),
                  withScaffold: false),
              PageInfo("????????????-AnimatedWidget???", (ctx) => ScaleAnimationRoute1()),
              PageInfo(
                  "????????????-AnimatedBuilder???", (ctx) => ScaleAnimationRoute2()),
              PageInfo("????????????-GrowTransition???", (ctx) => GrowTransitionRoute()),
              PageInfo("Hero??????", (ctx) => HeroAnimationRoute()),
              PageInfo("????????????(Stagger Animation)", (ctx) => StaggerRoute()),
              PageInfo("??????????????????(AnimatedSwitcher)",
                  (ctx) => AnimatedSwitcherCounterRoute()),
              PageInfo("??????????????????????????????", (ctx) => AnimatedSwitcherRoute()),
              PageInfo("??????????????????", (ctx) => AnimatedWidgetsTest()),
            ]),
          ),
          ExpansionTile(
            title: Text("????????????"),
            children: _generateItem(context, [
              PageInfo("??????", (ctx) => CameraExampleHome(), withScaffold: false),
              PageInfo("PlatformView?????????webview???", (ctx) => PlatformViewRoute(),
                  padding: false),
            ]),
          ),
        ],
      ),
    );
  }
}

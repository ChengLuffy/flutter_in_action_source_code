import 'package:flutter/material.dart';
import 'package:flutter_in_action_source_code/widgets/base_app_bar.dart';

class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          InkWell(
            child: Hero(
                tag: "avatar",
                child: ClipOval(
                  child: Image.asset(
                    "imgs/avatar.png",
                    width: 50.0,
                  ),
                )),
            onTap: () {
              Navigator.push(context, PageRouteBuilder(pageBuilder:
                  (BuildContext context, Animation<double> animation,
                      Animation secondAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: Scaffold(
                    appBar: AppBarTool.initBar("原图"),
                    body: HeroAnimationRouteB(),
                  ),
                );
              }));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text("点击头像"),
          )
        ],
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "avatar",
        child: Image.asset("imgs/avatar.png"),
      ),
    );
  }
}

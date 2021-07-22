import 'package:flutter/material.dart';

// fit：该属性用于在图片的显示空间和图片本身大小不同时指定图片的适应模式。适应模式是在BoxFit中定义，它是一个枚举类型，有如下值：
// fill：会拉伸填充满显示空间，图片本身长宽比会发生变化，图片会变形。
// cover：会按图片的长宽比放大后居中填满显示空间，图片不会变形，超出显示空间部分会被剪裁。
// contain：这是图片的默认适应规则，图片会在保证图片本身长宽比不变的情况下缩放以适应当前显示空间，图片不会变形。
// fitWidth：图片的宽度会缩放到显示空间的宽度，高度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。
// fitHeight：图片的高度会缩放到显示空间的高度，宽度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。
// none：图片没有适应策略，会在显示空间内显示图片，如果图片比显示空间大，则显示空间只会显示图片中间部分。

class ImageAndIconRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var img = AssetImage('imgs/avatar.png');
    return SingleChildScrollView(
      child: Column(
        children: <Image>[
          Image(
            image: img,
            height: 50,
            width: 100,
            fit: BoxFit.fill, //
          ),
          Image(
            image: img,
            height: 50,
            width: 50,
            fit: BoxFit.contain,
          ),
          Image(
            image: img,
            height: 50,
            width: 100,
            fit: BoxFit.cover,
          ),
          Image(
            image: img,
            height: 50,
            width: 100,
            fit: BoxFit.fitHeight,
          ),
          Image(
            image: img,
            height: 50,
            width: 100,
            fit: BoxFit.fitWidth,
          ),
          Image(
            image: img,
            height: 50,
            width: 100,
            fit: BoxFit.scaleDown,
          ),
          Image(
            image: img,
            height: 50,
            width: 100,
            fit: BoxFit.none,
          ),
        ]
            .map((e) => Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(16),
                        child: SizedBox(
                          width: 100,
                          child: e,
                        )),
                    Text(e.fit.toString()),
                  ],
                ))
            .toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage_2/provider.dart';

final networkUriReg=RegExp('^http');
final localkUriReg=RegExp('^static');

class CommonImage extends StatelessWidget {

  final String src;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const CommonImage(this.src,{super.key, this.width, this.height, this.fit});

  
  @override
  Widget build(BuildContext context) {
    if (networkUriReg.hasMatch(src)) {
      return Image(
        width: width,
        height: height,
        fit: fit,
        image: AdvancedNetworkImage(
          src,
          useDiskCache: true,
          cacheRule: const CacheRule(maxAge: Duration(days: 7)),
          timeoutDuration: const Duration(seconds: 20),
        )
      );
    }

    if (localkUriReg.hasMatch(src)) {
      return Image.asset(
        src,
        width: width,
        height: height,
        fit: fit,
      );
    }

    assert(false,'图片地址 src 不合法!');

    return Container();
  }
}
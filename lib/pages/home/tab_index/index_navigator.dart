import 'package:flutter/material.dart';
import 'package:hook_up_rent/widgets/common_image.dart';
import './index_navigator_item.dart';

class IndexNavigator extends StatelessWidget {
  const IndexNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: indexNavigatorItemList.map((e) => InkWell(
              onTap: () {
                e.onTap(context);
              },
              child: Column(children: [
                CommonImage(e.imageUri,width: 47.5,),
                Text(e.title,style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600)),
              ],),
              )).toList(),
        )
    );
  }
}

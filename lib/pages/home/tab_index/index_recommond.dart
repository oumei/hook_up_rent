import 'package:flutter/material.dart';
import 'package:hook_up_rent/pages/home/tab_index/index_recommond_data.dart';
import 'package:hook_up_rent/pages/home/tab_index/index_recommond_item_widget.dart';

class IndexRecommond extends StatelessWidget {
  final List<IndexRecommondItem> dataList;

  const IndexRecommond({super.key, this.dataList=indexRecommondData});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(color: Color(0x08000000)),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('房屋推荐', style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
            Text('更多',style: TextStyle(color: Colors.black54),),
          ],),
        const Padding(padding: EdgeInsets.all(5)),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: dataList.map((e) => IndexRecommondItemWidget(e)
          ).toList(),)
      ],),
      );
  }
}
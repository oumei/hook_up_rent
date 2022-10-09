import 'package:flutter/material.dart';
import 'package:hook_up_rent/pages/home/info/data.dart';
import 'package:hook_up_rent/pages/home/info/item_widget.dart';

class Info extends StatelessWidget {
  final bool showTitle;
  final List<InfoItem> dataList;

  const Info({super.key, this.showTitle=false, this.dataList=infoData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        if(showTitle) Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10.0),
          child: const Text('最新资讯',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
        ),
        Column(children: dataList.map((e) => ItemWidget(e)).toList())
      ],),
    );
  }
}
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hook_up_rent/models/info_item.dart';
// import 'package:hook_up_rent/pages/home/info/data.dart';
import 'package:hook_up_rent/pages/home/info/item_widget.dart';
// import 'package:hook_up_rent/pages/home/tab_search/data_list.dart';
import 'package:hook_up_rent/utils/dio_http.dart';
import 'package:hook_up_rent/utils/scoped_model_helper.dart';

class Info extends StatefulWidget {
  final bool showTitle;
  // List<InfoItem> dataList;
  // const Info({super.key, this.showTitle=false, this.dataList=infoData});
  const Info({super.key, this.showTitle=false});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  List<InfoItem> dataList = [];

  _getData() async {
    var areaId = Uri.encodeQueryComponent(ScopedModelHelper.getAreaId(context));
    String url = '/home/news?area=$areaId';
    var res = await DioHttp.of(context).get(url);
    var data = json.decode(res.toString())['body'];
    List<InfoItem> list = List<InfoItem>.from(
        data.map((item) => InfoItem.fromJson(item)).toList());
    setState(() {
      dataList = list;
    });
  }
  

  @override
  void initState() {
    Timer.run(_getData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        if(widget.showTitle) Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(10.0),
          child: const Text('最新资讯',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
        ),
        Column(children: dataList.map((e) => ItemWidget(e)).toList())
      ],),
    );
  }
}
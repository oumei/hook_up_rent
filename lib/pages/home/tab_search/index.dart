import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hook_up_rent/models/room_list_item_data.dart';
import 'package:hook_up_rent/pages/home/tab_search/filter_bar/data.dart';
// import 'package:hook_up_rent/pages/home/tab_search/data_list.dart';
import 'package:hook_up_rent/pages/home/tab_search/filter_bar/filter_drawer.dart';
import 'package:hook_up_rent/pages/home/tab_search/filter_bar/index.dart';
import 'package:hook_up_rent/utils/dio_http.dart';
import 'package:hook_up_rent/utils/scoped_model_helper.dart';
import 'package:hook_up_rent/widgets/room_list_item_widget.dart';
import 'package:hook_up_rent/widgets/search_bar/index.dart';

class TabSearch extends StatefulWidget {
  const TabSearch({Key? key}) : super(key: key);

  @override
  State<TabSearch> createState() => _TabSearchState();
}

class _TabSearchState extends State<TabSearch> {
  List<RoomListItemData> list = [];
  _onFilterBarChange(FilterBarResult data) async {
    var cityId = Uri.encodeQueryComponent(ScopedModelHelper.getAreaId(context));
    var area = Uri.encodeQueryComponent(data.areaId);
    var mode = Uri.encodeQueryComponent(data.rentTypeId);
    var price = Uri.encodeQueryComponent(data.priceId);
    var more = Uri.encodeQueryComponent(data.moreIds.join(','));
    String url = '/houses?cityId=' +
        '$cityId&area=$area&mode=$mode&price=$price&more=$more&start=1&end=20';
    var res = await DioHttp.of(context).get(url);
    var resMap = json.decode(res.toString());
    List dataMap = resMap['body']['list'];
    
    List<RoomListItemData> resList = dataMap.map((json) => RoomListItemData.fromJson(json)).toList();
    //注：方式与租金的筛选看不出什么变化，其实是有发生请求的，可能接口筛选出现问题，与前端没关系
    setState(() {
      list = resList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: FilterDrawer(),
      appBar: AppBar(
        actions: [Container()],
        elevation: 0,
        title: SearchBar(
          showLocation: true,
          showMap: true,
          onSearch: () {
            Navigator.of(context).pushNamed('search');
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: 41.0,
            child: FilterBar(onChanged: _onFilterBarChange),
          ),
          Expanded(
              child: ListView(
            children: list.map((e) => RoomListItemWidget(e)).toList(),
          ))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class IndexNavigatorItem {
  final String title;
  final String imageUri;
  final Function(BuildContext context) onTap;

  IndexNavigatorItem(this.title,this.imageUri,this.onTap);
}

List<IndexNavigatorItem> indexNavigatorItemList=[
  IndexNavigatorItem('整租', 'static/images/home_index_navigator_total.png', (context) {
    Navigator.of(context).pushNamed('login');
  }),
  IndexNavigatorItem('合租', 'static/images/home_index_navigator_share.png', (context) {
    Navigator.of(context).pushNamed('login');
  }),
  IndexNavigatorItem('地图找房', 'static/images/home_index_navigator_map.png', (context) {
    Navigator.of(context).pushNamed('login');
  }),
  IndexNavigatorItem('去出租', 'static/images/home_index_navigator_rent.png', (context) {
    Navigator.of(context).pushNamed('login');
  }),
];
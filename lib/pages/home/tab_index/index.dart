
import 'package:flutter/material.dart';
import 'package:hook_up_rent/pages/home/info/index.dart';
import 'package:hook_up_rent/pages/home/tab_index/index_navigator.dart';
import 'package:hook_up_rent/pages/home/tab_index/index_recommond.dart';
import 'package:hook_up_rent/widgets/common_swipper.dart';
import 'package:hook_up_rent/widgets/search_bar/index.dart';

class TabIndex extends StatelessWidget {
  const TabIndex({Key? key}) :super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          showLocation: true,
          showMap: true,
          onSearch: () {
            Navigator.of(context).pushNamed('search');
          },
          ),
        backgroundColor: Colors.white,
        ),
      body: ListView(children:  const [
        CommonSwiper(),
        IndexNavigator(),
        IndexRecommond(),
        Info(showTitle: true,),
        Text('这里是内容区域'),
      ],),
    );
  }

}
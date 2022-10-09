//1、新建文件
//2、添加 material, page_content 依赖
import 'package:flutter/material.dart';
import 'package:hook_up_rent/pages/home/tab_index/index.dart';
import 'package:hook_up_rent/pages/home/tab_info/index.dart';
import 'package:hook_up_rent/pages/home/tab_profile/index.dart';
import 'package:hook_up_rent/pages/home/tab_search/index.dart';
import 'package:hook_up_rent/widgets/page_content.dart';

List<Widget> tableViewList=[
  const TabIndex(),
  const TabSearch(),
  const TabInfo(),
  const TabProfile(),
];

List<BottomNavigationBarItem> barItemList=[
  const BottomNavigationBarItem(icon: Icon(Icons.home),label: '首页'),
  const BottomNavigationBarItem(icon: Icon(Icons.search),label: '找房'),
  const BottomNavigationBarItem(icon: Icon(Icons.info),label: '咨询'),
  const BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: '我的'),
];


//3、编写有状态组件
class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //4、使用 page_content
    return Scaffold(
      body: tableViewList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: barItemList,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),

    );
  }
}
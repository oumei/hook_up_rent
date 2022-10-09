//1、新建文件
//2、添加 material 依赖
import 'package:flutter/material.dart';
import 'package:hook_up_rent/routes.dart';
//3、编写无状态组件
class PageContent extends StatelessWidget {
  final String name;
//4、添加 name 参数
  const PageContent({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    //5、使用 Scaffold
    return Scaffold(
      appBar: AppBar(title: Text('当前页面：$name'),
      ),
      body: ListView(children: [
        TextButton(onPressed: (){
          Navigator.pushNamed(context, Routes.home);
        }, child: Text(Routes.home)),
        TextButton(onPressed: (){
          Navigator.pushNamed(context, Routes.login);
        }, child: Text(Routes.login)),
        TextButton(onPressed: (){
          Navigator.pushNamed(context, '/aaaa');
        }, child: const Text('不存在的页面')),
        TextButton(onPressed: (){
          Navigator.pushNamed(context, '/room/2222');
        }, child: const Text('房间详情页，ID：2222')),
      ]),
    );
  }
}
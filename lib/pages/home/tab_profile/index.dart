import 'package:flutter/material.dart';
import 'package:hook_up_rent/pages/home/info/index.dart';
import 'package:hook_up_rent/pages/home/tab_profile/advertisement.dart';
import 'package:hook_up_rent/pages/home/tab_profile/function_button.dart';
import 'package:hook_up_rent/pages/home/tab_profile/header.dart';

class TabProfile extends StatelessWidget {
  const TabProfile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text('我的'),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed('setting');
          }, icon: const Icon(Icons.settings))
        ],
      ),
      body: ListView(children: const [
        Header(),
        FunctionButton(),
        Advertisement(),
        Info(showTitle: true,)
      ],),
    );
  }
}
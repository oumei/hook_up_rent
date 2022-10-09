import 'package:flutter/material.dart';
import 'package:hook_up_rent/scoped_model/auth.dart';
import 'package:hook_up_rent/utils/common_toast.dart';
import 'package:hook_up_rent/utils/scoped_model_helper.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          TextButton(
            onPressed: () {
              ScopedModelHelper.getModel<AuthModel>(context).logout();
              CommonToast.showToast('已经退出登陆');
            }, 
            style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states){
              return Colors.green;
            }),), 
            child: const Text('退出登陆',style: TextStyle(color: Colors.white),))],
      ),
    );
  }
}

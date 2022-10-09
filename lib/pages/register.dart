//1、新建文件
//2、添加 material, page_content 依赖
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hook_up_rent/utils/common_toast.dart';
import 'package:hook_up_rent/utils/dio_http.dart';
import 'package:hook_up_rent/utils/string_is_null_or_empty.dart';

//3、编写无状态组件
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var repeatPasswordController = TextEditingController();

  _registerHandler()async{
    var username = usernameController.text;
    var password = passwordController.text;
    var repeatPassword = repeatPasswordController.text;

    if (password != repeatPassword) {
      CommonToast.showToast('两次输入的密码不一致！');
      return;
    }
    if(stringIsNullOrEmpty(username)||stringIsNullOrEmpty(password)){
      CommonToast.showToast('用户名或密码不能为空！');
      return;
    }

    const url = 'user/registered';
    var params = {'username':username,'password':password};
    var res = await DioHttp.of(context).post(url,params);
    var resString = json.decode(res.toString());
    int status = resString['status'];
    String description = resString['description'] ?? '内部错误';
    CommonToast.showToast(description);
    if(status.toString().startsWith('2')){
      Navigator.of(context).pushReplacementNamed('login');
    }
  }
  @override
  Widget build(BuildContext context) {
    //4、使用 page_content
    return Scaffold(
      appBar: AppBar(
        title: const Text('注册'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(30),
        child: ListView(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: '用户名',
                hintText: '请输入用户名',
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: '密码',
                hintText: '请输入密码',
              ),
              obscureText: true,
            ),
            const Padding(padding: EdgeInsets.all(10)),
            TextField(
              controller: repeatPasswordController,
              decoration: const InputDecoration(
                labelText: '确认密码',
                hintText: '请输入密码',
              ),
              obscureText: true,
            ),
            const Padding(padding: EdgeInsets.all(10)),
            TextButton(
              onPressed: () {
                _registerHandler();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  //设置按钮背景的高亮颜色
                  // if (states.contains(MaterialState.pressed)) {
                  //   return Colors.green;
                  // }
                  //默认背景颜色
                  return Colors.green;
                }),
              ),
              child: const Text('注册', style: TextStyle(color: Colors.white)),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('已有账号，'),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                    child: const Text('去登陆',
                        style: TextStyle(color: Colors.green)))
              ],
            )
          ],
        ),
      ),
    );
  }
}

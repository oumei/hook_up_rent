//1、新建文件
//2、添加 material, page_content 依赖
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hook_up_rent/scoped_model/auth.dart';
import 'package:hook_up_rent/utils/common_toast.dart';
import 'package:hook_up_rent/utils/dio_http.dart';
import 'package:hook_up_rent/utils/scoped_model_helper.dart';
import 'package:hook_up_rent/utils/store.dart';
import 'package:hook_up_rent/utils/string_is_null_or_empty.dart';

//3、编写无状态组件
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = false;
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  _loginHandle() async {
    var username = usernameController.text;
    var password = passwordController.text;
    if(stringIsNullOrEmpty(username)||stringIsNullOrEmpty(password)){
      CommonToast.showToast('用户名或密码不能为空！');
      return;
    }

    const url = '/user/login';
    var params = {
      'username':username,
      'password':password
    };
    var res = await DioHttp.of(context).post(url,params);
    var resString = json.decode(res.toString());
    int status = resString['status'];
    String description = resString['description'] ?? '内部错误';
    CommonToast.showToast(description);
    if(status.toString().startsWith('2')){
      String token = resString['body']['token'];
      Store store = await Store.getInstance();
      await store.setString(StoreKeys.token, token);

      ScopedModelHelper.getModel<AuthModel>(context).login(token,context);

      Timer(const Duration(seconds: 1), (){
        Navigator.of(context).pop();
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    //4、使用 page_content
    return Scaffold(
      appBar: AppBar(
        title: const Text('登陆'),
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
              decoration: InputDecoration(
                  labelText: '密码',
                  hintText: '请输入密码',
                  suffixIcon: IconButton(
                    icon: Icon(
                        showPassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  )),
              obscureText: !showPassword,
            ),
            const Padding(padding: EdgeInsets.all(10)),
            TextButton(
              onPressed: () {
                _loginHandle();
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
              child: const Text('登陆', style: TextStyle(color: Colors.white)),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('还没有账号，'),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'register');
                    },
                    child: const Text('去注册',
                        style: TextStyle(color: Colors.green)))
              ],
            )
          ],
        ),
      ),
    );
  }
}

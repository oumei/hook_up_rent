import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hook_up_rent/scoped_model/auth.dart';
import 'package:hook_up_rent/utils/scoped_model_helper.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3), (){
      Navigator.of(context).pushReplacementNamed('/');
    });
    Timer.run(() {
      ScopedModelHelper.getModel<AuthModel>(context).initApp(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image:
              DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('static/images/loading.jpg'))),
    );
  }
}

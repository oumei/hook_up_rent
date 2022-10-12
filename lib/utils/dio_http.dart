import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hook_up_rent/config.dart';
import 'package:hook_up_rent/routes.dart';
import 'package:hook_up_rent/scoped_model/auth.dart';
import 'package:hook_up_rent/utils/common_toast.dart';
import 'package:hook_up_rent/utils/scoped_model_helper.dart';

class DioHttp {
  Dio? _client;
  BuildContext? context;

  static DioHttp of(BuildContext context) {
    return DioHttp._internal(context);
  }

  DioHttp._internal(BuildContext context) {
    if (_client == null || context != this.context) {
      this.context = context;
      var options = BaseOptions(
        baseUrl: Config.BaseUrl,
        connectTimeout: 1000*10,
        receiveTimeout:1000*3,
        extra: {'context':context},
      );

      Interceptor interceptor = InterceptorsWrapper(onResponse: (res, handler) {
        if (res == null)return handler.next(res);
        var status = json.decode(res.toString())['status'];
        if (status == 404) {
          CommonToast.showToast('接口地址错误！当前接口：${res.requestOptions.path}');
          return handler.next(res);
        }
        if (status.toString().startsWith('4')){
          ScopedModelHelper.getModel<AuthModel>(context).logout();

          //在启动页识别到token过期就不需要跳转到登录页面
          if (ModalRoute.of(context)?.settings.name == Routes.loading) {
            return handler.next(res);
          }

          CommonToast.showToast('登陆过期！');
          Navigator.of(context).pushNamed(Routes.login);
          return handler.next(res);
        }
        return handler.next(res);
      },);
      var client = Dio(options);
      client.interceptors.add(interceptor);
      this._client = client;
      
    }
  }

  Future<Response<Map<String,dynamic>>> get(String path,[Map<String,dynamic>? params,String? token]) async{
    var options = Options(headers: {'Authorization':token});
    return await _client!.get(
      path,
      queryParameters: params,
      options: options,
      );
  }

  Future<Response<Map<String,dynamic>>> post(String path,[Map<String,dynamic>? params,String? token]) async{
    var options = Options(headers: {'Authorization':token});
    return await _client!.post(
      path,
      data: params,
      options: options,
      );
  }

  Future<Response<Map<String,dynamic>>> postFormData(String path,[FormData? params,String? token]) async{
    var options = Options(
      contentType: 'multipart/form-data',
      headers: {'Authorization':token});
    return await _client!.post(
      path,
      data: params,
      options: options,
      );
  }
}

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hook_up_rent/pages/community_picker.dart';
import 'package:hook_up_rent/pages/home/index.dart';
import 'package:hook_up_rent/pages/login.dart';
import 'package:hook_up_rent/pages/not_found.dart';
import 'package:hook_up_rent/pages/register.dart';
import 'package:hook_up_rent/pages/room_add/index.dart';
import 'package:hook_up_rent/pages/room_detail/index.dart';
import 'package:hook_up_rent/pages/room_manage/index.dart';
import 'package:hook_up_rent/pages/setting.dart';

class Routes {
  //1、定义路由名称

  static String home='/';
  static String login='/login';
  static String roomDetail='/roomDetail/:roomId';
  static String register='/register';
  static String setting='/setting';
  static String roomManage='/roomManage';
  static String roomAdd='/roomAdd';
  static String communityPicker='/communityPicker';

  //2、定义路由处理函数
  static final Handler _homeHandler = Handler(handlerFunc: (context, parameters) {
    return  const HomePage();
  });
   
  static final Handler _loginHandler = Handler(handlerFunc: (context, parameters) {
    return  const LoginPage();
  });
  
  static final Handler _notFoundHandler = Handler(handlerFunc: (context, parameters) {
    return  const NotFoundPage();
  });

  static final Handler _roomDetailHandler = Handler(handlerFunc: (context, parameters) {
    return RoomDetailPage(roomId: parameters['roomId']![0]);
  });

  static final Handler _registerHandler = Handler(handlerFunc: (context, parameters) {
    return  const RegisterPage();
  });

  static final Handler _settingHandler = Handler(handlerFunc: (context, parameters) {
    return  const SettingPage();
  });

  static final Handler _roomManageHandler = Handler(handlerFunc: (context, parameters) {
    return  const RoomManagePage();
  });

  static final Handler _roomAddHandler = Handler(handlerFunc: (context, parameters) {
    return  const RoomAddPage();
  });

  static final Handler _communityPickerHandler = Handler(handlerFunc: (context, parameters) {
    return  const CommunityPickerPage();
  });

  //3、编写函数 configureRoutes 关联路由名称和处理函数
  static void configureRoutes(FluroRouter router) {
    router.define(home, handler: _homeHandler);
    router.define(login, handler: _loginHandler);
    router.define(register, handler: _registerHandler);
    router.define(roomDetail, handler: _roomDetailHandler);
    router.define(setting, handler: _settingHandler);
    router.define(roomManage, handler: _roomManageHandler);
    router.define(roomAdd, handler: _roomAddHandler);
    router.define(communityPicker, handler: _communityPickerHandler);
    router.notFoundHandler=_notFoundHandler;
  }
}
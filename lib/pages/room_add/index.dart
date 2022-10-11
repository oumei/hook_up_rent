import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hook_up_rent/models/community.dart';
import 'package:hook_up_rent/models/general_type.dart';
import 'package:hook_up_rent/scoped_model/auth.dart';
import 'package:hook_up_rent/utils/common_toast.dart';
import 'package:hook_up_rent/utils/dio_http.dart';
import 'package:hook_up_rent/utils/scoped_model_helper.dart';
import 'package:hook_up_rent/utils/string_is_null_or_empty.dart';
import 'package:hook_up_rent/utils/upload_images.dart';
import 'package:hook_up_rent/widgets/common_floating_action_button.dart';
import 'package:hook_up_rent/widgets/common_form_item.dart';
import 'package:hook_up_rent/widgets/common_image_picker.dart';
import 'package:hook_up_rent/widgets/common_radio_form_item.dart';
import 'package:hook_up_rent/widgets/common_select_form_item.dart';
import 'package:hook_up_rent/widgets/common_title.dart';
import 'package:hook_up_rent/widgets/room_appliance.dart';

class RoomAddPage extends StatefulWidget {
  const RoomAddPage({Key? key}) : super(key: key);

  @override
  State<RoomAddPage> createState() => _RoomAddPageState();
}

class _RoomAddPageState extends State<RoomAddPage> {
  List<GeneralType> floorList = [];
  List<GeneralType> orientedList = [];
  List<GeneralType> roomTypeList = [];
  int rentType = 0;
  int decorationType = 0;
  int roomType = 0;
  int floor = 0;
  int oriented = 0;
  List<File> images = [];

  var titleController = TextEditingController();
  var descController = TextEditingController();
  var sizeController = TextEditingController();
  var priceController = TextEditingController();

  Community? community;
  List<RoomApplianceItem>? applicanceList;

  _getParams() async {
    String url = '/houses/params';
    var res = await DioHttp.of(context).get(url);
    var data = json.decode(res.toString())['body'];
    List<GeneralType> floorList = List<GeneralType>.from(
        data['floor'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> orientedList = List<GeneralType>.from(
        data['oriented'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> roomTypeList = List<GeneralType>.from(
        data['roomType'].map((item) => GeneralType.fromJson(item)).toList());

    setState(() {
      this.floorList = floorList;
      this.orientedList = orientedList;
      this.roomTypeList = roomTypeList;
    });
  }

  @override
  void initState() {
    Timer.run(_getParams);
    super.initState();
  }

  _submit() async {
    var size = sizeController.text;
    var price = priceController.text;
    if (stringIsNullOrEmpty(size)){
      CommonToast.showToast('大小不能为空');
      return;
    }
    if (stringIsNullOrEmpty(price)){
      CommonToast.showToast('租金不能为空');
      return;
    }
    if (community == null){
      CommonToast.showToast('小区不能为空');
      return;
    }
    var imageString = await uploadImages(images, context);
    Map<String,dynamic> params = {
      'title':titleController.text,
      'description':descController.text,
      'price':price,
      'size':size,
      'oriented':orientedList[oriented].id,
      'roomType':roomTypeList[roomType].id,
      'floor':floorList[floor].id,
      'community':community!.id,
      'houseImg':imageString,
      'supporting':applicanceList == null ? '' : applicanceList!.map((e) => e.title).join('|'),
    };
    var token = ScopedModelHelper.getModel<AuthModel>(context).token;
    String url = '/user/houses';
    
    var res = await DioHttp.of(context).post(url,params,token).catchError((onError){
      CommonToast.showToast(onError.error);
    });
    var status = json.decode(res.toString())['status'];
    if(status.toString().startsWith('2')){
      CommonToast.showToast('房源发布成功');
      bool isSubmitted = true;
      Navigator.of(context).pop(isSubmitted);
    } else {
      var desc = json.decode(res.toString())['description'];
      CommonToast.showToast(desc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('房源发布'),
      ),
      body: ListView(
        children: [
          CommonTitle('房源信息'),
          CommonFormItem(
            label: '小区',
            contentBuilder: (context) {
              return Container(
                  child: GestureDetector(
                //默认空白区域点击事件不生效，需要设置 behavior
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  var result = Navigator.of(context).pushNamed('communityPicker');
                  result.then((value) {
                    if(value != null) {
                      setState(() {
                        community = value as Community?;
                      });
                    }
                  });
                },
                child: Container(
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        community != null?community!.name:'请选择小区',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ),
              ));
            },
          ),
          CommonFormItem(
            label: '租金',
            hintText: '请输入租金',
            suffixText: '元/月',
            controller: priceController,
          ),
          CommonFormItem(
            label: '大小',
            hintText: '请输入房屋大小',
            suffixText: '平方米',
            controller: sizeController,
          ),
          CommonRadioFormItem(
              label: '租赁方式',
              options: const ['合租', '整租'],
              value: rentType,
              onChanged: (index) {
                setState(() {
                  rentType = index!;
                });
              }),
          if(roomTypeList.isNotEmpty)CommonSelectFormItem(
            label: '户型',
            options: roomTypeList.map((e) => e.name).toList(),
            value: roomType,
            onChanged: (value) {
              setState(() {
                roomType = value;
              });
            },
          ),
          if(floorList.isNotEmpty)CommonSelectFormItem(
            label: '楼层',
            options: floorList.map((e) => e.name).toList(),
            value: floor,
            onChanged: (value) {
              setState(() {
                floor = value;
              });
            },
          ),
          if(orientedList.isNotEmpty)CommonSelectFormItem(
            label: '朝向',
            options: orientedList.map((e) => e.name).toList(),
            value: oriented,
            onChanged: (value) {
              setState(() {
                oriented = value;
              });
            },
          ),
          CommonRadioFormItem(
              label: '装修',
              options: const ['精装', '简装'],
              value: decorationType,
              onChanged: (index) {
                setState(() {
                  decorationType = index!;
                });
              }),
          CommonTitle('房屋图像'),
          CommonImagePicker(onChanged: (List<File> files) {
            setState(() {
              images = files;
            });
          }),
          CommonTitle('房屋标题'),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0), //水平方向
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '请输入标题（例如：整租，小区名 2室 2000元）',
              ),
            ),
          ),
          CommonTitle('房屋配置'),
          RoomAppliance(
            onChanged: (data) {
              applicanceList = data;
            },
          ),
          CommonTitle('房屋描述'),
          Container(
            margin: const EdgeInsets.only(bottom: 100.0),
            padding: const EdgeInsets.symmetric(horizontal: 10.0), //水平方向
            child: TextField(
              controller: descController,
              maxLines: 10,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '请输入房屋描述信息',
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CommonFloatingActionButton('提交', _submit),
    );
  }
}

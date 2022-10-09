import 'dart:io';

import 'package:flutter/material.dart';
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
  int rentType = 0;
  int decorationType = 0;
  int roomType = 0;
  int floor = 0;
  int oriented = 0;
  var titleController = TextEditingController();
  var descController = TextEditingController();
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
                  Navigator.of(context).pushNamed('search');
                },
                child: Container(
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        '请选择小区',
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
            controller: TextEditingController(),
          ),
          CommonFormItem(
            label: '大小',
            hintText: '请输入房屋大小',
            suffixText: '平方米',
            controller: TextEditingController(),
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
          CommonSelectFormItem(
            label: '户型',
            options: const ['一室', '二室', '三室', '四室'],
            value: roomType,
            onChanged: (value) {
              setState(() {
                roomType = value;
              });
            },
          ),
          CommonSelectFormItem(
            label: '楼层',
            options: const ['高楼层', '中楼层', '低楼层'],
            value: floor,
            onChanged: (value) {
              setState(() {
                floor = value;
              });
            },
          ),
          CommonSelectFormItem(
            label: '朝向',
            options: const ['东', '南', '西', '北'],
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
          CommonImagePicker(onChanged: (List<File> files) {}),
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
          RoomAppliance(onChanged: (data) {
            
          },),
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
      floatingActionButton: CommonFloatingActionButton('提交', () {}),
    );
  }
}

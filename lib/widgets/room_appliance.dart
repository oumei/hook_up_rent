import 'package:flutter/material.dart';
import 'package:hook_up_rent/config.dart';
import 'package:hook_up_rent/widgets/common_check_button.dart';

class RoomApplianceItem {
  final String title;
  final int iconPoint;
  final bool isChecked;
  const RoomApplianceItem(this.title, this.iconPoint, this.isChecked);
}

const List<RoomApplianceItem> _dataList = [
  RoomApplianceItem('衣柜', 0xe918, false),
  RoomApplianceItem('洗衣机', 0xe917, false),
  RoomApplianceItem('空调', 0xe90d, false),
  RoomApplianceItem('天然气', 0xe90f, false),
  RoomApplianceItem('冰箱', 0xe907, false),
  RoomApplianceItem('暖气', 0xe910, false),
  RoomApplianceItem('电视', 0xe908, false),
  RoomApplianceItem('热水器', 0xe912, false),
  RoomApplianceItem('宽带', 0xe90e, false),
  RoomApplianceItem('沙发', 0xe913, false),
];

class RoomAppliance extends StatefulWidget {
  final ValueChanged<List<RoomApplianceItem>>? onChanged;
  const RoomAppliance({Key? key, this.onChanged}) : super(key: key);

  @override
  State<RoomAppliance> createState() => _RoomApplianceState();
}

class _RoomApplianceState extends State<RoomAppliance> {
  List<RoomApplianceItem> list = _dataList;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 30.0,
      children: list
          .map((e) => GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  setState(() {
                    list = list
                        .map((newItem) => newItem == e
                            ? RoomApplianceItem(
                                e.title, e.iconPoint, !e.isChecked)
                            : newItem)
                        .toList();
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(list);
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Column(
                    children: [
                      Icon(
                        IconData(e.iconPoint, fontFamily: Config.CommonIcon),
                        size: 40.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(e.title),
                      ),
                      CommonCheckButton(e.isChecked),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class RoomApplianceList extends StatelessWidget {
  final List<String> list;
  const RoomApplianceList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var showList = _dataList.where((element) => list.contains(element.title)).toList();
   if (showList.isEmpty || showList.length == 0) {
      return Container(
        padding: const EdgeInsets.only(left: 10.0),
        child: const Text('暂无房屋配置信息'),
      );
    }
    return Wrap(
      runSpacing: 30.0,
      children: showList
          .map((e) => Container(
                width: MediaQuery.of(context).size.width / 5,
                child: Column(
                  children: [
                    Icon(
                      IconData(e.iconPoint, fontFamily: Config.CommonIcon),
                      size: 40.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(e.title),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

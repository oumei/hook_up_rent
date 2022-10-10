import 'package:flutter/material.dart';
import 'package:hook_up_rent/models/general_type.dart';
// import 'package:hook_up_rent/pages/home/tab_search/filter_bar/data.dart';
import 'package:hook_up_rent/scoped_model/room_filter.dart';
import 'package:hook_up_rent/utils/scoped_model_helper.dart';
import 'package:hook_up_rent/widgets/common_title.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dataList = ScopedModelHelper.getModel<FilterBarModel>(context).dataList;
    var roomTypeList = dataList['roomTypeList'];
    var orientedList = dataList['orientedList'];
    var floorList = dataList['floorList'];

    var selectedIds = ScopedModelHelper.getModel<FilterBarModel>(context)
        .selectedList
        .toList();
    _onChange(String val) {
      ScopedModelHelper.getModel<FilterBarModel>(context)
          .selectedListToggleItem(val);
    }

    return Drawer(
      child: SafeArea(
          child: ListView(
        children: [
          const CommonTitle('户型'),
          FilterDrawerItem(list: roomTypeList, selectedIds: selectedIds,onChanged: _onChange,),
          const CommonTitle('朝向'),
          FilterDrawerItem(list: orientedList, selectedIds: selectedIds,onChanged: _onChange,),
          const CommonTitle('楼层'),
          FilterDrawerItem(list: floorList, selectedIds: selectedIds,onChanged: _onChange,),
        ],
      )),
    );
  }
}

class FilterDrawerItem extends StatelessWidget {
  final List<GeneralType> list;
  final List<String> selectedIds;
  final ValueChanged<String>? onChanged;
  const FilterDrawerItem({
    Key? key,
    required this.list,
    required this.selectedIds,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: list.map((e) {
          var isActive = selectedIds.contains(e.id);
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (onChanged != null) {
                onChanged!(e.id);
              }
            },
            child: Container(
              width: 100.0,
              height: 40.0,
              decoration: BoxDecoration(
                  color: isActive ? Colors.green : Colors.white,
                  border: Border.all(width: 1.0, color: Colors.green)),
              child: Center(
                child: Text(
                  e.name,
                  style:
                      TextStyle(color: isActive ? Colors.white : Colors.green),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

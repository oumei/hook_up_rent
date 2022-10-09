import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hook_up_rent/models/general_type.dart';
import 'package:hook_up_rent/pages/home/tab_search/filter_bar/data.dart';
import 'package:hook_up_rent/pages/home/tab_search/filter_bar/item.dart';
import 'package:hook_up_rent/scoped_model/room_filter.dart';
import 'package:hook_up_rent/utils/common_picker/index.dart';
import 'package:hook_up_rent/utils/scoped_model_helper.dart';

class FilterBar extends StatefulWidget {
  final ValueChanged<FilterBarResult> onChanged;
  const FilterBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  bool isAreaActive = false;
  bool isRentTypeActive = false;
  bool isPriceActive = false;
  bool isFilterActive = false;

  String areaId = '';
  String rentTypeId = '';
  String priceId = '';
  List<String> moreIds = [];

  _onAreaChange(context) {
    setState(() {
      isAreaActive = true;
    });
    var result = CommonPicker.showPicker(
        context, areaList.map((e) => e.name).toList(), 0);
    result.then((index) {
      if (index == null) return;
      setState(() {
        areaId = areaList[index].id;
      });
    }).whenComplete(() {
      setState(() {
        isAreaActive = false;
      });
    });
    _onChange();
  }

  _onRentTypeChange(context) {
    setState(() {
      isRentTypeActive = true;
    });
    var result = CommonPicker.showPicker(
        context, rentTypeList.map((e) => e.name).toList(), 0);
    result.then((index) {
      if (index == null) return;
      setState(() {
        rentTypeId = rentTypeList[index].id;
      });
    }).whenComplete(() {
      setState(() {
        isRentTypeActive = false;
      });
    });
    _onChange();
  }

  _onPriceChange(context) {
    setState(() {
      isPriceActive = true;
    });
    var result = CommonPicker.showPicker(
        context, priceList.map((e) => e.name).toList(), 0);
    result.then((index) {
      if (index == null) return;
      setState(() {
        priceId = priceList[index].id;
      });
    }).whenComplete(() {
      setState(() {
        isPriceActive = false;
      });
    });
    _onChange();
  }

  _onFilterChange(context) {
    Scaffold.of(context).openEndDrawer();
  }

  _onChange() {
    var selectedList = ScopedModelHelper.getModel<FilterBarModel>(context).selectedList;
    if (widget.onChanged != null) {
      widget.onChanged(FilterBarResult(areaId, priceId, rentTypeId, selectedList.toList()));
    }
  }

  _getData(){
    Map<String, List<GeneralType>> dataList = Map<String, List<GeneralType>>();
    dataList['roomTypeList'] = roomTypeList;
    dataList['orientedList'] = orientedList;
    dataList['floorList'] = floorList;
    ScopedModelHelper.getModel<FilterBarModel>(context).dataList = dataList;
  }

  @override
  void initState() {
    Timer.run(_getData);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _onChange();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41.0,
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.black12, width: 1.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Item(title: '区域', isActive: isAreaActive, onTap: _onAreaChange),
          Item(
              title: '方式',
              isActive: isRentTypeActive,
              onTap: _onRentTypeChange),
          Item(title: '租金', isActive: isPriceActive, onTap: _onPriceChange),
          Item(title: '筛选', isActive: isFilterActive, onTap: _onFilterChange),
        ],
      ),
    );
  }
}

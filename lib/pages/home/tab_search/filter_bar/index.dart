import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hook_up_rent/models/general_type.dart';
import 'package:hook_up_rent/pages/home/tab_profile/function_button_data.dart';
import 'package:hook_up_rent/pages/home/tab_search/filter_bar/data.dart';
import 'package:hook_up_rent/pages/home/tab_search/filter_bar/item.dart';
import 'package:hook_up_rent/scoped_model/room_filter.dart';
import 'package:hook_up_rent/utils/common_picker/index.dart';
import 'package:hook_up_rent/utils/dio_http.dart';
import 'package:hook_up_rent/utils/scoped_model_helper.dart';

String? lastCityId;

class FilterBar extends StatefulWidget {
  final ValueChanged<FilterBarResult> onChanged;
  const FilterBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  List<GeneralType> areaList = [];

  List<GeneralType> priceList = [];

  List<GeneralType> rentTypeList = [];

  List<GeneralType> roomTypeList = [];

  List<GeneralType> orientedList = [];

  List<GeneralType> floorList = [];

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
      _onChange();
    }).whenComplete(() {
      setState(() {
        isAreaActive = false;
      });
    });
    // _onChange();
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
      _onChange();
    }).whenComplete(() {
      setState(() {
        isRentTypeActive = false;
      });
    });
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
      _onChange();
    }).whenComplete(() {
      setState(() {
        isPriceActive = false;
      });
    });
    
  }

  _onFilterChange(context) {
    Scaffold.of(context).openEndDrawer();
  }

  _onChange() {
    var selectedList =
        ScopedModelHelper.getModel<FilterBarModel>(context).selectedList;
    if (widget.onChanged != null) {
      widget.onChanged(
          FilterBarResult(areaId, priceId, rentTypeId, selectedList.toList()));
    }
  }

  _getData() async{
    var cityId = ScopedModelHelper.getAreaId(context);
    lastCityId = cityId;
    final url = '/houses/condition?id=$cityId';
    var res = await DioHttp.of(context).get(url);
    var data = json.decode(res.toString())['body'];
    
    //????????????????????????return
    if(!mounted){
      return;
    }
    
    List<GeneralType> areaList = List<GeneralType>.from(data['area']['children']
        .map((item) => GeneralType.fromJson(item))
        .toList());
    List<GeneralType> priceList = List<GeneralType>.from(
        data['price'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> rentTypeList = List<GeneralType>.from(
        data['rentType'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> roomTypeList = List<GeneralType>.from(
        data['roomType'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> orientedList = List<GeneralType>.from(
        data['oriented'].map((item) => GeneralType.fromJson(item)).toList());
    List<GeneralType> floorList = List<GeneralType>.from(
        data['floor'].map((item) => GeneralType.fromJson(item)).toList());

    setState(() {
      this.areaList = areaList;
      this.priceList = priceList;
      this.rentTypeList = rentTypeList;
      this.roomTypeList = roomTypeList;
      this.orientedList = orientedList;
      this.floorList = floorList;
    });

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
    if (lastCityId != null && ScopedModelHelper.getAreaId(context) != lastCityId){
      _getData();
    }
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
          Item(title: '??????', isActive: isAreaActive, onTap: _onAreaChange),
          Item(
              title: '??????',
              isActive: isRentTypeActive,
              onTap: _onRentTypeChange),
          Item(title: '??????', isActive: isPriceActive, onTap: _onPriceChange),
          Item(title: '??????', isActive: isFilterActive, onTap: _onFilterChange),
        ],
      ),
    );
  }
}

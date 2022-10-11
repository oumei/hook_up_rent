import 'dart:convert';
import 'dart:ffi';

import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:hook_up_rent/config.dart';
import 'package:hook_up_rent/models/general_type.dart';
import 'package:hook_up_rent/scoped_model/city.dart';
import 'package:hook_up_rent/utils/common_toast.dart';
import 'package:hook_up_rent/utils/scoped_model_helper.dart';
import 'package:hook_up_rent/utils/store.dart';
import 'package:hook_up_rent/widgets/common_image.dart';

class SearchBar extends StatefulWidget {
  final bool showLocation; //展示位置按钮
  final Function? goBackCallback; //回退按钮函数
  final String? inputValue; //搜索框输入值
  final String? defaultInputValue; //搜索框默认值
  final Function? onCancel; //取消按钮
  final bool showMap; //展示地图按钮
  final Function()? onSearch; //用户点击搜索框触发
  final ValueChanged<String>? onSearchSubmit; //用户输入搜索词后，点击搜索

  const SearchBar(
      {Key? key,
      this.showLocation = false,
      this.goBackCallback,
      this.inputValue = '',
      this.defaultInputValue = '请输入搜索词',
      this.onCancel,
      this.showMap = false,
      this.onSearch,
      this.onSearchSubmit})
      : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String _searchWord='';
  TextEditingController? _controller;
  FocusNode? _focus;
  _onClean() {
    _controller?.clear();
    setState(() {
      _searchWord='';
    });
  }

  _saveCity(GeneralType city) async {
    if (city == null) return;
    ScopedModelHelper.getModel<CityModel>(context).city = city;
    var store = await Store.getInstance();
    var cityString = json.encode(city.toJson());
    store.setString(StoreKeys.city, cityString);
  }

  _changeLocation() async {
    var result = await CityPickers.showCitiesSelector(
      context: context,
      // theme: ThemeData(primaryColor: Colors.green),
      );
    
    String? cityName = result?.cityName;

    if (cityName == null) return;

    var city = Config.availabelCitys.firstWhere((city) => cityName.startsWith(city!.name),orElse:(){
      CommonToast.showToast('该城市暂未开通');
      return null;
    } );

    if (city == null) return;

    _saveCity(city);
  }

  _getCity() async {
    var store = await Store.getInstance();
    var cityString = await store.getString(StoreKeys.city);
    if (cityString == null)return;
    var city = GeneralType.fromJson(json.decode(cityString));
    ScopedModelHelper.getModel<CityModel>(context).city = city;
  }

  @override
  void initState() {
    _focus = FocusNode();
    _controller=TextEditingController(text: widget.inputValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var city = ScopedModelHelper.getModel<CityModel>(context).city;
    if (city == null){
      city = Config.availabelCitys.first;
      _getCity();
    }
    return Container(
      child: Row(
        children: [
          if (widget.showLocation)
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  _changeLocation();
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.room,
                      color: Colors.green,
                      size: 16.0,
                    ),
                    Text(
                      city.name,
                      style: const TextStyle(color: Colors.black, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          if (widget.goBackCallback != null)
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  widget.goBackCallback!();
                },
                child: const Icon(
                  Icons.chevron_left,
                  color: Colors.black87,
                ),
              ),
            ),
          Expanded(
              child: Container(
            height: 34.0,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(17.0)),
            margin: const EdgeInsets.only(right: 10.0),
            child: TextField(
              focusNode: _focus,
              onTap: () {
                if(widget.onSearchSubmit==null){
                  _focus?.unfocus();
                }
                if (widget.onSearch != null)widget.onSearch!();
              },
              onSubmitted: widget.onSearchSubmit,
              textInputAction: TextInputAction.search,
              controller: _controller,
              style: const TextStyle(fontSize: 14.0),
              onChanged: (value) {
                setState(() {
                  _searchWord=value;
                });
              },
              decoration: InputDecoration(
                  hintText: '请输入搜索词',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
                  contentPadding: const EdgeInsets.only(top: 1.0, left: -10.0),
                  border: InputBorder.none,
                  icon: const Padding(
                      padding: EdgeInsets.only(top: 3.0, left: 8.0),
                      child: Icon(
                        Icons.search,
                        size: 18.0,
                        color: Colors.grey,
                      )),
                  suffixIcon: GestureDetector(
                    onTap: _onClean,
                    child: Icon(
                      Icons.clear,
                      size: 18.0,
                      color:_searchWord==''? Colors.grey[200]:Colors.grey,
                  ),)
                  ),
            ),
          )),
          if (widget.onCancel != null)
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                  onTap: () {
                    widget.onCancel!();
                  },
                  child: const Text(
                    '取消',
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  )),
            ),
          if (widget.showMap)
            const CommonImage(
              'static/icons/widget_search_bar_map@2x.png',
              width: 24.0,
              height: 24.0,
            ),
        ],
      ),
    );
  }
}

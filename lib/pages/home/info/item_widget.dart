import 'package:flutter/material.dart';
import 'package:hook_up_rent/config.dart';
import 'package:hook_up_rent/models/info_item.dart';
import 'package:hook_up_rent/pages/home/info/data.dart';
import 'package:hook_up_rent/pages/home/tab_index/index_recommond_item_widget.dart';
import 'package:hook_up_rent/widgets/common_image.dart';

var textStyle = const TextStyle(color: Colors.black54);

class ItemWidget extends StatelessWidget {
  final InfoItem data;
  const ItemWidget(this.data, {Key? key}) : super(key: key);

  get children => null;

  @override
  Widget build(BuildContext context) {
    var imageUrl = data.imageUri.startsWith('http')
        ? data.imageUri
        : Config.BaseUrl + data.imageUri;
    return Container(
      height: 100.0,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: Row(
        children: [
          CommonImage(
            imageUrl,
            width: 120.0,
            height: 90.0,
          ),
          const Padding(padding: EdgeInsets.only(left: 10.0)),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.source,
                    style: textStyle,
                  ),
                  Text(
                    data.time,
                    style: textStyle,
                  ),
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }
}

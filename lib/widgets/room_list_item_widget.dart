import 'package:flutter/material.dart';
import 'package:hook_up_rent/config.dart';
import 'package:hook_up_rent/models/room_list_item_data.dart';
// import 'package:hook_up_rent/pages/home/tab_index/index_recommond_item_widget.dart';
// import 'package:hook_up_rent/pages/home/tab_search/data_list.dart';
import 'package:hook_up_rent/widgets/common_image.dart';
import 'package:hook_up_rent/widgets/common_tag.dart';

class RoomListItemWidget extends StatelessWidget {
  final RoomListItemData data;
  const RoomListItemWidget(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUrl = data.imageUri.startsWith('http')?data.imageUri:Config.BaseUrl+data.imageUri;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context).pushNamed('roomDetail/${data.id}');
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: Row(
          children: [
            CommonImage(
              imageUrl,
              width: 132.5,
              height: 90.0,
            ),
            const Padding(padding: EdgeInsets.only(left: 10.0)),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  data.subTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Wrap(
                  children: data.tags.map((e) => CommonTag(e)).toList(),
                ),
                Text(
                  '${data.price} 元/月',
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

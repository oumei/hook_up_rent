import 'package:flutter/material.dart';
import 'package:hook_up_rent/models/room_detail_data.dart';

// class RoomDetailData {
//   String id;
//   String title;
//   String community;
//   String subTitle;
//   int size;
//   String floor;
//   int price;
//   String roomType;
//   List<String> houseImgs;
//   List<String> tags;
//   List<String> oriented;
//   List<String> appliances;
  
//   RoomDetailData(
//     this.id,
//     this.title,
//     this.community,
//     this.subTitle,
//     this.size,
//     this.floor,
//     this.price,
//     this.roomType,
//     this.houseImgs,
//     this.tags,
//     this.oriented,
//     this.appliances,
//     );
// }

var defaultData=RoomDetailData(
  '1111', 
  '整租 中山路 历史最低价', 
  '中山花园', 
  '近地铁，附近有商场！',
  100, 
  '高楼层', 
  3000, 
  '三室', 
  ['http://ww3.sinaimg.cn/large/006y8mN6ly1g6e2tdgve1j30ku0bsn75.jpg',
  'http://ww3.sinaimg.cn/large/006y8mN6ly1g6e2whp87sj30ku0bstec.jpg',
  'http://ww3.sinaimg.cn/large/006y8mN6ly1g6e2tl1v3bj30ku0bs77z.jpg',], 
  ['近地铁','集中供暖','新上','随时看房'], 
  ['南'], 
  ['衣柜','洗衣机']
  );
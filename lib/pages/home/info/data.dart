import 'package:flutter/material.dart';

class InfoItem {
  final String title;
  final String imageUri;
  final String source;
  final String time;
  final String navigateUri;

  const InfoItem(this.title,this.imageUri,this.source,this.time,this.navigateUri);
}

const List<InfoItem> infoData=[
  InfoItem('置业选择｜安贞西里 三室一厅 河间的古雅别院', 'http://wx2.sinaimg.cn/mw1024/005SQLxwly1g6f89l4obbj305v04fjsw.jpg', '新华网', '两天前', 'login'),
  InfoItem('置业选择｜大理王宫 苍山的古雅别院', 'http://wx2.sinaimg.cn/mw1024/005SQLxwly1g6f89l4obbj305v04fjsw.jpg', '新华网', '一周前', 'login'),
  InfoItem('置业选择｜安居小屋 花园洋楼 清新别野', 'http://wx2.sinaimg.cn/mw1024/005SQLxwly1g6f89l4obbj305v04fjsw.jpg', '新华网', '一周前', 'login'),
];
import 'package:flutter/material.dart';

class IndexRecommondItem {
  final String title;
  final String subTitle;
  final String imageUri;
  final String navigateUri;

  const IndexRecommondItem(this.title,this.subTitle,this.imageUri,this.navigateUri);
}

const List<IndexRecommondItem> indexRecommondData = [
  IndexRecommondItem('家住回龙观', '归属的感觉', 'static/images/home_index_recommend_1.png', 'login'),
  IndexRecommondItem('宜居四五环', '大都市生活', 'static/images/home_index_recommend_2.png', 'login'),
  IndexRecommondItem('喧嚣三里屯', '繁华的背后', 'static/images/home_index_recommend_3.png', 'login'),
  IndexRecommondItem('比邻十号线', '地铁心连心', 'static/images/home_index_recommend_4.png', 'login'),
];
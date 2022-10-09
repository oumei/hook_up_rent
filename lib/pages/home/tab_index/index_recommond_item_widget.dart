import 'package:flutter/material.dart';
import 'package:hook_up_rent/pages/home/tab_index/index_recommond_data.dart';
import 'package:hook_up_rent/widgets/common_image.dart';

var textStyle=const TextStyle(fontSize: 14,fontWeight: FontWeight.w500);

class IndexRecommondItemWidget extends StatelessWidget {
  final IndexRecommondItem data;

  const IndexRecommondItemWidget(this.data,{super.key, });
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(data.navigateUri);
      },
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        width: (MediaQuery.of(context).size.width-10*3)/2,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Text(data.title,style: textStyle,),
              Text(data.subTitle,style: textStyle,),
          ],),
          CommonImage(data.imageUri,width: 55.0,),
        ],),
        ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:hook_up_rent/pages/home/tab_profile/function_button_data.dart';
import 'package:hook_up_rent/widgets/common_image.dart';

class FunctionButtonWidget extends StatelessWidget {
  final FunctionButtonItem data;
  const FunctionButtonWidget(this.data,{ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (data.onTapHandle != null) {
          data.onTapHandle!(context);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 30.0),
        width: MediaQuery.of(context).size.width*0.33,
        child: Column(
          children: [
            CommonImage(data.imageUri),
            Text(data.title),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:hook_up_rent/utils/common_picker/index.dart';
import 'package:hook_up_rent/utils/common_toast.dart';
import 'package:hook_up_rent/widgets/common_form_item.dart';

class CommonSelectFormItem extends StatelessWidget {
  final String label;
  final List<String> options;
  final int value;
  final ValueChanged<int> onChanged;

  const CommonSelectFormItem(
      {Key? key,
      required this.label,
      required this.options,
      required this.value,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonFormItem(
      label: label,
      contentBuilder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if(options.isEmpty){
              CommonToast.showToast('暂无选择内容');
              return;
            }
            var result = CommonPicker.showPicker(context, options, value);
            result.then((selectedValue) {
              if (value != selectedValue && selectedValue != null) {
                onChanged(selectedValue);
              }
            });
          },
          child: Container(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  options.isEmpty?'':options[value],
                  style: const TextStyle(fontSize: 16.0),
                ),
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        );
      },
    );
  }
}

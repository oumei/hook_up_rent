import 'package:flutter/material.dart';
import 'package:hook_up_rent/widgets/common_form_item.dart';

class CommonRadioFormItem extends StatelessWidget {
  final String label;
  final List<String> options;
  final int value;
  final ValueChanged<int?> onChanged;
  const CommonRadioFormItem(
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
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                options.length,
                (index) => Row(
                  children: [
                    Radio(
                        value: index,
                        groupValue: value,
                        onChanged: onChanged
                    ),
                    Text(options[index]),
                  ],
                )),
          ),
        );
      },
    );
  }
}

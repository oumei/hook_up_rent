import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const List<String> defaultImages = [
  'http://ww3.sinaimg.cn/large/006y8mN6ly1g6e2tdgve1j30ku0bsn75.jpg',
  'http://ww3.sinaimg.cn/large/006y8mN6ly1g6e2whp87sj30ku0bstec.jpg',
  'http://ww3.sinaimg.cn/large/006y8mN6ly1g6e2tl1v3bj30ku0bs77z.jpg',
];

//图片宽750px,高424px
var imageWidth = 750.0;
var imageHeight = 424.0;
var imageWidthHeightRatio = imageWidth / imageHeight;

class CommonImagePicker extends StatefulWidget {
  final ValueChanged<List<File>> onChanged;
  const CommonImagePicker({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<CommonImagePicker> createState() => _CommonImagePickerState();
}

class _CommonImagePickerState extends State<CommonImagePicker> {
  List<File> files = [];

  _pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      File imageFile = File(image.path);
      files = files..add(imageFile);
    });
    widget.onChanged(files);
  }

  @override
  Widget build(BuildContext context) {
    var width = (MediaQuery.of(context).size.width - 10.0 * 4) / 3;
    var height = width / imageWidthHeightRatio;

    Widget addButton = GestureDetector(
      onTap: () {
        _pickImage();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: width,
        height: height,
        color: Colors.grey,
        child: const Center(
          child: Text(
            '+',
            style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w100),
          ),
        ),
      ),
    );

    Widget wrapper(File file) {
      return Stack(
        clipBehavior:Clip.none,//设置超出视图不被剪切
        children: [
          Image.file(
            file,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
          Positioned(
              right: -20.0,
              top: -20.0,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      files=files..remove(file);
                    });
                    widget.onChanged(files);
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  )))
        ],
      );
    }

    List<Widget> list = files.map((e) => wrapper(e)).toList()..add(addButton);

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: list,
      ),
    );
  }
}

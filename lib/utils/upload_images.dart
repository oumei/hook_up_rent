import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hook_up_rent/scoped_model/auth.dart';
import 'package:hook_up_rent/utils/common_toast.dart';
import 'package:hook_up_rent/utils/dio_http.dart';
import 'package:hook_up_rent/utils/scoped_model_helper.dart';

Future<String> uploadImages(List<File> files, BuildContext context) async {
  if (files == null || files.isEmpty) return Future.value('');
  FormData formData = FormData();
  List<MapEntry<String, MultipartFile>> list =
      List<MapEntry<String, MultipartFile>>.from(files
          .map((imgFile) => MapEntry(
              'file',
              MultipartFile.fromFileSync(imgFile.path.toString(),
                  filename: 'picture.jpg')))
          .toList());
  formData.files.addAll(list);

  String url = '/houses/image';
  var token = ScopedModelHelper.getModel<AuthModel>(context).token;
  var res = await DioHttp.of(context).postFormData(url, formData, token).catchError((onError){
    CommonToast.showToast(onError.error);
  });
  var data = json.decode(res.toString())['body'];
  String images = List<String>.from(data).join('|');

  return Future.value(images);
}

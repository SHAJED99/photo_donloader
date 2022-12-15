import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_donloader/services/fetch_data.dart';

class TotalImage extends StatelessWidget {
  TotalImage({super.key});

  final FetchData _fetchData = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: GetBuilder<FetchData>(builder: (_) {
        return Text(
          " ${_fetchData.imageData.photos!.length}/${_fetchData.imageData.totalresults} ",
        );
      }),
    );
  }
}

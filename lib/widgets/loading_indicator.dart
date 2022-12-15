import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_donloader/services/fetch_data.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({super.key});

  final FetchData _fetchData = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FetchData>(
      builder: (_) {
        if (_fetchData.isLoading) {
          return const LinearProgressIndicator(minHeight: 3);
        } else {
          return const SizedBox(
            height: 3,
          );
        }
      },
    );
  }
}

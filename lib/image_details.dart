import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_donloader/model/image_data.dart';
import 'package:photo_donloader/services/convert_color.dart';

class ImageDetails extends StatelessWidget {
  final Photo? photo;
  const ImageDetails({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: colorFromHex(photo!.avgcolor ?? ""),
            image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage(photo!.src!.original ?? ""),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(Icons.download),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

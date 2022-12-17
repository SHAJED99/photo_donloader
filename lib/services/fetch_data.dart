import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:photo_donloader/model/image_data.dart';
import 'package:http/http.dart' as http;
import 'package:photo_donloader/model/user_data.dart';

class FetchData extends GetxController {
  bool isLoading;
  final int _perPage = 30;
  int currentPage;
  String searchText;
  bool error = false;
  ImageData imageData = ImageData(page: 0, nextpage: "", perpage: 0, photos: [], totalresults: 0);

  FetchData({
    this.isLoading = false,
    this.currentPage = 1,
    this.searchText = "popular",
  });

  Future<void> getData({String search = "", int page = 1, bool doAdd = false}) async {
    if (search.isEmpty) search = searchText;
    print("FetchData.getData is running.");
    if (isLoading) return;
    error = false;
    isLoading = true;
    update();
    try {
      String tempString = _perPage > 0 ? "&per_page=$_perPage" : "";
      String query = "https://api.pexels.com/v1/search?page=$page&query=$search$tempString";
      var responce = await http.get(
        Uri.parse(query),
        headers: {"Authorization": apiKey},
      );
      Map<String, dynamic> jsonMetaData = jsonDecode(responce.body);
      ImageData tempImageData = ImageData.fromJson(jsonMetaData);
      if (doAdd) {
        imageData.page = tempImageData.page;
        imageData.error = tempImageData.error;
        imageData.nextpage = tempImageData.nextpage;
        imageData.perpage = tempImageData.perpage;
        imageData.totalresults = tempImageData.totalresults;
        imageData.photos!.addAll(tempImageData.photos ?? []);
      } else {
        imageData = tempImageData;
        currentPage = 1;
      }
      searchText = search;
    } on SocketException catch (_) {
      error = true;
      Get.snackbar(
        "Error",
        "Network connection failed. Please check your internet connection.",
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        margin: const EdgeInsets.all(10),
      );
    } catch (e) {
      error = true;
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        margin: const EdgeInsets.all(10),
      );
    }
    print(error.toString());
    isLoading = false;
    update();
  }

  void addData({int page = 1}) {
    getData(search: searchText, page: page, doAdd: true);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_donloader/services/fetch_data.dart';

class ImageTilesGridVie extends StatelessWidget {
  ImageTilesGridVie({super.key});
  final FetchData _fetchData = Get.find();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints boxConstraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GetBuilder<FetchData>(
              builder: (_) {
                print(_fetchData.currentPage);
                if (_fetchData.isLoading && _fetchData.imageData.photos!.isEmpty && !_fetchData.error) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!_fetchData.isLoading && _fetchData.imageData.photos!.isEmpty && _fetchData.error) {
                  return Center(
                      child: FloatingActionButton(
                          onPressed: () {
                            _fetchData.getData(search: _fetchData.searchText, page: _fetchData.currentPage);
                          },
                          child: const Icon(Icons.replay_outlined)));
                } else if (_fetchData.imageData.photos!.isEmpty && !_fetchData.error) {
                  return Center(
                      child: Text(
                    "No result found for \"${_fetchData.searchText}\"",
                    textAlign: TextAlign.center,
                  ));
                } else {
                  if (_scrollController.hasClients && _fetchData.currentPage == 1) _scrollController.jumpTo(0);
                  _scrollController.addListener(() {
                    if (!_fetchData.isLoading && _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
                      _fetchData.addData(page: ++_fetchData.currentPage);
                    }
                  });
                  return GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: boxConstraints.maxWidth < 600 ? 2 : 4,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: _fetchData.imageData.photos?.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: colorFromHex(_fetchData.imageData.photos![index]!.avgcolor ?? ""),
                          image: DecorationImage(image: NetworkImage(_fetchData.imageData.photos![index]!.src!.portrait ?? ""), fit: BoxFit.cover),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                              margin: const EdgeInsets.only(bottom: 2),
                              decoration: BoxDecoration(
                                color: colorFromHex(_fetchData.imageData.photos![index]!.avgcolor ?? "").withOpacity(0.75),
                              ),
                              child: Text(
                                _fetchData.imageData.photos![index]!.photographer ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 1,
                              right: 0,
                              child: Text(
                                " ${_fetchData.imageData.photos![index]!.width} x ${_fetchData.imageData.photos![index]!.height} ",
                                style: const TextStyle(fontSize: 10, backgroundColor: Colors.white),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

Color colorFromHex(String colorHex) {
  if (colorHex.isEmpty) {
    return Colors.white;
  } else {
    return Color(int.parse("0x${colorHex.replaceAll("#", "")}")).withOpacity(1.0);
  }
}

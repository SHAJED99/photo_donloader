import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_donloader/image_details.dart';
import 'package:photo_donloader/model/image_data.dart';
import 'package:photo_donloader/services/convert_color.dart';
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
                print(_fetchData.error);
                // When loading
                if (_fetchData.isLoading) {
                  // When there is no photos
                  if (_fetchData.imageData.photos!.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                } else {
                  // When error
                  if (_fetchData.error) {
                    // When there is no photos
                    if (_fetchData.imageData.photos!.isEmpty) {
                      return Center(
                        child: FloatingActionButton(
                          onPressed: () {
                            _fetchData.getData(search: _fetchData.searchText, page: _fetchData.currentPage);
                          },
                          child: const Icon(Icons.replay_outlined),
                        ),
                      );
                    }
                  } else {
                    // When there is no photos
                    if (_fetchData.imageData.photos!.isEmpty) {
                      return Center(
                        child: Text(
                          "No result found for \"${_fetchData.searchText}\"",
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                  }
                }
                if (_scrollController.hasClients && _fetchData.currentPage == 1) _scrollController.jumpTo(0);
                _scrollController.addListener(() {
                  if (!_fetchData.isLoading && _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
                    _fetchData.addData(page: ++_fetchData.currentPage);
                  }
                });
                return GridView.builder(
                  controller: _scrollController,
                  itemCount: _fetchData.imageData.photos!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: boxConstraints.maxWidth < 600 ? 2 : 4,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (context, index) {
                    return PhotoTile(
                      photo: _fetchData.imageData.photos![index],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class PhotoTile extends StatelessWidget {
  final Photo? photo;
  const PhotoTile({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorFromHex(photo!.avgcolor ?? ""),
        image: DecorationImage(image: NetworkImage(photo!.src!.portrait ?? ""), fit: BoxFit.cover),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.to(() => ImageDetails(photo: photo));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                margin: const EdgeInsets.only(bottom: 2),
                decoration: BoxDecoration(
                  color: colorFromHex(photo!.avgcolor ?? "").withOpacity(0.75),
                ),
                child: Text(
                  photo!.photographer ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  " ${photo!.width} x ${photo!.height} ",
                  style: const TextStyle(fontSize: 10, backgroundColor: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

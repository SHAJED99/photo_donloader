import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_donloader/model/data.dart';
import 'package:photo_donloader/services/fetch_data.dart';

class CategoryTitleScrollView extends StatelessWidget {
  const CategoryTitleScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: categories
            .map((e) => CategoryTitle(
                  title: e.categoriesName,
                  imgUrl: e.imgUrl,
                  boxWidth: 100,
                ))
            .toList(),
      ),
    );
  }
}

class CategoryTitle extends StatefulWidget {
  final String title, imgUrl;
  final double boxWidth;
  const CategoryTitle({super.key, required this.title, required this.imgUrl, this.boxWidth = 100});

  @override
  State<CategoryTitle> createState() => _CategoryTitleState();
}

class _CategoryTitleState extends State<CategoryTitle> {
  final FetchData _fetchData = Get.find();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      alignment: Alignment.center,
      // width: widget.boxWidth,
      constraints: BoxConstraints(
        minWidth: widget.boxWidth,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(widget.imgUrl),
          fit: BoxFit.cover,
          opacity: 0.8,
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: Material(
        color: Theme.of(context).dividerColor,
        child: InkWell(
          onTap: () async {
            _isLoading = true;
            setState(() {});
            await _fetchData.getData(search: widget.title);
            _isLoading = false;
            setState(() {});
          },
          child: Center(
            child: _isLoading
                ? AspectRatio(
                    aspectRatio: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(color: Theme.of(context).canvasColor, strokeWidth: 3),
                    ),
                  )
                : Text(
                    widget.title,
                    style: TextStyle(color: Theme.of(context).canvasColor, fontWeight: FontWeight.w500),
                  ),
          ),
        ),
      ),
    );
  }
}

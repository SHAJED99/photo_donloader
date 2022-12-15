import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_donloader/services/fetch_data.dart';
import 'package:photo_donloader/widgets/category_title_scroll_view.dart';
import 'package:photo_donloader/widgets/image_tiles.dart';
import 'package:photo_donloader/widgets/loading_indicator.dart';
import 'package:photo_donloader/widgets/search_bar.dart';
import 'package:flutter/services.dart';
import 'package:photo_donloader/widgets/total_image.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(
      GetMaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch}),
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    fetchData.getData();
  }
  final FetchData fetchData = Get.put(FetchData());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                LoadingIndicator(),
                const SearchBar(),
                const CategoryTitleScrollView(),
                ImageTilesGridVie(),
              ],
            ),
            Positioned(bottom: 2, right: 8, child: TotalImage()),
          ],
        ),
      ),
    );
  }
}

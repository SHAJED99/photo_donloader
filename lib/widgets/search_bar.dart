import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_donloader/services/fetch_data.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String? hintText;
  bool _isLoading = false;
  final FetchData _fetchData = Get.find();
  final TextEditingController _textEditingController = TextEditingController();

  onPress() async {
    if (_textEditingController.text.trim().isEmpty || _fetchData.isLoading) return;
    _isLoading = true;
    setState(() {});
    await _fetchData.getData(search: _textEditingController.text);
    _textEditingController.clear();
    hintText = "Search: ${_fetchData.searchText}";
    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onSubmitted: ((_) => onPress()),
              controller: _textEditingController,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                  hintText: hintText ?? "Search",
                  filled: true,
                  border: UnderlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(50.0)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16)),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400, letterSpacing: 1, height: 1),
            ),
          ),
          AspectRatio(
            aspectRatio: 1,
            child: _isLoading
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: CircularProgressIndicator(strokeWidth: 3),
                  )
                : GestureDetector(
                    onTap: () => onPress(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      child: const Icon(Icons.search),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

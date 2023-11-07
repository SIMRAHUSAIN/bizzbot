import 'package:flutter/material.dart';
import 'package:mim_whatsup/utils/colors.dart';
import 'package:mim_whatsup/utils/textstyle.dart';

class SearchBar extends StatefulWidget {

  void Function()? onPressed;
  TextEditingController searchController;
  bool searchEnabled;
  double barWidth;
  Function onChanged;

  SearchBar({
    Key? key,
    required this.onPressed,
    required this.searchController,
    required this.searchEnabled,
    this.barWidth = 200,
    required this.onChanged
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.only(right: 10),
      height: 45,
      width: widget.barWidth,
      decoration: BoxDecoration(
        color: cF6F6F6,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: c939292,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              child: TextField(
                  controller: widget.searchController,
                  enabled: widget.searchEnabled,
                  style: TextStyles.s14_w400_cB3AEAE,
                  textInputAction: TextInputAction.done,
                  cursorColor: c939292,
                  onChanged: (text){
                    widget.onChanged!(text);
                  },
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10, top: 10),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: c939292,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: c939292
                      ),
                      border: InputBorder.none)),
            ),
          ),
        ],
      ),
    );
  }
}
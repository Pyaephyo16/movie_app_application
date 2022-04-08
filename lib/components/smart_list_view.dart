import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie_app/resources/dimens.dart';

class SmartListView extends StatefulWidget {

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsets padding;
  final Function onListEndReached;

  SmartListView({
    required this.itemCount,
    required this.itemBuilder,
    required this.padding,
    required this.onListEndReached,
  });

  @override
  State<SmartListView> createState() => _SmartListViewState();
}

class _SmartListViewState extends State<SmartListView> {

    var _scrollController = ScrollController();

      @override
  void initState() {
      _scrollController.addListener(() {
            if(_scrollController.position.atEdge){
              if(_scrollController.position.pixels == 0){
                print("Start of the list reached");
              }else{
                print("End of the list reached");
                widget.onListEndReached();
              } 
            }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.itemCount == 0 ? 
         Center(child: Text("Sorry,No movies available for Today",
         style: TextStyle(
           color: Colors.white,
           fontSize: 22,
         ),
         ))
             : ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      padding: widget.padding,
                      itemCount: widget.itemCount,
                      itemBuilder: widget.itemBuilder,
                      ),
               
    );
  }
}
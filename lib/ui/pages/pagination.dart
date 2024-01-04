import 'package:flutter/material.dart';

class InfiniteScrollView extends StatefulWidget {
  @override
  _InfiniteScrollViewState createState() => _InfiniteScrollViewState();
}

class _InfiniteScrollViewState extends State<InfiniteScrollView> {
  List<int> items = List.generate(12, (index) => index); // initial list of items
  bool isLoading = false; // to check if new data is being loaded
  ScrollController _scrollController = ScrollController(); // controller to listen to scroll events

  @override
  void initState() {
    super.initState();
    // add a listener to the scroll controller to listen for scroll events
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // remove the listener when the widget is disposed
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  // called when the user scrolls the list
  void _scrollListener() {
    if (!isLoading && _scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // show progress indicator at the end when new data is being loaded
      setState(() {
        isLoading = true;
      });
      // simulate loading new data after a delay
      Future.delayed(Duration(seconds: 2)).then((_) {
        setState(() {
          items.addAll(List.generate(20, (index) => index + items.length)); // add new data to the list
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite Scroll View'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item ${items[index]}'),
          );
        },
        controller: _scrollController, // set the scroll controller
      ),
    );
  }
}

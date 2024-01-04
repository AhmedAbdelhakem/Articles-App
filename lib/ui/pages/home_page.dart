import 'package:articles/logic/articles/articles_cubit.dart';
import 'package:articles/ui/pages/loading_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ArticlesCubit cubit;
  List<int> items =
      List.generate(12, (index) => index); // initial list of items
  bool isLoading = false; // to check if new data is being loaded
  late ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    // create a ScrollPosition and attach it to the ScrollController
    _scrollController = ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
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
    if (!isLoading &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      // show progress indicator at the end when new data is being loaded
      setState(() {
        isLoading = true;
      });
      // simulate loading new data after a delay
      Future.delayed(const Duration(seconds: 2)).then((_) {
        setState(() {
          items.addAll(List.generate(
              20, (index) => index + items.length)); // add new data to the list
          isLoading = false;
        });
      });
    }
  }

  Future<void> _refresh() {
    return Future.delayed(const Duration(seconds: 1)).then((_) {
      setState(() {
        cubit.articles.isEmpty
            ? listBuildEmptyItem()
            : Container(
                padding: const EdgeInsets.all(10),
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) =>
                          buildTaskItem(cubit.articles[index]),
                      itemCount: cubit.articles.length,
                      controller: _scrollController,
                    ),
                  ),
                ),
              );
      });
    });
  }

  Future<void> launcherURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticlesCubit, ArticlesState>(
      listener: (context, state) {},
      builder: (context, state) {
        cubit = ArticlesCubit.get(context);
        return cubit.articles.isEmpty
            ? listBuildEmptyItem()
            : Container(
                padding: const EdgeInsets.all(10),
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  color: Colors.amber,
                  child: CupertinoScrollbar(
                    child: ListView.builder(
                      itemBuilder: (context, index) =>
                          buildTaskItem(cubit.articles[index]),
                      itemCount: cubit.articles.length,
                      controller: _scrollController,
                    ),
                  ),
                ),
              );
      },
    );
  }

  Widget buildEmptyDesign() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Loading(
            height: 200,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Loading(
                  height: 20,
                  width: 90,
                ),
                const SizedBox(
                  width: 15,
                ),
                const Loading(
                  height: 20,
                  width: 90,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Loading(
                height: 20,
                width: 100,
              ),
              const Loading(
                height: 20,
                width: 100,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Loading(
            height: 20,
            width: double.infinity,
          ),
          const SizedBox(
            height: 10,
          ),
          const Loading(
            height: 20,
            width: double.infinity,
          ),
          const SizedBox(
            height: 10,
          ),
          const Loading(
            height: 20,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Widget listBuildEmptyItem() {
    return Container(
      child: CupertinoScrollbar(
        child: ListView.builder(
          itemBuilder: (context, index) => buildEmptyDesign(),
          itemCount: cubit.articles.length,
          controller: _scrollController,
        ),
      ),
    );
  }

  Widget buildTaskItem(articles) {
    if (articles == null) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: () {
        launcherURL(articles['url']);
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                articles['urlToImage'] != null
                    ? Image.network(articles['urlToImage'])
                    : const Loading(
                  height: 200,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                        ),
                        child: Text(
                          articles['name'] ?? "Fox Sports ",
                          style: GoogleFonts.redHatDisplay(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Text(
                            articles['name'] ?? "Fox Sports ",
                            style: GoogleFonts.redHatDisplay(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      DateFormat('MMMM d, y')
                          .format(DateTime.parse(articles['publishedAt'])),
                      style: GoogleFonts.redHatDisplay(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(
                      Icons.access_time_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      DateFormat('h:mm a')
                          .format(DateTime.parse(articles['publishedAt'])),
                      style: GoogleFonts.redHatDisplay(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  articles['title'] ?? "",
                  style: GoogleFonts.redHatDisplay(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Divider(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

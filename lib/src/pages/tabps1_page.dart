import 'package:flutter/material.dart';
import 'package:flutter_application_1_news/src/services/new_service.dart';
import 'package:flutter_application_1_news/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({super.key});

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newsService = Provider.of<NewsService>(context);
    return Scaffold(
      //ListaNoticias(noticias: newsService.headLines),
      body: (newsService.headlines.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : ListaNoticias(noticias: newsService.headlines),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

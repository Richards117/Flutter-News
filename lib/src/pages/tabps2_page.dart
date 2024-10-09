import 'package:flutter/material.dart';
import 'package:flutter_application_1_news/src/models/category_model.dart';
import 'package:flutter_application_1_news/src/services/new_service.dart';
import 'package:flutter_application_1_news/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatefulWidget {
  const Tab2Page({super.key});

  @override
  State<Tab2Page> createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
          _ListaCategorias(),
          Expanded(
              child: ListaNoticias(
                  noticias: newsService.getArticulosCategoriaSeleccionada))
        ],
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return Container(
      width: double.infinity,
      height: 100,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final cName = categories[index].name;
          return Container(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  _CategoryButton(categories[index]),
                  const SizedBox(height: 5),
                  Text('${cName[0].toUpperCase()}${cName.substring(1)}')
                ])),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Categorys categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(categoria.icon,
            color: (newsService.selectedCategory == categoria.name)
                ? const Color.fromARGB(255, 231, 25, 10)
                : Colors.black54),
      ),
    );
  }
}

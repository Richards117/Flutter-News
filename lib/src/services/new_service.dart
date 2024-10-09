import 'package:flutter/foundation.dart';
import 'package:flutter_application_1_news/src/models/category_model.dart';
import 'package:flutter_application_1_news/src/models/news_models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

const _apykey = '5b9d0f9ed9e54d38b9c17154b8dced1a';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  bool _isLoading = true;

  List<Categorys> categories = [
    Categorys(FontAwesomeIcons.building, 'business'),
    Categorys(FontAwesomeIcons.tv, 'entertainment'),
    Categorys(FontAwesomeIcons.addressCard, 'general'),
    Categorys(FontAwesomeIcons.headSideVirus, 'health'),
    Categorys(FontAwesomeIcons.volleyball, 'sports'),
    Categorys(FontAwesomeIcons.vials, 'science'),
    Categorys(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();
    for (var item in categories) {
      categoryArticles[item.name] = List.empty(growable: true);
    }
    getArticlesByCategoy(_selectedCategory);
  }

  bool get isLoading => _isLoading;

  String get selectedCategory => _selectedCategory;
  set selectedCategory(dynamic valor) {
    _selectedCategory = valor;
    _isLoading = true;
    getArticlesByCategoy(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada =>
      categoryArticles[selectedCategory]!;

  getTopHeadlines() async {
    var uri = Uri.https('newsapi.org', '/v2/top-headlines',
        {'country': 'us', 'apiKey': _apykey});
    final resp = await http.get(uri);

    final newsResponse = newsResponseFromJson(resp.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategoy(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }
    var uri = Uri.https(
      'newsapi.org',
      '/v2/top-headlines',
      {
        'country': 'us',
        'apiKey': _apykey,
        'category': _selectedCategory,
      },
    );
    final resp = await http.get(uri);

    final newsResponse = newsResponseFromJson(resp.body);
    categoryArticles[category]!.addAll(newsResponse.articles);

    notifyListeners();
  }
}

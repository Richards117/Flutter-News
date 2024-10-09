import 'package:flutter/material.dart';
import 'package:flutter_application_1_news/src/models/news_models.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;

  const ListaNoticias({super.key, required this.noticias});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia(noticia: noticias[index], index: index);
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

  const _Noticia({required this.noticia, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TarjetaTopBar(noticia, index),
        _TarjetaTitulo(noticia),
        _TarjetaImagen(noticia),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final int index;

  const _TarjetaTopBar(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Text(
            '${index + 1}. ',
            style: const TextStyle(color: Colors.red),
          ),
          Text(
            '${noticia.source.name}.',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 19, 179, 201),
            ),
          ),
        ],
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        noticia.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;

  const _TarjetaImagen(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (noticia.urlToImage != null && noticia.urlToImage!.isNotEmpty)
          ? FadeInImage(
              imageErrorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.white,
                  width: 300,
                  height: 250,
                  child: const Image(
                    image: AssetImage('assets/no-image.png'),
                  ),
                );
              },
              placeholder: const AssetImage('assets/giphy.gif'),
              image: NetworkImage(noticia.urlToImage!),
            )
          : const Image(image: AssetImage('assets/no-image.png')),
    );
  }
}

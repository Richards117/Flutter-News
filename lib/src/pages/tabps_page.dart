import 'package:flutter/material.dart';
import 'package:flutter_application_1_news/src/pages/screens.dart';
import 'package:provider/provider.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: const Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navagtion(),
      ),
    );
  }
}

class _Navagtion extends StatelessWidget {
  const _Navagtion();

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return Container(
      decoration: const BoxDecoration(
        border: BorderDirectional(
          top: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      child: BottomNavigationBar(
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        onTap: (i) => navegacionModel.paginaActual = i,
        elevation: 2,
        currentIndex: navegacionModel.paginaActual,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person_pin),
            label: 'Para ti',
            backgroundColor: Color.fromRGBO(8, 140, 163, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public_outlined),
            activeIcon: Icon(Icons.public_rounded),
            label: 'Encabezado',
            backgroundColor: Color.fromRGBO(26, 150, 156, 1),
          ),
        ],
      ),
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages();

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const <Widget>[
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  final PageController _pageController = PageController();

  int get paginaActual => _paginaActual;

  set paginaActual(int valor) {
    _paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);

    notifyListeners();
  }

  PageController get pageController => _pageController;
}

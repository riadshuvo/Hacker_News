import 'package:flutter/material.dart';
import 'package:hacker_news/screens/news_details.dart';
import 'package:hacker_news/screens/topnews_ui.dart';
import 'package:provider/provider.dart';

import 'blocs/hacker_news_bloc.dart';


void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacker News',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routes,
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
         return Provider<HackerNewsBloc>(
            create: (context) => HackerNewsBloc(),
            child: TopNewsUi(),
          );

        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final itemId = int.parse(settings.name.replaceFirst('/', ''));

          return NewsDetails(itemId: itemId);
        },
      );
    }
  }

}




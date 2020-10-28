import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/blocs/news_detail_bloc.dart';
import 'package:hacker_news/repositories/news_repository.dart';
import 'package:hacker_news/screens/webView.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetails extends StatelessWidget {
  final int itemId;

  NewsDetails({this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: BlocProvider<NewsDetailsBloc>(
          create: (BuildContext context) => NewsDetailsBloc(HackerNewsRepo())
            ..add(GetNewsDetialsEvent(id: itemId)),
          child: BlocBuilder<NewsDetailsBloc, NewsDetialsState>(
            builder: (context, state) {
              if (state is NewsDetialsIsLoaded) {
                var item = state.newsModel;
                return Padding(
                    padding: EdgeInsets.all(5),
                    child: Card(
                        child: ExpansionTile(
                            title: Text(
                      item.title,
                      style: TextStyle(fontSize: 24),
                    ),
                        subtitle: Text('Author: ${item.author.toUpperCase()}',
                        style: TextStyle(fontSize: 15),),
                          trailing: Text('${readTimestamp(item.time)}'),

                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${item.kids.length} comments'),
                                Text('${item.score} ponts'),
                                MaterialButton(
                                  child: Icon(Icons.launch, color: Colors.green,),
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => NewsWebView(url: item.url,)),
                                    );
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                        )));
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  String readTimestamp(int timestamp) {
    var format = DateFormat(' hh:mm:ss a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var time = '';

    time = format.format(date);

    return time;
  }
}

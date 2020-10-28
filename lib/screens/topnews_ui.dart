import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/blocs/hacker_news_bloc.dart';
import 'dart:async';

import 'package:hacker_news/model_class/news_model.dart';
import 'package:provider/provider.dart';

class TopNewsUi extends StatefulWidget {
  @override
  _TopNewsUiState createState() => _TopNewsUiState();
}

class _TopNewsUiState extends State<TopNewsUi> {
  HackerNewsBloc _bloc;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreTopNewsIfNeed);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<HackerNewsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hacker News')),
      body: StreamBuilder(
        stream: _bloc.topNewses,
        builder: (BuildContext context, AsyncSnapshot<List<NewsModel>> snapshot) {
          if (snapshot.hasData) return _buildTopNews(topNews: snapshot.data);
          if (snapshot.hasError) return Center(child: Text('${snapshot.error}'));
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildTopNews({List<NewsModel> topNews}) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _bloc.hasMoreStories() ? topNews.length + 1 : topNews.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == topNews.length) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return _buildNewsCardView(topNews: topNews[index]);
      },
    );
  }

  Widget _buildNewsCardView({NewsModel topNews}) {
    return Card(
      child: ListTile(
        title: Text(topNews.title, style: TextStyle(color: Colors.black, fontSize: 18),),
        onTap: (){
          Navigator.pushNamed(context, '/${topNews.id}');
        },
      ),
    );
  }

  void _loadMoreTopNewsIfNeed() {
    final offsetToEnd = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;
    final threshold = MediaQuery.of(context).size.height / 3;
    final shouldLoadMore = offsetToEnd < threshold;
    if (shouldLoadMore) {
      _bloc.loadMoreTopNewses();
    }
  }
}

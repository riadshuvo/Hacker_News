import 'dart:async';
import 'dart:math';

import 'package:hacker_news/model_class/news_model.dart';
import 'package:hacker_news/repositories/news_repository.dart';


class HackerNewsBloc{
  static const int INIT_PAGE_SIZE = 25;
  static const int PAGE_SIZE = 3;

  final _topNewsIds = List<int>();
  final _topNewses = List<NewsModel>();
  final _repository = HackerNewsRepo();

  var _isLoading = false;
  var _currentIndex = 0;

  StreamController<List<NewsModel>> _topNewsStreamController = StreamController();

  Stream<List<NewsModel>> get topNewses => _topNewsStreamController.stream;

  HackerNewsBloc() {
    _loadInitTopNewses();
  }

  void _loadInitTopNewses() async {
    try {
      _topNewsIds.addAll(await _repository.loadTopNewsId());
    } catch (e) {
      _topNewsStreamController.sink.addError('Unknown Error');
      return;
    }

    loadMoreTopNewses(pageSize: INIT_PAGE_SIZE);
  }

  void loadMoreTopNewses({int pageSize = PAGE_SIZE}) async {
    if (_isLoading) return;

    _isLoading = true;
    final newsSize = min(_currentIndex + pageSize, _topNewsIds.length);
    for (int index = _currentIndex; index < newsSize; index++) {
      try {
        _topNewses.add(await _repository.loadNews(_topNewsIds[index]));
      } catch (e) {
        print('Failed to load news ids');
      }
    }
    _currentIndex = _topNewses.length;
    _topNewsStreamController.sink.add(_topNewses);
    _isLoading = false;
  }

  bool hasMoreStories() => _currentIndex < _topNewsIds.length;

  @override
  void dispose() {
    _topNewsStreamController.close();
  }

}
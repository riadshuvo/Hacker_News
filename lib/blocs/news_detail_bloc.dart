import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_news/model_class/news_model.dart';
import 'package:hacker_news/repositories/news_repository.dart';


class NewsDetialsEvent{}
class GetNewsDetialsEvent extends NewsDetialsEvent{
  final id;
  GetNewsDetialsEvent({this.id});
}

class NewsDetialsState{}
class NewsDetialsInitailState extends NewsDetialsState {}
class NewsDetialsLoadingState extends NewsDetialsState {}

class NewsDetialsIsLoaded extends NewsDetialsState {
  NewsModel newsModel;
  NewsDetialsIsLoaded({this.newsModel});
}
class NewsDetialsErrorState extends NewsDetialsState {
  final error;
  NewsDetialsErrorState({this.error});
}

class NewsDetailsBloc extends Bloc<NewsDetialsEvent,NewsDetialsState>{

  HackerNewsRepo repo;
  NewsDetailsBloc(this.repo) : super(null);

  @override
  NewsDetialsState get initialState => NewsDetialsInitailState();
  
  @override
  Stream<NewsDetialsState> mapEventToState(NewsDetialsEvent event) async*{
    if(event is GetNewsDetialsEvent){
      yield NewsDetialsLoadingState();
      try{
        NewsModel newsModel = await repo.loadNews(event.id);
        yield NewsDetialsIsLoaded(newsModel: newsModel);
      }catch(e){
        yield NewsDetialsErrorState(error: e.toString());
      }
    }
  }
  
}
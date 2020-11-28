import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacker_news/model_class/news_model.dart';
import 'package:hacker_news/util/repo_url.dart';
import 'package:http/http.dart' as http;

import '../main.dart';


class HackerNewsRepo{
  final _httpClient = http.Client();

  Future<List<int>> loadTopNewsId() async {
    final response = await _httpClient.get('${Config.baseUrl}/topstories.json');

    if(response.statusCode == 200){
      try{
        print("loadTopNewsIds: ${json.decode(response.body)}");
        List<int> dataList = List<int>.from(json.decode(response.body));

        if(dataList.length > 30){
          showMyDialog();
        }

        return dataList;
      }catch(e){
        print(e.toString());
      }
    }

    else throw http.ClientException('Failed to load top news id');
  }

  Future<NewsModel> loadNews(int id) async {
    final response = await _httpClient.get('${Config.baseUrl}/item/$id.json');

    if(response.statusCode == 200){
      try{
        print('news: ${json.decode(response.body)}');
        return NewsModel.fromJson(json.decode(response.body));
      }catch(e){
        print(e.toString());
      }
    }

    else throw http.ClientException('Failed to load story with id $id');
  }

  void showMyDialog() {
    showDialog(
        context: navigatorKey.currentContext,
        builder: (context) => LoginThirdpartDialog()
    );
  }

}
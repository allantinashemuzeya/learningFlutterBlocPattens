import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/news_info.dart';

enum NewsAction{
  Fetch,
  Delete
}
class NewsBloc {

  final _stateStreamController = StreamController<List<Article>>.broadcast();

  StreamSink<List<Article>> get _newsSink => _stateStreamController.sink; // input
  Stream<List<Article>> get newsStream => _stateStreamController.stream; // output

  final _eventStreamController = StreamController<NewsAction>.broadcast();
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get _eventStream => _eventStreamController.stream;

  NewsBloc(){
    _eventStream.listen(
        (event) async{
          if(event == NewsAction.Fetch){
              try {
                var news = await getNews();
                if(news != null)
                  _newsSink.add(news.articles);
                else _newsSink.addError('Something Went Wrong');

              } on Exception catch (e) {
                // TODO
                _newsSink.addError('Something Went Wrong');
              }
          }
        }
    );
  }

  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;


      var response = await client.get('https://newsapi.org/v2/everything?domains=wsj.com&apiKey=ea48a0670b894751b7dc1e0b894e259e');
      print(response);
      if(response.statusCode == 200){
        var jsonString = response.body;
        print(jsonString);
        var jsonMap = jsonDecode(jsonString);
        newsModel = NewsModel.fromJson(jsonMap);


      }
      return newsModel;
    }

    void dispose(){
      _stateStreamController.close();
      _eventStreamController.close();
    }

  }

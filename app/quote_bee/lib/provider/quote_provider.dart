import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:quote_bee/db_helper/db_helper.dart';
import '../model/quote_model.dart';

class QuoteProvider extends ChangeNotifier {
  List<QuoteModel> quoteItems = [];

  // call and implement sql select function
  Future<void> selectData() async {
    final dataList = await DBHelper.selectAll();

    quoteItems = dataList
        .map((item) => QuoteModel(
            index: item['index'],
            date: item['Date'],
            tweet: item['Tweet'],
            url: item['URL'],
            likeCount: item['Like Count'],
            retweetCount: item['Retweet Count'],
            favourite: item['Favourite']))
        .toList();

    notifyListeners();
  }

  Future insertData(int id) async {
    // toggle the favourite status
    // DBHelper.insertFav('favourites', {'id': id});
    // update favourite column where id is id
    // "UPDATE quotes SET "
    notifyListeners();
  }
}

class QuoteModel {
  final int index;
  String date;
  String tweet;
  String url;
  int likeCount;
  int retweetCount;
  int favourite;

  QuoteModel({
    required this.index,
    required this.date,
    required this.tweet,
    required this.url,
    required this.favourite,
    required this.likeCount,
    required this.retweetCount,
  });
}

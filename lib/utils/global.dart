import 'package:intl/intl.dart';

String name = 'bbc-news';
String categoryName = 'General';
final dateFormat = DateFormat('MMMM dd, yyyy');

//enum for news channel list
enum FilterList { bbcNews, abcnews, axios }

//category list

List<String> categories = [
  'General',
  'Entertainment',
  'Technology',
  'Business',
  'Sports'
];

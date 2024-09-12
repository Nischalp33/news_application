class CategoryModel {
  CategoryModel({
    String? status,
    num? totalResults,
    List<Articles>? articles,
  }) {
    _status = status;
    _totalResults = totalResults;
    _articles = articles;
  }

  CategoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _totalResults = json['totalResults'];
    if (json['articles'] != null) {
      _articles = [];
      json['articles'].forEach((v) {
        _articles?.add(Articles.fromJson(v));
      });
    }
  }
  String? _status;
  num? _totalResults;
  List<Articles>? _articles;
  CategoryModel copyWith({
    String? status,
    num? totalResults,
    List<Articles>? articles,
  }) =>
      CategoryModel(
        status: status ?? _status,
        totalResults: totalResults ?? _totalResults,
        articles: articles ?? _articles,
      );
  String? get status => _status;
  num? get totalResults => _totalResults;
  List<Articles>? get articles => _articles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['totalResults'] = _totalResults;
    if (_articles != null) {
      map['articles'] = _articles?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// source : {"id":"engadget","name":"Engadget"}
/// author : "Mat Smith"
/// title : "The Morning After: 50 attorneys general urge Congress to fight AI-generated child sexual abuse images"
/// description : "“We are engaged in a race against time to protect the children of our country from the dangers of AI,” the attorneys general wrote in an open letter to Congress, asking for increased protective measures against AI-enhanced child sexual abuse images.Using imag…"
/// url : "https://www.engadget.com/the-morning-after-50-attorneys-general-urge-congress-to-fight-ai-generated-child-sexual-abuse-images-111525174.html"
/// urlToImage : "https://s.yimg.com/ny/api/res/1.2/Fabzk_4_vQyNHbFNhx6CLA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD03Mzk-/https://s.yimg.com/os/creatr-uploaded-images/2023-09/da076610-4c1b-11ee-9fdf-505be02ea5fa"
/// publishedAt : "2023-09-06T11:15:25Z"
/// content : "We are engaged in a race against time to protect the children of our country from the dangers of AI, the attorneys general wrote in an open letter to Congress, asking for increased protective measure… [+3272 chars]"

class Articles {
  Articles({
    Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) {
    _source = source;
    _author = author;
    _title = title;
    _description = description;
    _url = url;
    _urlToImage = urlToImage;
    _publishedAt = publishedAt;
    _content = content;
  }

  Articles.fromJson(dynamic json) {
    _source = json['source'] != null ? Source.fromJson(json['source']) : null;
    _author = json['author'];
    _title = json['title'];
    _description = json['description'];
    _url = json['url'];
    _urlToImage = json['urlToImage'];
    _publishedAt = json['publishedAt'];
    _content = json['content'];
  }
  Source? _source;
  String? _author;
  String? _title;
  String? _description;
  String? _url;
  String? _urlToImage;
  String? _publishedAt;
  String? _content;
  Articles copyWith({
    Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) =>
      Articles(
        source: source ?? _source,
        author: author ?? _author,
        title: title ?? _title,
        description: description ?? _description,
        url: url ?? _url,
        urlToImage: urlToImage ?? _urlToImage,
        publishedAt: publishedAt ?? _publishedAt,
        content: content ?? _content,
      );
  Source? get source => _source;
  String? get author => _author;
  String? get title => _title;
  String? get description => _description;
  String? get url => _url;
  String? get urlToImage => _urlToImage;
  String? get publishedAt => _publishedAt;
  String? get content => _content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_source != null) {
      map['source'] = _source?.toJson();
    }
    map['author'] = _author;
    map['title'] = _title;
    map['description'] = _description;
    map['url'] = _url;
    map['urlToImage'] = _urlToImage;
    map['publishedAt'] = _publishedAt;
    map['content'] = _content;
    return map;
  }
}

/// id : "engadget"
/// name : "Engadget"

class Source {
  Source({
    String? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Source.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
  Source copyWith({
    String? id,
    String? name,
  }) =>
      Source(
        id: id ?? _id,
        name: name ?? _name,
      );
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

class cartmodels {
  List<Data>? _data;

  cartmodels({List<Data>? data}) {
    if (data != null) {
      this._data = data;
    }
  }

  List<Data>? get data => _data;
  set data(List<Data>? data) => _data = data;

  cartmodels.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? _author;
  String? _title;
  String? _price;

  Data({int? author, String? title, String? price}) {
    if (author != null) {
      this._author = author;
    }
    if (title != null) {
      this._title = title;
    }
    if (price != null) {
      this._price = price;
    }
  }

  int? get author => _author;
  set author(int? author) => _author = author;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get price => _price;
  set price(String? price) => _price = price;

  Data.fromJson(Map<String, dynamic> json) {
    _author = json['author'];
    _title = json['title'];
    _price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this._author;
    data['title'] = this._title;
    data['price'] = this._price;
    return data;
  }
}
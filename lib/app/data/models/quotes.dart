class Quotes {
  int? id;
  String? quote;
  String? author;

  Quotes({this.id, this.quote, this.author});

  factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
        id: json['id'] as int?,
        quote: json['quote'] as String?,
        author: json['author'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'quote': quote,
        'author': author,
      };
}

class Rating {
  num rate;
  int count;

  Rating({required this.rate, required this.count});

  Map<String, dynamic> toJson() => {'rate': rate, 'count': count};

  factory Rating.fromJson(Map<String, dynamic> json) =>
      Rating(rate: json['rate'], count: json['count']);
}

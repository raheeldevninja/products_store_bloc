class Rating {
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  // Factory constructor for creating a Rating instance from JSON
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'].toDouble(),
      count: json['count'],
    );
  }

  // Method to convert a Rating instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}

class DataModel {
  final String bannerTitle;
  final List<String> bannerImages;
  final double rating;
  final String description;
  final List<String> details;
  final List<Map<String, dynamic>> popularTreks;

  DataModel({
    required this.bannerTitle,
    required this.bannerImages,
    required this.rating,
    required this.description,
    required this.details,
    required this.popularTreks,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      bannerTitle: json['bannerTitle'],
      bannerImages: List<String>.from(json['bannerImages']),
      rating: json['rating'].toDouble(),
      description: json['description'],
      details: List<String>.from(json['details']),
      popularTreks: List<Map<String, dynamic>>.from(json['popularTreks']),
    );
  }
}

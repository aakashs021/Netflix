class Movies {
  String title;
  String backdroppath;
  String overview;
  String originallanguage;
  String originaltitle;
  String releasedate;
  String posterpath;
  double voteaverage;
  int id;

  Movies({
    required this.title,
    required this.backdroppath,
    required this.originallanguage,
    required this.originaltitle,
    required this.overview,
    required this.posterpath,
    required this.releasedate,
    required this.id,
    required this.voteaverage,
  });

  factory Movies.fromJson({required Map<String, dynamic> json}) {
    return Movies(
      title: json['title'] ?? 'No title available',
      backdroppath: json['backdrop_path'] ?? '',
      originallanguage: json['original_language'] ?? 'N/A',
      originaltitle: json['original_title'] ?? 'No original title available',
      overview: json['overview'] ?? 'No overview available',
      posterpath: json['poster_path'] ?? '',
      releasedate: json['release_date'] ?? 'Unknown',
      id: json['id'] ?? 0,
      voteaverage: (json['vote_average'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'backdrop_path': backdroppath,
      'original_language': originallanguage,
      'original_title': originaltitle,
      'overview': overview,
      'poster_path': posterpath,
      'release_date': releasedate,
      'id': id,
      'vote_average': voteaverage,
    };
  }
}

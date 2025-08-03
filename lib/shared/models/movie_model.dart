import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  @JsonKey(name: '_id')
  final String id;
  
  @JsonKey(name: 'Title')
  final String title;
  
  @JsonKey(name: 'Plot')
  final String description;
  
  @JsonKey(name: 'Poster')
  final String posterPath;
  
  @JsonKey(name: 'Images')
  final List<String> images;
  
  @JsonKey(name: 'imdbRating')
  final String rating;
  
  @JsonKey(name: 'Year')
  final String releaseYear;
  
  @JsonKey(name: 'Genre')
  final String genres;
  
  @JsonKey(name: 'Runtime')
  final String runtime;
  
  @JsonKey(name: 'Director')
  final String director;
  
  @JsonKey(name: 'Actors')
  final String actors;
  
  @JsonKey(name: 'Rated')
  final String rated;
  
  @JsonKey(name: 'Released')
  final String released;
  
  @JsonKey(name: 'Writer')
  final String writer;
  
  @JsonKey(name: 'Language')
  final String language;
  
  @JsonKey(name: 'Country')
  final String country;
  
  @JsonKey(name: 'Awards')
  final String awards;
  
  @JsonKey(name: 'Metascore')
  final String metascore;
  
  @JsonKey(name: 'imdbVotes')
  final String imdbVotes;
  
  @JsonKey(name: 'imdbID')
  final String imdbId;
  
  @JsonKey(name: 'Type')
  final String type;
  
  @JsonKey(name: 'Response')
  final String response;
  
  @JsonKey(name: 'ComingSoon')
  final bool comingSoon;
  
  @JsonKey(name: 'isFavorite')
  final bool isFavorite;

  const MovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.posterPath,
    required this.images,
    required this.rating,
    required this.releaseYear,
    required this.genres,
    required this.runtime,
    required this.director,
    required this.actors,
    required this.rated,
    required this.released,
    required this.writer,
    required this.language,
    required this.country,
    required this.awards,
    required this.metascore,
    required this.imdbVotes,
    required this.imdbId,
    required this.type,
    required this.response,
    required this.comingSoon,
    this.isFavorite = false,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  MovieModel copyWith({
    String? id,
    String? title,
    String? description,
    String? posterPath,
    List<String>? images,
    String? rating,
    String? releaseYear,
    String? genres,
    String? runtime,
    String? director,
    String? actors,
    String? rated,
    String? released,
    String? writer,
    String? language,
    String? country,
    String? awards,
    String? metascore,
    String? imdbVotes,
    String? imdbId,
    String? type,
    String? response,
    bool? comingSoon,
    bool? isFavorite,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      posterPath: posterPath ?? this.posterPath,
      images: images ?? this.images,
      rating: rating ?? this.rating,
      releaseYear: releaseYear ?? this.releaseYear,
      genres: genres ?? this.genres,
      runtime: runtime ?? this.runtime,
      director: director ?? this.director,
      actors: actors ?? this.actors,
      rated: rated ?? this.rated,
      released: released ?? this.released,
      writer: writer ?? this.writer,
      language: language ?? this.language,
      country: country ?? this.country,
      awards: awards ?? this.awards,
      metascore: metascore ?? this.metascore,
      imdbVotes: imdbVotes ?? this.imdbVotes,
      imdbId: imdbId ?? this.imdbId,
      type: type ?? this.type,
      response: response ?? this.response,
      comingSoon: comingSoon ?? this.comingSoon,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  String get formattedDuration {
    final runtimeMatch = RegExp(r'(\d+)\s*min').firstMatch(runtime);
    if (runtimeMatch != null) {
      final totalMinutes = int.parse(runtimeMatch.group(1)!);
      final hours = totalMinutes ~/ 60;
      final minutes = totalMinutes % 60;
      if (hours > 0) {
        return '${hours}s ${minutes}dk';
      }
      return '${minutes}dk';
    }
    return runtime;
  }

  String get formattedRating {
    return rating;
  }

  List<String> get genreList {
    return genres.split(', ').map((genre) => genre.trim()).toList();
  }

  String get backdropPath {
    return images.isNotEmpty ? images.first : posterPath;
  }

  double get ratingAsDouble {
    return double.tryParse(rating) ?? 0.0;
  }

  int get releaseYearAsInt {
    return int.tryParse(releaseYear) ?? 0;
  }

  @override
  String toString() {
    return 'MovieModel(id: $id, title: $title, rating: $rating, releaseYear: $releaseYear, isFavorite: $isFavorite)';
  }
} 
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  id: json['_id'] as String,
  title: json['Title'] as String,
  description: json['Plot'] as String,
  posterPath: json['Poster'] as String,
  images: (json['Images'] as List<dynamic>).map((e) => e as String).toList(),
  rating: json['imdbRating'] as String,
  releaseYear: json['Year'] as String,
  genres: json['Genre'] as String,
  runtime: json['Runtime'] as String,
  director: json['Director'] as String,
  actors: json['Actors'] as String,
  rated: json['Rated'] as String,
  released: json['Released'] as String,
  writer: json['Writer'] as String,
  language: json['Language'] as String,
  country: json['Country'] as String,
  awards: json['Awards'] as String,
  metascore: json['Metascore'] as String,
  imdbVotes: json['imdbVotes'] as String,
  imdbId: json['imdbID'] as String,
  type: json['Type'] as String,
  response: json['Response'] as String,
  comingSoon: json['ComingSoon'] as bool,
  isFavorite: json['isFavorite'] as bool? ?? false,
);

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'Title': instance.title,
      'Plot': instance.description,
      'Poster': instance.posterPath,
      'Images': instance.images,
      'imdbRating': instance.rating,
      'Year': instance.releaseYear,
      'Genre': instance.genres,
      'Runtime': instance.runtime,
      'Director': instance.director,
      'Actors': instance.actors,
      'Rated': instance.rated,
      'Released': instance.released,
      'Writer': instance.writer,
      'Language': instance.language,
      'Country': instance.country,
      'Awards': instance.awards,
      'Metascore': instance.metascore,
      'imdbVotes': instance.imdbVotes,
      'imdbID': instance.imdbId,
      'Type': instance.type,
      'Response': instance.response,
      'ComingSoon': instance.comingSoon,
      'isFavorite': instance.isFavorite,
    };

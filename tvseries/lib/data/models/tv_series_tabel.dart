import 'package:equatable/equatable.dart';
import 'package:tvseries/tvseries.dart';

class TvTable extends Equatable {
  
  const TvTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  factory TvTable.fromEntity(TvSeriesDetail tv) => TvTable(
        id: tv.id,
        name: tv.name,
        posterPath: tv.posterPath,
        overview: tv.overview,
      );

  factory TvTable.fromMap(Map<String, dynamic> map) => TvTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  TvSeries toEntity() => TvSeries.watchlist(
      id: id, overview: overview, posterPath: posterPath, name: name);

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}

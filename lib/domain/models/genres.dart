import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  const Genre({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  @override
  List<Object?> get props => [id];
}

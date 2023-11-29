import 'package:equatable/equatable.dart';

class SpokenLanguages extends Equatable {
  const SpokenLanguages(
    this.iso6391,
    this.name,
  );

  final String? iso6391;
  final String? name;

  @override
  List<Object?> get props => [iso6391, name];
}

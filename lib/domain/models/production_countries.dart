import 'package:equatable/equatable.dart';

class ProductionCountries extends Equatable {
  const ProductionCountries(
    this.iso31661,
    this.name,
  );

  final String? iso31661;
  final String? name;

  @override
  List<Object?> get props => [iso31661, name];
}

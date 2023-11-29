import 'package:equatable/equatable.dart';

class ProductionCompanies extends Equatable {
  const ProductionCompanies(
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  );

  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  @override
  List<Object?> get props => [id];
}

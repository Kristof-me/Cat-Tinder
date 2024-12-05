import 'package:equatable/equatable.dart';

class CatInformation extends Equatable {
  const CatInformation({required this.id, required this.imageUrl, this.tags = const []});

  final String id;
  final String imageUrl;
  final List<String> tags;

  @override
  List<Object?> get props => [id, imageUrl, tags];
}

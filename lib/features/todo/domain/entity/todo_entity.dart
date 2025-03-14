import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  const TodoEntity({
    required this.id,
    required this.title,
    required this.createdAt,
    this.description,
    this.imageUrl,
  });

  final int id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final String? imageUrl;

  @override
  List<Object?> get props => [id, title, description, createdAt, imageUrl];
}

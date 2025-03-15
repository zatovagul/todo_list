import 'package:equatable/equatable.dart';

enum OrderingModeEntity { asc, desc }

class TodoFilterEntity extends Equatable {
  const TodoFilterEntity({this.title, this.date});

  final OrderingModeEntity? title;
  final OrderingModeEntity? date;

  @override
  List<Object?> get props => [title, date];
}

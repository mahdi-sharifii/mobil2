import 'package:equatable/equatable.dart';

import 'package:hive/hive.dart';

part 'name_model.g.dart';

@HiveType(typeId: 2)
class NameModel extends Equatable {
  NameModel({
    this.id,
    this.name,
    this.color,
    this.dateTime,
  });

  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  DateTime? dateTime;

  @HiveField(3)
  num? color;

  @override
  List<Object?> get props => [id, name, color];
}

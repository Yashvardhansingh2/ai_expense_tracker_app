import 'package:hive/hive.dart';

part 'budget_model.g.dart';

@HiveType(typeId: 1)
class Budget extends HiveObject {
  @HiveField(0)
  String category;

  @HiveField(1)
  double limit;

  Budget({required this.category, required this.limit});
}

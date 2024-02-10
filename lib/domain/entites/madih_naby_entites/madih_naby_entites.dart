import 'package:equatable/equatable.dart';

class MadihNabyEntites extends Equatable {
  final int number;
  final String name;
  final String textMadih;
  const MadihNabyEntites({
    required this.name,
    required this.number,
    required this.textMadih,
  });

  @override
  List<Object?> get props => [
        number,
        name,
        textMadih,
      ];
}

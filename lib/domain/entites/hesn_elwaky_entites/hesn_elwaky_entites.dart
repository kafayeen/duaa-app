import 'package:equatable/equatable.dart';

class HesnElWakyEntites extends Equatable {
  final String azkar;
  final String tariqa;
  final String fadlha;

  const HesnElWakyEntites(
      {required this.azkar, required this.tariqa, required this.fadlha});

  @override
  List<Object?> get props => [azkar, tariqa, fadlha];
}

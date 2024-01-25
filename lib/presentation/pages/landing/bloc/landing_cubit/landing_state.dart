part of 'landing_cubit.dart';

class LandingState {
  List<String>? category;

  LandingState({
    this.category,
  });

  LandingState copyWith({
    List<String>? category,
  }) {
    return LandingState(
      category: category ?? this.category,
    );
  }
}

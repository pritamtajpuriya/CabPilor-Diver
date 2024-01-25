part of 'profile_cubit.dart';

class ProfileState {
  final StateStatusEnum profileStatus;
  final String? errorMessage;
  final User? profileModel;

  ProfileState({
    this.profileStatus = StateStatusEnum.initial,
    this.errorMessage,
    this.profileModel,
  });

  ProfileState copyWith({
    StateStatusEnum? loadingStatus,
    String? errorMessage,
    User? profileModel,
  }) {
    return ProfileState(
      profileStatus: loadingStatus ?? this.profileStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      profileModel: profileModel ?? this.profileModel,
    );
  }
}

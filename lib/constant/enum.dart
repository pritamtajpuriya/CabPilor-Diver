enum StateStatusEnum {
  initial,
  loading,
  success,
  error,
}

enum AuthStatus {
  unknown,
  loading,
  appFirstOnboarded,
  authenticated,
  profileNotSetup,
  unauthenticated,
  unverified,
  categoryNotSetup,
}

// login state
enum LoginState {
  register,
  login,
}

part of 'login_bloc.dart';

@freezed
sealed class LoginState extends BaseState with _$LoginState {
  const LoginState._();

  const factory LoginState.initial({
    required LoginStateStore store,
  }) = Initial;

  const factory LoginState.phoneNumberChange({
    required LoginStateStore store,
  }) = _PhoneNumberChange;

  const factory LoginState.otpSent({
    required LoginStateStore store,
  }) = OtpSent;

  const factory LoginState.changeLoaderState({
    required LoginStateStore store,
  }) = ChangeLoaderState;

  const factory LoginState.onFailure({
    required LoginStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState(
    Failure failure,
  ) =>
      LoginState.onFailure(
        store: store.copyWith(
          loading: false,
        ),
        failure: failure,
      );

  @override
  BaseState getLoaderState({
    required bool loading,
  }) =>
      LoginState.changeLoaderState(
        store: store.copyWith(
          loading: loading,
        ),
      );
}

@freezed
class LoginStateStore with _$LoginStateStore {
  const factory LoginStateStore({
    String? phoneNumber,
    String? verificationId,
    int? forceResendingToken,
    @Default(false) bool loading,
  }) = _LoginStateStore;
}

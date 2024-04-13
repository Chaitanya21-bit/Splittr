part of 'global_bloc.dart';

@freezed
class GlobalEvent extends BaseEvent with _$GlobalEvent {
  const factory GlobalEvent.started() = _Started;

  const factory GlobalEvent.userUpdated({
    required User user,
  }) = _UserUpdated;
}

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/base/base_bloc/base_bloc.dart';
import 'package:splittr/core/failure/failure.dart';

part 'profile_bloc.freezed.dart';

part 'profile_event.dart';

part 'profile_state.dart';

@injectable
final class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  ProfileBloc()
      : super(
          const ProfileState.initial(
            store: ProfileStateStore(),
          ),
        );

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
  }

  void _onStarted(_Started event, Emitter<ProfileState> emit) {}

  @override
  void started({
    Map<String, dynamic>? args,
  }) {
    add(const ProfileEvent.started());
  }

  @override
  bool get isLoading => state.store.loading;
}

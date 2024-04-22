import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../src.dart';

part 'username_state.dart';

class UsernameCubit extends Cubit<UsernameState> {
  UsernameCubit(UsernameRepository usernameRepository)
      : _usernameRepository = usernameRepository,
        super(const UsernameState()) {
    getUsername();
  }

  final UsernameRepository _usernameRepository;

  void getUsername() {
    emit(state.copyWith(status: UsernameStatus.loading));
    try {
      final String? username = _usernameRepository.getUsername();
      emit(state.copyWith(username: username, status: UsernameStatus.success));
    } catch (e) {
      emit(state.copyWith(status: UsernameStatus.failure));
    }
  }
}

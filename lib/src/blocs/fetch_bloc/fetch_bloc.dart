// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/user.dart';
import '../../repository/fetch_repo.dart';

part 'fetch_event.dart';
part 'fetch_state.dart';

class FetchBloc extends Bloc<FetchEvent, FetchState> {
  FetchBloc() : super(FetchInitial()) {
    final RepositoryFetchData repoFetch = RepositoryFetchData();
    on<FetchEvent>((event, emit) async {
      List<User> users = await repoFetch.FetchUsers();
      emit(FetchSuccess(users));
    });
  }
}

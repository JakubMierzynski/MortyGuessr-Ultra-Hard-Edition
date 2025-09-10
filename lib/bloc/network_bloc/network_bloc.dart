import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morty_guessr/bloc/network_bloc/network_event.dart';
import 'package:morty_guessr/bloc/network_bloc/network_state.dart';
import 'package:morty_guessr/services/check_internet_connection.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(const NetworkState(isOnline: false)) {
    on<CheckNetwork>((event, emit) async {
      final currentIsOnlineStatus = await hasInternet();

      emit(NetworkState(isOnline: currentIsOnlineStatus));
    });
  }
}

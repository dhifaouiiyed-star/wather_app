// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weatherapp/models/wather_model.dart';
import 'package:weatherapp/reposotory/wather_remote.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WatherRemote watherRemote;
  WeatherBloc(this.watherRemote) : super(WeatherInitial()) {
    on<WeatherFetched>(_loaddingWeather);
  }
  void _loaddingWeather(
    WeatherFetched event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      emit(WeatherLoadding());

      final WatherModel? watherModel = await watherRemote.fetchData();

      if (watherModel == null) {
        emit(WeatherError(error: "No data was Found"));
      }
      emit(WeatherSuccess(watherModel!));
    } catch (e) {
      emit(WeatherError(error: e.toString()));
    }
  }
}

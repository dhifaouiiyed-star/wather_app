part of 'weather_bloc.dart';

sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoadding extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final WatherModel watherModel;

  WeatherSuccess(this.watherModel);
}

final class WeatherError extends WeatherState {
  final String error;

  WeatherError({required this.error});
}

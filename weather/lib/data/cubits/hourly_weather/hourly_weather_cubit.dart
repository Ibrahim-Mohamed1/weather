import 'package:Weather/data/cubits/hourly_weather/hourly_weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Weather/data/common/remote_data_source.dart';

class HourlyWeatherCubit extends Cubit<HourlyWeatherState> {
  HourlyWeatherCubit() : super(HourlyWeatherState.initial());
  final WeatherApi weatherApi = WeatherApi();

  Future<void> fetchHourlyWeather() async {
    emit(HourlyWeatherState.loadingStarted());

    final response = await weatherApi.getHourlyWeatherData();

    emit(HourlyWeatherState.loadingSuccess(response));
  }
}

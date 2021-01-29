import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:weavee/models/day.dart';
import 'package:weavee/models/the_five_days.dart';

class Days {
  final String date;
  final String temp;
  final String city;
  final String imgUrl;
  final Day one;
  final String sunrise;
  final String sunset;
  final TheFiveDays fiveDays;
  // -------------------
  final String windSpeed;
  final String windDirection;
  final String pressure;
  final String maxTemp;
  final String minTemp;
  final String weatherName;
  final String completeDate;

  Days({
    this.completeDate,
    this.windSpeed,
    this.windDirection,
    this.pressure,
    this.maxTemp,
    this.minTemp,
    this.weatherName,
    this.fiveDays,
    this.city,
    this.temp,
    this.date,
    this.imgUrl,
    this.one,
    this.sunrise,
    this.sunset,
  });

  factory Days.fromJson(Map<String, dynamic> json) {
    weatherState(String abrv) {
      if (abrv == "sn") {
        return [
          LineAwesomeIcons.snowflake_1,
          'assets/images/weather_states/sn.png'
        ];
      } else if (abrv == "sl") {
        return [
          LineAwesomeIcons.cloud_with__a_chance_of__meatball,
          'assets/images/weather_states/sl.png'
        ];
      } else if (abrv == "h") {
        return [
          CommunityMaterialIcons.weather_windy_variant,
          'assets/images/weather_states/h.png'
        ];
      } else if (abrv == "t") {
        return [
          CommunityMaterialIcons.weather_lightning,
          'assets/images/weather_states/t.png'
        ];
      } else if (abrv == "hr") {
        return [
          LineAwesomeIcons.cloud_with_rain,
          'assets/images/weather_states/hr.png'
        ];
      } else if (abrv == "lr") {
        return [
          CommunityMaterialIcons.weather_pouring,
          'assets/images/weather_states/lr.png'
        ];
      } else if (abrv == "s") {
        return [
          LineAwesomeIcons.cloud_with_sun_and_rain,
          'assets/images/weather_states/s.png'
        ];
      } else if (abrv == "hc") {
        return [LineAwesomeIcons.cloud, 'assets/images/weather_states/hc.png'];
      } else if (abrv == "lc") {
        return [
          LineAwesomeIcons.cloud_with_sun,
          'assets/images/weather_states/lc.png'
        ];
      } else if (abrv == "c") {
        return [LineAwesomeIcons.sun, 'assets/images/weather_states/c.png'];
      }
    }

    var infos = json['consolidated_weather'];

// ---------------------- functions
    buildDate(int day, bool now) {
      var dmyString = infos[day]['applicable_date'].toString();
      DateTime dateTime1 = DateFormat('yyyy-M-d').parse(dmyString);
      String datz = now
          ? DateFormat('EEEE dd\nMMMM yyyy').format(dateTime1)
          : DateFormat('MMM dd').format(dateTime1);
      return datz;
    }

    buildTemp(int day) {
      return infos[day]['the_temp'].toStringAsFixed(0);
    }

    IconData buildIcon(int day) {
      List stateWeather = weatherState(infos[day]['weather_state_abbr']);
      return stateWeather[0];
    }

    buildImg(int day) {
      List stateWeather = weatherState(infos[day]['weather_state_abbr']);
      return stateWeather[1];
    }
// ---------------------- functions

    Day one = Day(date: 'Today', degree: buildTemp(0), icon: buildIcon(0));
    Day two = Day(
        date: buildDate(1, false), degree: buildTemp(1), icon: buildIcon(1));
    Day three = Day(
        date: buildDate(2, false), degree: buildTemp(2), icon: buildIcon(2));
    Day four = Day(
        date: buildDate(3, false), degree: buildTemp(3), icon: buildIcon(3));
    Day five = Day(
        date: buildDate(4, false), degree: buildTemp(4), icon: buildIcon(4));

    TheFiveDays theFiveDays =
        TheFiveDays(one: one, two: two, three: three, four: four, five: five);

    return Days(
      date: buildDate(0, false),
      completeDate: buildDate(0, true),
      temp: buildTemp(0),
      city: json['title'],
      imgUrl: buildImg(0),
      sunrise: json['sun_rise'].substring(11, 16),
      sunset: json['sun_set'].substring(11, 16),
      one: one,
      fiveDays: theFiveDays,
      // ---------------------
      pressure: infos[0]['air_pressure'].toStringAsFixed(0),
      minTemp: infos[0]['min_temp'].toStringAsFixed(0),
      maxTemp: infos[0]['max_temp'].toStringAsFixed(0),
      windSpeed: infos[0]['wind_speed'].toStringAsFixed(1),
      windDirection: infos[0]['wind_direction'].toStringAsFixed(0),
      weatherName: infos[0]['weather_state_name'],
    );
  }
}

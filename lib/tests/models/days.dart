import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:community_material_icon/community_material_icon.dart';

class Days {
  final String date;
  final String temp;
  final String city;
  final String imgUrl;
  final Day one;
  // final Day two;
  // final Day three;
  // final Day four;
  // final Day five;
  final String sunrise;
  final String sunset;
  final List<Day> days;

  Days({
    this.city,
    this.temp,
    this.date,
    this.imgUrl,
    this.one,
    this.days,
    // this.two,
    // this.three,
    // this.four,
    // this.five,
    this.sunrise,
    this.sunset,
  });

  factory Days.fromJson(Map<String, dynamic> json) {
    weatherState(String abrv) {
      if (abrv == "sn") {
        return [
          LineAwesomeIcons.snowflake_1,
          'assets/images/weather_states/cloudy.png'
        ];
      } else if (abrv == "sl") {
        return [
          LineAwesomeIcons.cloud_with__a_chance_of__meatball,
          'assets/images/weather_states/cloudy.png'
        ];
      } else if (abrv == "h") {
        return [
          CommunityMaterialIcons.weather_windy_variant,
          'assets/images/weather_states/cloudy.png'
        ];
      } else if (abrv == "t") {
        return [
          CommunityMaterialIcons.weather_lightning,
          'assets/images/weather_states/cloudy.png'
        ];
      } else if (abrv == "hr") {
        return [
          LineAwesomeIcons.cloud_with_rain,
          'assets/images/weather_states/cloudy.png'
        ];
      } else if (abrv == "lr") {
        return [
          CommunityMaterialIcons.weather_pouring,
          'assets/images/weather_states/cloudy.png'
        ];
      } else if (abrv == "s") {
        return [
          LineAwesomeIcons.cloud_with_sun_and_rain,
          'assets/images/weather_states/cloudy.png'
        ];
      } else if (abrv == "hc") {
        return [
          LineAwesomeIcons.cloud,
          'assets/images/weather_states/cloudy.png'
        ];
      } else if (abrv == "lc") {
        return [
          LineAwesomeIcons.cloud_with_sun,
          'assets/images/weather_states/cloudy.png'
        ];
      } else if (abrv == "c") {
        return [
          LineAwesomeIcons.sun,
          'assets/images/weather_states/cloudy.png'
        ];
      }
    }

    var infos = json['consolidated_weather'];

    String sunset = json['sun_set'].substring(11, 16);
    String sunrise = json['sun_rise'].substring(11, 16);

// ---------------------- functions
    buildDate(int day) {
      var dmyString = infos[day]['applicable_date'].toString();
      DateTime dateTime1 = DateFormat('yyyy-M-d').parse(dmyString);
      String datz = DateFormat('MMM d').format(dateTime1);
      return datz;
    }

    buildTemp(int day) {
      return infos[day]['the_temp'].toStringAsFixed(1);
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

    Day one = Day(date: buildDate(0), degree: buildTemp(0), icon: buildIcon(0));
    Day two = Day(date: buildDate(1), degree: buildTemp(1), icon: buildIcon(1));
    Day three =
        Day(date: buildDate(2), degree: buildTemp(2), icon: buildIcon(2));
    Day four =
        Day(date: buildDate(3), degree: buildTemp(3), icon: buildIcon(3));
    Day five =
        Day(date: buildDate(4), degree: buildTemp(4), icon: buildIcon(4));

    List<Day> list = [one, two, three, four, five];

    return Days(
      date: buildDate(0),
      temp: buildTemp(0),
      city: json['title'],
      imgUrl: buildImg(0),
      sunrise: sunrise,
      sunset: sunset,
      // Days
      one: one,
      days: list,
    );
  }
}

class Day {
  final String date;
  final String degree;
  final IconData icon;

  Day({this.date, this.degree, this.icon});
}

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weavee/models/day.dart';
import 'package:weavee/models/tab.dart';
import 'package:weavee/models/days.dart';
import 'package:weavee/models/the_five_days.dart';
import 'package:weavee/tests/home.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

// ---------------------- new API ---------------------- : start
String woeid;
Future<Days> fetchWoei(String city) async {
  final response = await http
      .get('https://www.metaweather.com/api/location/search/?query=$city');
  if (response != null) {
    var result = jsonDecode(response.body)[0];
    woeid = result['woeid'].toString();
    // print('Woeid : ' + woeid);
    // ----------------------- Data ----------------------
    final weatherData =
        await http.get('https://www.metaweather.com/api/location/$woeid');
    if (weatherData != null) {
      return Days.fromJson(jsonDecode(weatherData.body));
    } else {
      throw Exception('Faild to get Woeid');
    }
    // ----------------------- Data ----------------------
  } else {
    throw Exception('Faild to get Woeid');
  }
}
// ---------------------- new API ---------------------- : end

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

List<String> localData = [
  "Casablanca",
  "Kinshasa",
  "Alexandria",
  "Cairo",
  "Addis Ababa",
  "Abidjan",
  "Mombasa",
  "Nairobi",
  "Windhoek",
  "Cardiff",
  "Rhyl",
  "Swansea",
  "Ibadan",
  "Kano",
  "Lagos",
  "South Africa",
  "Cape Town",
  "Durban",
  "Johannesburg",
  "Beijing",
  "Chengdu",
  "Dongguan",
  "Budapest",
  "Guangzhou",
  "Milan",
  "Naples",
  "Rome",
  "Torino",
  "Venice",
  "Hangzhou",
  "Hong Kong",
  "Shanghai",
  "Shenzhen",
  "Tianjin",
  "Wuhan",
  "Copenhagen",
  "Birmingham",
  "Blackpool",
  "Bournemouth",
  "Bradford",
  "Brighton",
  "Bristol",
  "Cambridge",
  "Coventry",
  "Derby",
  "Exeter",
  "Falmouth",
  "Huddersfield",
  "Ipswich",
  "Kingston upon Hull",
  "Leeds",
  "Leicester",
  "Liverpool",
  "London",
  "Luton",
  "Manchester",
  "Middlesbrough",
  "Newcastle",
  "Northampton",
  "Norwich",
  "Nottingham",
  "Oxford",
  "Penzance",
  "Plymouth",
  "Portsmouth",
  "Preston",
  "Reading",
  "Salford",
  "Sheffield",
  "Sidmouth",
  "Southend-on-Sea",
  "St Ives",
  "Stoke-on-Trent",
  "Sunderland",
  "Swindon",
  "Truro",
  "Wakefield",
  "Wolverhampton",
  "Ahmedabad",
  "Bangalore",
  "Chennai",
  "Ajaccio",
  "Bordeaux",
  "Calvi",
  "Lille",
  "Berlin",
  "Bremen",
  "Cologne",
  "Dortmund",
  "Dresden",
  "Düsseldorf",
  "Essen",
  "Frankfurt",
  "Hamburg",
  "Hanover",
  "Leipzig",
  "Munich",
  "Nuremberg",
  "Stuttgart",
  "Lyon",
  "Marseille",
  "Nice",
  "Paris",
  "Toulouse",
  "Hyderabad",
  "Kolkata",
  "Mumbai",
  "New Delhi",
  "Pune",
  "Surat",
  "Denpasar",
  "Jakarta",
  "Tehrān",
  "Baghdad",
  "Fukuoka",
  "Hiroshima",
  "Kawasaki",
  "Kitakyushu",
  "Kobe",
  "Kyoto",
  "Busan",
  "Seoul",
  "Riyadh",
  "Nagoya",
  "Osaka",
  "Saitama",
  "Sapporo",
  "Sendai",
  "Tokyo",
  "Yokohama",
];

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // ----------- Tabs building ----------- Start
  TabController tabController;
  PageController pageController = PageController(initialPage: 0);
  List<TabTitle> tabList;
  Future<Days> fetchData; // new api -----------------------------
  var currentPage = 0;
  var isPageCanChanged = true;
  Map<String, String> selectedValueMap = Map();
  @override
  void initState() {
    super.initState();
    fetchData =
        fetchWoei('Casablanca'); // new api -----------------------------
    selectedValueMap["local"] = localData[0];
    initTabData();
    tabController = TabController(
      length: tabList.length,
      vsync: this,
    );
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        print(tabController.index);
        onPageChange(tabController.index, p: pageController);
      }
    });
  }

  initTabData() {
    tabList = [
      new TabTitle(title: 'Week', id: 0),
      new TabTitle(title: 'Change Location', id: 1),
    ];
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      isPageCanChanged = false;
      await pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
      isPageCanChanged = true;
    } else {
      tabController.animateTo(index);
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

// ----------- Tabs building ----------- End
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0, top: 18.0, bottom: 18.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeLoc(),
                ),
              ),
            ),
          )
        ],
        elevation: 0.0,
      ),
      body: Center(
        child: FutureBuilder<Days>(
          future: fetchData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 2 * MediaQuery.of(context).size.width / 4.3,
                            height: MediaQuery.of(context).size.height / 2.9,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        snapshot.data.completeDate,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 0.7),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: 5.0,
                                    ),
                                    child: Column(
                                      children: [
                                        _buildRow('Wind Speed',
                                            snapshot.data.windSpeed),
                                        _buildRow('Wind Direction',
                                            snapshot.data.windDirection),
                                        _buildRow(
                                            'Pressure', snapshot.data.pressure),
                                        _buildRow('Weather',
                                            snapshot.data.weatherName),
                                        _buildRow('Min \u00B0C',
                                            snapshot.data.minTemp),
                                        _buildRow('Max \u00B0C',
                                            snapshot.data.maxTemp),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 2.9,
                            width: 2 * MediaQuery.of(context).size.width / 5,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Column(
                              children: [
                                // Text(
                                //   snapshot.data.city,
                                //   style: TextStyle(
                                //     color: Colors.white,
                                //     fontSize: 18.0,
                                //     fontWeight: FontWeight.w500,
                                //   ),
                                // ),
                                // SizedBox(height: 10.0),
                                getSearchableDropdown(localData, "local"),
                                SizedBox(height: 10.0),
                                Text(
                                  snapshot.data.temp + '\u00B0',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 15.0),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                    child: Image.asset(snapshot.data.imgUrl),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Sunrise',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                snapshot.data.sunrise,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Sunset',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                snapshot.data.sunset,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Image.asset('assets/images/home_asset.png'),
                    Container(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: TabBar(
                          isScrollable: true,
                          controller: tabController,
                          labelColor: Colors.black,
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          unselectedLabelStyle:
                              TextStyle(fontWeight: FontWeight.w400),
                          indicatorColor: Colors.black,
                          tabs: tabList.map((item) {
                            return Tab(
                              text: item.title,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Divider(height: 0.5, color: Colors.black),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: PageView.builder(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: tabList.length,
                          onPageChanged: (index) {
                            if (isPageCanChanged) {
                              onPageChange(index);
                            }
                          },
                          controller: pageController,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return Page(
                                  index: index,
                                  fiveDays: snapshot.data.fiveDays);
                            } else {
                              return ChangeLocation();
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              // return Text("${snapshot.error}");
              // return CircularProgressIndicator();
              return Center(
                child: Container(
                  height: 3 * MediaQuery.of(context).size.height / 4,
                  width: 4 * MediaQuery.of(context).size.width / 5,
                  color: Colors.yellow,
                ),
              );
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget getSearchableDropdown(List<String> listData, mapKey) {
    List<DropdownMenuItem> items = [];
    for (int i = 0; i < listData.length; i++) {
      items.add(new DropdownMenuItem(
          child: new Text(listData[i]), value: listData[i]));
    }
    return new SearchableDropdown(
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
      items: items,
      icon: const Icon(Icons.edit_location, size: 15.0, color: Colors.white),
      value: selectedValueMap[mapKey],
      isCaseSensitiveSearch: false,
      hint: new Text(
        selectedValueMap["local"] + '  ',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      underline: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Color.fromRGBO(122, 154, 1254, 0)))),
      ),
      searchHint: new Text(
        'Available cities',
        style: new TextStyle(fontSize: 20),
      ),
      onChanged: (value) {
        setState(() {
          selectedValueMap[mapKey] = value;
          fetchData = fetchWoei(value);
          print(' -------------- Selected value : ' + value);
          print('woeid : ' + woeid);
        });
      },
    );
  }
}

// --------------------- Row ------------------
_buildRow(String text, String value) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w200,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
      SizedBox(height: 6.0),
    ],
  );
}

// --------------------- Page ---------------------
class Page extends StatelessWidget {
  final int index;
  final TheFiveDays fiveDays;

  Page({this.index, this.fiveDays});
  @override
  Widget build(BuildContext context) {
    _buildWeather(Day day) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 6.5,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day.date,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 10.0),
            Icon(day.icon, color: Colors.white, size: 30.0),
            SizedBox(height: 10.0),
            Text(
              day.degree + '\u00B0',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildWeather(fiveDays.one),
            _buildWeather(fiveDays.two),
            _buildWeather(fiveDays.three),
            _buildWeather(fiveDays.four),
            _buildWeather(fiveDays.five),
          ],
        ),
      ),
    );
  }
}

class ChangeLocation extends StatefulWidget {
  @override
  _ChangeLocationState createState() => _ChangeLocationState();
}

class _ChangeLocationState extends State<ChangeLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }
}

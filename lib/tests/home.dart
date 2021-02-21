import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class ChangeLoc extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
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
  "Alabama",
  "Alaska",
  "Arizona",
  "Arkansas",
  "California",
  "Colorado",
  "Connecticut",
  "Delaware",
  "District of Columbia",
  "Florida",
  "Georgia",
  "Hawaii",
  "Idaho",
  "Illinois",
  "Indiana",
  "Iowa",
  "Kansas",
  "Kentucky",
  "Louisiana",
  "Maine",
  "Maryland",
  "Massachusetts",
  "Michigan",
  "Minnesota",
  "Mississippi",
  "Missouri",
  "Montana",
  "Nebraska",
  "Nevada",
  "New Hampshire",
  "New Jersey",
  "New Mexico",
  "New York",
  "North Carolina",
  "North Dakota",
  "Ohio",
  "Oklahoma",
  "Oregon",
  "Pennsylvania",
  "Rhode Island",
  "South Carolina",
  "South Dakota",
  "Tennessee",
  "Texas",
  "Utah",
  "Vermont",
  "Virginia",
  "Washington",
  "West Virginia",
  "Wisconsin",
  "Wyoming",
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
  "Yokohama"
];

class _AppState extends State<ChangeLoc> {
  Map<String, String> selectedValueMap = Map();

  @override
  void initState() {
    selectedValueMap["local"] = localData[0] + '   ';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Container(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Column(
              children: <Widget>[
                getSearchableDropdown(localData, "local"),
              ],
            ),
          ),
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
      items: items,
      icon: const Icon(Icons.edit_location, size: 15.0),
      value: selectedValueMap[mapKey],
      isCaseSensitiveSearch: false,
      hint: new Text(selectedValueMap["local"]),
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
          print(' -------------- Selected value : ' + value);
        });
      },
    );
  }
}

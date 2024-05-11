import 'package:flutter/material.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import 'package:weather_app2/data/provider/searchWeather.dart';
import 'package:weather_app2/data/utils/imageIcon.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final searchWeather = SearchWeather();
  final List<WeatherModel> _searchResult = [];
  final List<WeatherModel> _searchHistory = [];

  @override
  Widget build(BuildContext context) {
    Future<dynamic> errorPopUpWidget(String error, BuildContext context) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(error.toString()),
          );
        },
      );
    }

    searchCity() async {
      _searchResult.add(
        await searchWeather
            .getWeather(cityname: _searchController.text)
            .catchError(
          (error, stackTrace) {
            errorPopUpWidget(error, context);
          },
        ),
      );
      if (searchWeather.error.isEmpty) {
        setState(
          () {
            _searchHistory.add(_searchResult.last);
            _searchController.clear();
          },
        );
      }
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _searchController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Informe uma cidade";
                        } else if (value == "") {
                          return "Informe uma cidade";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Row(
                          children: [
                            Text(
                              "Buscar uma cidade",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                  width: 70,
                  child: Card(
                    child: IconButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(
                            () {
                              _searchResult.clear;
                              searchCity();
                            },
                          );
                        }
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ),
                )
              ],
            ),
          ),
          if (_searchResult.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          _searchHistory.last.city,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _searchHistory.last.description,
                          style: const TextStyle(
                              fontSize: 17, color: Colors.black54),
                        ),
                        Text(
                          "${_searchHistory.last.temp}º",
                          style: const TextStyle(
                            fontSize: 50,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset(
                          imageIcon(_searchHistory.last.currently),
                          height: 100,
                          width: 100,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Cidades Salvas.",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100,
            width: 300,
            child: _searchHistory.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _searchHistory.length,
                    itemBuilder: (context, int index) {
                      return cityBox(
                          weatherHistory: _searchHistory, index: index);
                    },
                  )
                : const Center(
                    child: Text("Nenhuma cidade Salva"),
                  ),
          ),
          Column(
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Cidades Salvas.",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 300,
                child: _searchHistory.isNotEmpty
                    ? ListView.builder(
                        itemCount: _searchHistory.length,
                        itemBuilder: (context, int index) {
                          return cityBox(
                              weatherHistory: _searchHistory, index: index);
                        },
                      )
                    : const Center(
                        child: Text("Historio Vazio"),
                      ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget cityBox({
    required List<WeatherModel> weatherHistory,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _searchHistory[index].city,
                style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

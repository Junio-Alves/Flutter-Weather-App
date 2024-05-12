import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import 'package:weather_app2/data/provider/searchWeather.dart';
import 'package:weather_app2/data/utils/imageIcon.dart';
import 'package:weather_app2/pages/widgets/search_city_widget.dart';
import 'package:weather_app2/pages/widgets/text_shadow.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<WeatherModel> _searchResult = [];
  final List<WeatherModel> _searchHistory = [];
  final List<WeatherModel> _favoriteCitys = [];
  @override
  Widget build(BuildContext context) {
    final searchWeather = Provider.of<SearchWeather>(context);

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
      await searchWeather.getWeather(cityname: _searchController.text);
      if (searchWeather.error.isEmpty) {
        _searchResult.add(searchWeather.searchResult.first);
        _searchHistory.add(_searchResult.last);
        _searchController.clear();
      } else {
        errorPopUpWidget(searchWeather.error, context);
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
                              searchWeather.searchResult.clear();
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
          //Resultado Da Pesquisa
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
                        textshadow(
                            text: _searchHistory.last.city,
                            fontsize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textshadow(
                            text: _searchHistory.last.description,
                            fontsize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                        textshadow(
                            text: "${_searchHistory.last.temp}º",
                            fontsize: 50,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
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
          //Cidades Salvas
          Column(
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Cidades Salvas:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 150,
                width: 400,
                child: _searchHistory.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _searchHistory.length,
                        itemBuilder: (context, int index) {
                          return cityBox(
                              context: context,
                              searchHistory: _searchHistory,
                              index: index);
                        },
                      )
                    : const Center(
                        child: Text("Nenhuma cidade Salva"),
                      ),
              ),
            ],
          ),
          //Historico de Pesquisa
          Column(
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Historico de Pesquisa:",
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
                              context: context,
                              searchHistory: _searchHistory,
                              index: index);
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
}

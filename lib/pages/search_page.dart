import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import 'package:weather_app2/data/provider/searchWeather_provider.dart';
import 'package:weather_app2/data/provider/userData_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final searchWeather = Provider.of<SearchWeather>(context);
    final userData = Provider.of<UserData>(context);

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
        userData.searchHistoryAdd(searchWeather.searchResult.first);
        userData.saveUserHistory();
        _searchController.clear();
      } else {
        errorPopUpWidget(searchWeather.error, context);
      }
    }

    addFavorite() {
      bool isFavorite = false;
      for (WeatherModel weather in userData.favoriteCitys) {
        if (weather.city == searchWeather.searchResult.first.city) {
          isFavorite = true;
        }
      }
      if (isFavorite == false) {
        userData.favoriteCitysAdd(searchWeather.searchResult.first);
        userData.saveUserFavorite();
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            //Formulario
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
                  //Botão de Pesquisa
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: Card(
                      elevation: 4,
                      color: const Color.fromARGB(255, 58, 134, 60)
                          .withOpacity(0.9),
                      child: IconButton(
                        color: Colors.white,
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
            if (searchWeather.searchResult.isNotEmpty)
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
                              text: searchWeather.searchResult.first.city,
                              fontsize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textshadow(
                              text:
                                  searchWeather.searchResult.first.description,
                              fontsize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          textshadow(
                              text: "${searchWeather.searchResult.first.temp}º",
                              fontsize: 50,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                imageIcon(
                                    searchWeather.searchResult.first.currently),
                                height: 100,
                                width: 100,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      addFavorite();
                                    },
                                  );
                                },
                                icon: const Icon(Icons.star_border),
                              )
                            ],
                          )
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 150,
                  width: 400,
                  child: userData.favoriteCitys.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: userData.favoriteCitys.length,
                          itemBuilder: (context, int index) {
                            return cityBox(
                                context: context,
                                searchHistory: userData.favoriteCitys,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Historico de Pesquisa:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            userData.clearHistory();
                          });
                        },
                        icon: const Icon(Icons.clear))
                  ],
                ),
                SizedBox(
                  height: 500,
                  child: userData.searchHistory.isNotEmpty
                      ? ListView.builder(
                          itemCount: userData.searchHistory.length,
                          itemBuilder: (context, int index) {
                            return cityBox(
                                context: context,
                                searchHistory: userData.searchHistory,
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
      ),
    );
  }
}

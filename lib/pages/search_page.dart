import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app2/data/provider/userData_provider.dart';
import 'package:weather_app2/data/provider/weather_provider.dart';
import 'package:weather_app2/data/utils/weatherIcon.dart';
import 'package:weather_app2/pages/widgets/popUpError_widget.dart';
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
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final userData = Provider.of<UserData>(context);

    searchCity() async {
      await weatherProvider.searchWeather(cityname: _searchController.text);
      if (weatherProvider.error.isEmpty ||
          weatherProvider.resultWeather != null) {
        userData.searchHistoryAdd(weatherProvider.resultWeather!);
        userData.saveUserHistory();
        _searchController.clear();
      } else {
        errorPopUpWidget(weatherProvider.error, context);
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            //Formulario
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ),
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _searchController,
                            validator: (value) {
                              if (value!.isEmpty || value == "") {
                                return "Informe uma cidade";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              focusColor: Colors.white,
                              label: Row(
                                children: [
                                  Text(
                                    "Procurar Cidade",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ],
                              ),
                              border: InputBorder.none,
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
                                    weatherProvider.clearSearchResult();
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
              ],
            ),
            //Resultado Da Pesquisa
            if (weatherProvider.resultWeather != null)
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
                              text: weatherProvider.resultWeather!.city,
                              fontsize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textshadow(
                              text: weatherProvider.resultWeather!.description,
                              fontsize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          textshadow(
                              text: "${weatherProvider.resultWeather!.temp}º",
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
                                WeatherIcon.white(weatherProvider
                                    .resultWeather!.conditionSlug),
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
                                      userData.saveUserFavorite(
                                          weatherProvider.resultWeather!);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Cidades Salvas:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(
                            () {
                              userData.clearFavorites();
                            },
                          );
                        },
                        icon: const Icon(Icons.clear))
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

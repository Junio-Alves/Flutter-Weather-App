import 'package:flutter/material.dart';
import 'package:weather_app2/data/models/weather_model.dart';
import 'package:weather_app2/data/utils/imageIcon.dart';

Widget cityBox(
    {required List<WeatherModel> searchHistory,
    required int index,
    required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      height: 120,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: const Color.fromARGB(255, 58, 134, 60).withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  searchHistory[index].city,
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  searchHistory[index].time,
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  searchHistory[index].description,
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Image.asset(
                imageIcon(searchHistory[index].currently),
                height: 70,
                width: 70,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "${searchHistory[index].temp}°",
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

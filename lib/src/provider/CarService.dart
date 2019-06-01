import 'dart:convert';

import 'package:http/http.dart' as Client;
import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Car.dart';
import '../utils/Constants.dart';
import 'dart:io';

class CarService {
  Future<String> createCar(Car car) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.get('email');
    var url =
        "http://edumoreno27-001-site3.etempurl.com/public/api/car/crearcar";
    String response;

    var dataJson = json.encode({
      'marca': car.marca,
      'modelo': car.modelo,
      'placa': car.placa,
      'combustible': car.combustible,
      'email': email,
    });

    try {
      await Client.post(url,
              headers: {HttpHeaders.CONTENT_TYPE: "application/json"},
              body: dataJson)
          .then((Client.Response response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> parsedJson = json.decode(response.body);
          response = parsedJson['status'];
        }
      });
    } catch (error) {
      response = "error";
    }
    return response;
  }

  Future<List<Car>> getCars(String email) async {
    List<Car> lista = new List<Car>();
    var url =
        "http://edumoreno27-001-site3.etempurl.com/public/api/car/obtenercarros";
    String response;

    var dataJson = json.encode({
      'email': email,
    });

    try {
      await Client.post(url,
              headers: {HttpHeaders.CONTENT_TYPE: "application/json"},
              body: dataJson)
          .then((Client.Response response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> parsedJson = json.decode(response.body);
          response = parsedJson['status'];
          var jsonArrayAlimentos = parsedJson["carros"];
          Car car;

          for (var objectCar in jsonArrayAlimentos as List) {
            car = new Car();
            car.combustible = (objectCar["combustible"].toString());
            car.email = (objectCar["email"].toString());
            car.marca = (objectCar["marca"].toString());
            car.modelo = (objectCar["modelo"].toString());
            car.placa = (objectCar["placa"].toString());

            lista.add(car);
          }
        }
      });
    } catch (error) {
      response = "error";
    }
    return lista;
  }
}

// ignore_for_file: file_names, avoid_print
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchApi {
  fetchListOfAllCategory() async {
    var client = http.Client();
    try {
      var res = await client.get(
          Uri.parse("https://www.themealdb.com/api/json/v1/1/list.php?c=list"));
      if (res.statusCode == 200) {
        // print(res.body);
        return json.decode(res.body);
      } else if (res.statusCode == 502) {
        return const Text("Not Connected");
      }
    } catch (e) {
     return false;
    }
  }

  fetchARandomRecipe() async {
    var client = http.Client();
    try {
      var res = await client
          .get(Uri.parse("https://www.themealdb.com/api/json/v1/1/random.php"));
      if (res.statusCode == 200) {
        // print(res.body);
        return json.decode(res.body);
      }else if (res.statusCode == 502) {
        return const Text("Not Connected");
      }
    } catch (e) {
     return false;
    }
  }

  fetchListOfAllAreas() async {
    var client = http.Client();
    try {
      var res = await client.get(
          Uri.parse("https://www.themealdb.com/api/json/v1/1/list.php?a=list"));
      if (res.statusCode == 200) {
        // print(res.body);
        return json.decode(res.body);
      }else if (res.statusCode == 502) {
        return const Text("Not Connected");
      }
    } catch (e) {
     return false;
    }
  }

  fetchListOfAllIngredients() async {
    var client = http.Client();
    try {
      var res = await client.get(
          Uri.parse("https://www.themealdb.com/api/json/v1/1/list.php?i=list"));
      if (res.statusCode == 200) {
        // print(res.body);
        return json.decode(res.body);
      }else if (res.statusCode == 502) {
        return const Text("Not Connected");
      }
    } catch (e) {
     return false;
    }
  }

  fetchDataFromAnIngredients(ingredient) async {
    var client = http.Client();
    try {
      var res = await client.get(Uri.parse(
          "https://www.themealdb.com/api/json/v1/1/filter.php?i=$ingredient"));
      if (res.statusCode == 200) {
        // print(res.body);
        return json.decode(res.body);
      }else if (res.statusCode == 502) {
        return const Text("Not Connected");
      }
    } catch (e) {
     return false;
    }
  }

  fetchDataForASpecificCountry(country) async {
    var client = http.Client();
    try {
      var res = await client.get(Uri.parse(
          "https://www.themealdb.com/api/json/v1/1/filter.php?a=$country"));
      if (res.statusCode == 200) {
        // print(res.body);
        return json.decode(res.body);
      }else if (res.statusCode == 502) {
        return const Text("Not Connected");
      }
    } catch (e) {
     return false;
    }
  }

  fetchDataByid(id) async {
    var client = http.Client();
    try {
      var res = await client.get(Uri.parse(
          "https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id"));
      if (res.statusCode == 200) {
        // print(res.body);
        return json.decode(res.body);
      }else if (res.statusCode == 502) {
        return const Text("Not Connected");
      }
    } catch (e) {
     return false;
    }
  }

  fetchDataByFirstLetter(letter) async {
    var client = http.Client();
    try {
      var res = await client.get(Uri.parse(
          "https://www.themealdb.com/api/json/v1/1/search.php?f=$letter"));
      if (res.statusCode == 200) {
        // print(res.body);
        return json.decode(res.body);
      }else if (res.statusCode == 502) {
        return const Text("Not Connected");
      }
    } catch (e) {
     return false;
    }
  }

  fetchDataByName(query) async {
    var client = http.Client();
    try {
      var res = await client.get(Uri.parse(
          "https://www.themealdb.com/api/json/v1/1/search.php?s=$query"));
      if (res.statusCode == 200) {
        // print(res.body);
        return json.decode(res.body);
      }else if (res.statusCode == 502) {
        return const Text("Not Connected");
      }
    } catch (e) {
     return false;
    }
  }

  fetchDataByCategory(category) async {
    var client = http.Client();
    try {
      var res = await client.get(Uri.parse(
          "https://www.themealdb.com/api/json/v1/1/filter.php?c=$category"));
      if (res.statusCode == 200) {
        // print(res.body);
        return json.decode(res.body);
      }else if (res.statusCode == 502) {
        return const Text("Not Connected");
      }
    } catch (e) {
     return false;
    }
  }

checkNetwork() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }

}


}



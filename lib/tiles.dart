import 'package:flutter/material.dart';
import 'package:just_class/calling_constructor.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert' as convert;

import 'package:just_class/json.dart';

class Tiles extends StatefulWidget {
  @override
  _TilesState createState() => _TilesState();
}

class _TilesState extends State<Tiles> {
  List<Users> httpData;
  List<Users> dioData;
  bool waiting = true;

  @override
  void initState() {
    super.initState();
    getHttpData();
    getDioData();
  }

  getHttpData() async {
    http.Response response =
        await http.get('https://jsonplaceholder.typicode.com/users');
    if (response.statusCode == 200) {
      final users = usersFromJson(response.body);

      // print(users[0].email);
      httpData = users;
      setState(() {
        waiting = false;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  getDioData() async {
    var dio = Dio();
    Response<String> response =
        await dio.get('https://jsonplaceholder.typicode.com/users');
    if (response.statusCode == 200) {
      final users = usersFromJson(response.data);

      // print(users[0].email);
      dioData = users;
      setState(() {
        waiting = false;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  ConstList list = ConstList();

  @override
  Widget build(BuildContext context) {
    getDioData();
    getHttpData();
    return Scaffold(
      body: (waiting)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: (httpData != null) ? 10 : 1,
              itemBuilder: (BuildContext context, index) {
                return Card(
                  elevation: 2,
                  child: ClipPath(
                    child: Container(
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.red, width: 10),
                        ),
                        tileColor: Colors.lightGreen[100],
                        title: Text(dioData[index].name),
                        subtitle: Text(httpData[index].email),
                      ),
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.green, width: 5),
                        ),
                      ),
                    ),
                    clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}

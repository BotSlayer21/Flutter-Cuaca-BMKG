import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List listData = [];
  List filteredData = [];
  
  @override
  void initState() {
    super.initState();
    getData();
  }

  List listdata = [];
  void getData() async {
    var url =
        Uri.parse('https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json');
    var respon = await http.get(url);
    var responJson = jsonDecode(respon.body);
    setState(() {
      listdata = responJson;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.cloud_sharp, size: 30),
        title: Text(
          'Weather App',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Times New Roman',
            fontSize: 25,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: listdata.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/detail-page',
                  arguments: listdata[index]);
            },
            title: Text(
              listdata[index]['kota'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Times New Roman',
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(listdata[index]['propinsi']),
                Text(listdata[index]['lat'].toString()),
                Text(listdata[index]['lon'].toString()),
              ],
            ),
          );
        },
      ),
    );
  }
}

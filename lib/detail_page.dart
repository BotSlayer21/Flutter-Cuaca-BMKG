import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List listData = [];
  List filteredData = [];
  void getData(String id) async {
    var url = Uri.parse('https://ibnux.github.io/BMKG-importer/cuaca/$id.json');
    var respon = await http.get(url);
    var responJson = jsonDecode(respon.body);
    if (!mounted) return;
    setState(() {
      listData = responJson;
    });
  }

  void filterData(String query) {
    setState(() {
      filteredData = listData
          .where((item) =>
              item['cuaca'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    filteredData = listData;
  }

  @override
  Widget build(BuildContext context) {
    var dataCuaca = ModalRoute.of(context)!.settings.arguments as Map;
    String id = dataCuaca['id'].toString();
    String kota = dataCuaca['kota'].toString();
    getData(id);
    return Scaffold(
        appBar: AppBar(
          title: Text('Cuaca ' + kota),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert, size: 30),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                onChanged: (query) {
                  filterData(query);
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Search cuaca...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: 
              // ListView.builder(
              //   itemCount: listData.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     var jamCuaca = DateTime.parse(listData[index]['jamCuaca']);
              //     var dateFormatted =
              //         DateFormat('EEEE, d/M/yyyy HH:mm').format(jamCuaca);
              //     return ListTile(
              //       title: Text("Cuaca  " + listData[index]['cuaca']),
              //       subtitle: Text(dateFormatted),
              //       //subtitle: Text("Jam " + listData[index]['jamCuaca']),
              //     );
              //   },
              // ),
              ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (BuildContext context, int index) {
                var jamCuaca = DateTime.parse(filteredData[index]['jamCuaca']);
                var dateFormatted = DateFormat('EEEE, d/M/yyyy HH:mm').format(jamCuaca);
                  return ListTile(
                    title: Text("Cuaca " + filteredData[index]['cuaca']),
                    subtitle: Text(dateFormatted),
                  );
                },
              ),
            ),
          ],
        )
        );
  }
}

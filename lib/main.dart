import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map<String, dynamic>> getData() async {
    final dio = Dio();

    final Response response =
        await dio.get('https://gammer.xenio.in/api/getall');
    log(response.data);

    return jsonDecode(response.data);
  }

  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var snap = snapshot.data!;
            log(snapshot.data!['result']);
            return SafeArea(
              child: Center(
                child: Card(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(snap['code'].toString()),
                    Text(snap['result']),
                    Text(snap["data"]["code"].toString()),
                    Text(snap["data"]["rate"].toString()),
                    Text(snap["data"]["rate2"].toString()),
                    Text(snap["data"]["symbol"].toString()),
                  ],
                )),
              ),
            );
          }
        },
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:ui';
import 'package:http/http.dart' ;

import 'screens/return_list_graphql.dart';

void main()  async {
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    

    return MaterialApp(
      home:  MyHomePage(),
        
      
    );
  }
}



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Parsing data using GraphQL',
          ),
        ),
        
        body: Center(
          child: Column(
            children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => graphql_list_screen()));
                },
                child: const Text("click here to view list")),
            ]
          )
        )
      )
    );
  }
}
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube/api.dart';
import 'package:youtube/blocs/favorite_bloc.dart';
import 'package:youtube/blocs/videos_bloc.dart';
import 'package:youtube/pages/home.dart';

void main(){
  Api api = Api();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i)=> VideosBloc()),
        Bloc((j)=>FavoriteBloc())
      ],
      child:  MaterialApp(
      title: 'Youtube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
    );
  }
}
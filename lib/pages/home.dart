import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube/blocs/favorite_bloc.dart';
import 'package:youtube/blocs/videos_bloc.dart';
import 'package:youtube/delegates/data_search.dart';
import 'package:youtube/models/video.dart';
import 'package:youtube/pages/favorites.dart';
import 'package:youtube/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        title: Container(
          height: 25,
          child: Image.asset("images/youtube.png"),
        ),
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String,Video>>(
              stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
              initialData: {},
              builder: (context, snapshot){
                if(snapshot.hasData) return Text("${snapshot.data.length}");
                else return Container();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>Favorites()
                )
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async{
              String result = await showSearch(context: context, delegate: DataSearch());
              if(result != null) BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
            },
          ),
        ],
      ),
      body: StreamBuilder(
        initialData: [],
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
        builder: (context , snapshot){
          if(snapshot.hasData)
            return ListView.builder(
              itemBuilder: (context, index){
                if(index < snapshot.data.length){
                  return VideoTile(snapshot.data[index]);
                } else if(index > 1){
                  BlocProvider.getBloc<VideosBloc>().inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),

                  );
                } else {
                  return Container();
                }
                
              },
              itemCount: snapshot.data.length + 1,
            );
          else 
            return Container();
        },
      ),
    );
  }
}
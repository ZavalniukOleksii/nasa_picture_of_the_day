import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:starlab_tech_test/apis/interfaces/picture_of_the_day.api_interface.dart';
import 'package:starlab_tech_test/blocs/picture_of_the_day/picture_of_the_day.bloc.dart';
import 'package:video_player/video_player.dart';

class PictureOfTheDayPage extends StatefulWidget {
  const PictureOfTheDayPage({super.key});

  @override
  State<PictureOfTheDayPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PictureOfTheDayPage> {
  late final VideoPlayerController _videoController;
  final _pictureOfTheDayBloc = PictureOfTheDayBloc(
    GetIt.instance.get<PictureOfTheDayApiInterface>(),
  );

  @override
  void initState() {
    _pictureOfTheDayBloc.add(PictureOfTheDayRequest());
    _videoController
      ..setLooping(true)
      ..initialize()
      ..play();

    super.initState();
  }

  @override
  void dispose() {
    _videoController.dispose();
    _pictureOfTheDayBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PictureOfTheDayBloc, PictureOfTheDayState>(
          bloc: _pictureOfTheDayBloc,
          builder: (context, state) {
            if (state is PictureOfTheDayLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PictureOfTheDayImageReady) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      state.pictureOfTheDay.url,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                    Text(state.pictureOfTheDay.title),
                  ],
                ),
              );
            }
            if (state is PictureOfTheDayVideoReady) {
              _videoController = VideoPlayerController.networkUrl(
                Uri.parse(state.pictureOfTheDay.url),
              );
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: VideoPlayer(_videoController),
                    ),
                    Text(state.pictureOfTheDay.title),
                  ],
                ),
              );
            }
            if (state is PictureOfTheDayFailed) {
              return Center(
                child: Text(state.message),
              );
            }

            /// this should be in the localisation file
            return const Center(
              child: Text('Initial state'),
            );
          }),
    );
  }
}

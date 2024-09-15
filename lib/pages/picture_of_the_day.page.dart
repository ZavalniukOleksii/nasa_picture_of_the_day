import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:page_transition/page_transition.dart';
import 'package:starlab_tech_test/blocs/picture_of_the_day/picture_of_the_day.bloc.dart';
import 'package:starlab_tech_test/pages/fullsize_picture.page.dart';
import 'package:starlab_tech_test/repos/interfaces/picture_of_the_day.repo_interface.dart';
import 'package:video_player/video_player.dart';

class PictureOfTheDayPage extends StatefulWidget {
  const PictureOfTheDayPage({super.key});

  @override
  State<PictureOfTheDayPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PictureOfTheDayPage> {
  late final VideoPlayerController _videoController;

  final _pictureOfTheDayBloc = PictureOfTheDayBloc(
    GetIt.instance.get<PictureOfTheDayRepoInterface>(),
  );

  @override
  void initState() {
    _pictureOfTheDayBloc.add(PictureOfTheDayRequest());

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
              final pictureOfTheDay = state.pictureOfTheDay;

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      pictureOfTheDay.url,
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                    const SizedBox(height: 8),
                    Text(pictureOfTheDay.title),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        /// this should be handled by the navigator
                        Navigator.of(context).push(
                          PageTransition(
                            child:
                                FullSizeImagePage(url: pictureOfTheDay.hdurl),
                            type: PageTransitionType.fade,
                            duration: const Duration(milliseconds: 350),
                          ),
                        );
                      },
                      child: const Text('Open a full image in a new page'),
                    ),
                  ],
                ),
              );
            }
            if (state is PictureOfTheDayVideoReady) {
              _videoController = VideoPlayerController.networkUrl(
                Uri.parse(state.pictureOfTheDay.url),
              )
                ..setLooping(true)
                ..initialize()
                ..play();

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

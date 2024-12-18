import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/presentation/home/bloc/play_list_bloc.dart';
import 'package:spotify/presentation/song_player/pages/song_player.dart';

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  @override
  void initState() {
    super.initState();
    context.read<PlayListBloc>().add(GetPlayListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayListBloc, PlayListState>(
      builder: (context, state) {
        if (state is PlayListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is PlayListLoaded) {
          debugPrint('PLAYLISTLOADED.........');
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 16,
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Playlist',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'See More',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color(0xFFC6C6C6)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _playList(state.songs),
              ],
            ),
          );
        }

        return const Center(
          child: Text('No PlayList...'),
        );
      },
    );
  }

  Widget _playList(List<SongEntity> songs) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final song = songs[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongPlayer(songEntity: song),
                ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode
                          ? AppColors.darkGrey
                          : const Color(0xFFE6E6E6),
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: context.isDarkMode
                          ? const Color(0xFF959595)
                          : const Color(0xFF555555),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        song.artist,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    song.duration.toString().replaceAll('.', ':'),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_outline_outlined,
                      size: 25,
                      color: context.isDarkMode
                          ? AppColors.darkGrey
                          : const Color(0xFFE6E6E6),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: songs.length,
    );
  }
}

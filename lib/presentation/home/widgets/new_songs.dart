import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/constants/app_urls.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/presentation/home/bloc/song_bloc.dart';
import 'package:spotify/presentation/song_player/pages/song_player.dart';

class NewSongs extends StatefulWidget {
  const NewSongs({super.key});

  @override
  State<NewSongs> createState() => _NewSongsState();
}

class _NewSongsState extends State<NewSongs> {
  @override
  void initState() {
    super.initState();
    context.read<SongBloc>().add(GetNewsSongsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BlocBuilder<SongBloc, SongState>(
        builder: (context, state) {
          if (state is SongsLoading) {
            debugPrint('SONGLOADING.........');
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is SongsLoaded) {
            debugPrint('SONGLOADED.........');
            return _songs(state.songs);
          }

          return const Center(
            child: Text('No news songs...'),
          );
        },
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 16,
        left: 16,
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
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
            child: SizedBox(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            '${AppUrls.coverFirestorage}${song.artist} - ${song.title}.jpg?${AppUrls.mediaAlt}',
                          ),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 40,
                          width: 40,
                          transform: Matrix4.translationValues(10, 10, 0),
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
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemCount: songs.length,
      ),
    );
  }
}

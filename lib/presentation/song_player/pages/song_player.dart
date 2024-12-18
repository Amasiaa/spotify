// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/configs/constants/app_urls.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';

class SongPlayer extends StatelessWidget {
  const SongPlayer({
    super.key,
    required this.songEntity,
  });

  final SongEntity songEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(
          'Now playing',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert_rounded,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            _songCover(context),
            const SizedBox(height: 20),
            _songDetail(context),
          ],
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            '${AppUrls.firestorage}${songEntity.artist} - ${songEntity.title}.jpg?${AppUrls.mediaAlt}',
          ),
        ),
      ),
    );
  }

  Widget _songDetail(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              songEntity.artist,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.favorite_outline_outlined,
            size: 35,
            color: context.isDarkMode
                ? AppColors.darkGrey
                : const Color(0xFFE6E6E6),
          ),
        ),
      ],
    );
  }
}

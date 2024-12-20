// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/blocs/favorite_button/favorite_button_bloc.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;

  const FavoriteButton({
    super.key,
    required this.songEntity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteButtonBloc, FavoriteButtonState>(
      builder: (context, state) {
        if (state is FavoriteButtonInitial) {
          return IconButton(
            onPressed: () {
              context
                  .read<FavoriteButtonBloc>()
                  .add(FavoriteButtonUpdatedEvent(songId: songEntity.songId));
            },
            icon: Icon(
              songEntity.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_outline_outlined,
              size: 25,
              color: context.isDarkMode
                  ? AppColors.darkGrey
                  : const Color(0xFFE6E6E6),
            ),
          );
        }

        if (state is FavoriteButtonUpdated) {
          return IconButton(
            onPressed: () {
              context
                  .read<FavoriteButtonBloc>()
                  .add(FavoriteButtonUpdatedEvent(songId: songEntity.songId));
            },
            icon: Icon(
              state.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_outline_outlined,
              size: 25,
              color: context.isDarkMode
                  ? AppColors.darkGrey
                  : const Color(0xFFE6E6E6),
            ),
          );
        }
        return Container();
      },
    );
  }
}

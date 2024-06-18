import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/api/api.dart';
import 'package:netflix/models/movies.dart';
import 'package:netflix/styles/colors/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

SizedBox vidorimg(double width,{required YoutubePlayerController? youtubePlayerController,
  required Movies moviedetail,required String? vid
  }) {
    return SizedBox(
              width: double.infinity,
              height: 300,
              child: vid == null && youtubePlayerController == null
                  ? CachedNetworkImage(
                      imageUrl:
                          '${Api.imageurl}${moviedetail.backdroppath}',
                      fit: BoxFit.fill,
                      placeholder: (context, url) {
                        return Shimmer.fromColors(
                          baseColor: shimmerbasecolor,
                          highlightColor: shimmerbasecolor,
                          child: Container(
                            width: width,
                            color: grey,
                          ),
                        );
                      },
                    )
                  : YoutubePlayer(controller: youtubePlayerController!));
  }
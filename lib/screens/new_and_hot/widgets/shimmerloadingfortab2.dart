import 'package:flutter/material.dart';
import 'package:netflix/styles/colors/colors.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerLoadingfortab2() {
    return Shimmer.fromColors(
      baseColor: black, 
      highlightColor:
          shimmerLoadingfortab1highlightcolor,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            height: 360,
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  color: shimmerblack,
                  height: 180,
                  width: double.infinity,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      color:
                          shimmerblack,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color:
                          shimmerblack,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color:
                          shimmerblack,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 20,
                  color: shimmerblack,
                  width: double.infinity,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
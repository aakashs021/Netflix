import 'package:flutter/material.dart';
import 'package:netflix/styles/colors/colors.dart';
import 'package:netflix/styles/customtext/text.dart';

Row ratingandotherdetails({required String date,required String voteaverage,required String orglan}) {
    return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, bottom: 4),
                      child: netflixtext(
                        colour: grey,
                        text: date,
                        fw: FontWeight.w100,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(4),
                      color: detailpagerating,
                      child: Row(
                        children: [
                           const Icon(
                            Icons.star,
                            color: yellow,
                            size: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 5, bottom: 4),
                            child: netflixtext(
                              colour: grey,
                              text: voteaverage,
                              fw: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                     const Icon(
                      Icons.language_outlined,
                      color: grey,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, bottom: 4),
                      child: netflixtext(
                        colour: grey,
                        text:
                            orglan,
                        fw: FontWeight.w100,
                      ),
                    ),
                  ],
                );}
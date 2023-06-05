// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:wallet_digital/utils/responsive_screen.dart';

class TransferProfile extends StatelessWidget {
  final String image;

  const TransferProfile({
    Key? key,
    required this.image,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(mobile: _Mobile(image: image), tablet: _Mobile(image: image), web: _Mobile(image: image));
  }
}


class _Mobile extends StatelessWidget {
  final String image;

  const _Mobile({required this.image,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        ClipRRect(
          borderRadius: BorderRadius.circular(360),
          child: SizedBox(
            height: 100,
            width: 100,
            child: Image.memory(base64Decode(image),fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.person,
            size: 100,),
            ),
          ),
        ),
        const SizedBox(height: 10,)
      ],
    );
  }
}

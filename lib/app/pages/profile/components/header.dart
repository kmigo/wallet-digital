// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallet_digital/ds/ds.dart';
import 'package:wallet_digital/helpers/files.dart';
import 'package:wallet_digital/utils/responsive_screen.dart';

class ProfileHeader extends StatelessWidget {
  final String image;
  final ValueChanged<String> onChange; 
  const ProfileHeader({
    Key? key,
    required this.image,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(mobile: _Mobile(image: image, onChange: onChange), tablet: _Mobile(image: image, onChange: onChange), web: _Mobile(image: image, onChange: onChange));
  }
}


class _Mobile extends StatelessWidget {
  final String image;
  final ValueChanged<String>? onChange; 
  const _Mobile({required this.image,
    required this.onChange,});

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
        const SizedBox(height: 10,),
        if(onChange != null)...[
           TopButton(text: 'Galeria',type: TopButtonType.contain ,onTap: ()async {
      onChange?.call(await HelperFiles.getImageBase64());
     },)
        ]
    
        
      ],
    );
  }
}

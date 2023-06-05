

import 'package:flutter/material.dart';

import 'package:wallet_digital/utils/responsive_screen.dart';

import '../../../../ds/ds.dart';
import '../../../../utils/masks.dart';

class TransferHeader extends StatelessWidget {
  final Function(double) setAmount;
  final String? initialValue;
  const TransferHeader({super.key, this.initialValue,required this.setAmount});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveScreen(mobile: _HeaderMobile(setAmount,initialValue),
     tablet: _HeaderMobile(setAmount,initialValue), web: _HeaderMobile(setAmount,initialValue));
  }
}


class _HeaderMobile extends StatelessWidget {
   final Function(double) setAmount;
   final String? initialValue;
  const _HeaderMobile(this.setAmount,this.initialValue);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        children: [
          SizedBox(height: size.height * .02 ,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TopText(text: 'R\$  ',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                     color: TopColors.greenColor,
                        fontWeight: FontWeight.bold
                  ),
                  ),
                  SizedBox(
                    width: size.width * .2,
                    child: TopInputField(
                      initialValue: initialValue,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: TopColors.greenColor,
                        fontWeight: FontWeight.bold
                      ),
                      align: TextAlign.center,
                      inputFormatters: [CurrencyInputFormatter()],
                      onChanged: (text) => setAmount(double.tryParse(text.replaceAll(',', '.') ) ?? 0.0),
                      hintText: "0,00",
                      border: null,
                    ),
                  ),
                  
                ],
                
              ),
              const SizedBox(height: 5,),
              TopText(text: 'Digite o valor que você deseja\nque seja entre 20 a 3000 reais',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: TopColors.greyColor),
              ),
                  SizedBox(height: size.height * .03,),
                 Container(
                  height: 10,
                  width: size.width,
                  color: TopColors.greyColor.withOpacity(.3),
                 ),
                 SizedBox(height: size.height * .03,),
        ],
      ),
    );
  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostGridCellView extends StatelessWidget{

  final String sNickName;
  final String sBody;
  final String sDate;
  final int iColorCode;
  final double dFontSize;
  final int iPosition;
  final Function(int indice) onItemListClickedFun;

  const PostGridCellView({super.key,
    required this.sNickName,
    required this.sBody,
    required this.sDate,
    required this.iColorCode,
    required this.dFontSize,
    required this.iPosition,
    required this.onItemListClickedFun
  });


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
    child: FractionallySizedBox(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 25),
            padding: EdgeInsets.all(25),
            //color: Colors.amber[iColorCode],
              child: Row(
              children: [
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(sNickName,style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        Text(sBody,
                              overflow: TextOverflow.ellipsis,),
                        const SizedBox(height: 10,),
                        Text(sDate),
                        //"$sNickName • $sDate"
                      ],
                    )
                )
              ],
            )
        ),
    ),
      onTap: () {
      onItemListClickedFun(iPosition);
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors_resources.dart';
import 'global_text.dart';

class GlobalExpansionTile extends StatelessWidget {
  final String title;
  final List subList;
  final List<Widget> onTap;
  const GlobalExpansionTile({
    super.key,
    required this.title,
    required this.subList,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
        shadowColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        disabledColor: Colors.transparent,
        listTileTheme: ListTileTheme.of(context)
            .copyWith(dense: true, minVerticalPadding: 16),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        title: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: GlobalText(
              str: title,
              color: ColorRes.deep300,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        trailing: const Icon(Icons.arrow_drop_down, color: ColorRes.black),
        collapsedIconColor: Colors.transparent, // Hide the arrow icon when collapsed
        collapsedTextColor: Colors.transparent, // Hide the title when collapsed
        children: subList.asMap().entries.map((e){
          return SubList(
              title: e.value,
              onTap: (){
                switch(e.key){
                  case 0:
                    Get.to(()=> onTap[0]);
                    break;
                  case 1:
                    Get.to(()=> onTap[1]);
                    break;
                  case 2:
                    Get.to(()=> onTap[2]);
                    break;
                  case 3:
                    Get.to(()=> onTap[3]);
                    break;
                  case 4:
                    Get.to(()=> onTap[4]);
                    break;
                  case 5:
                    Get.to(()=> onTap[5]);
                    break;
                  case 6:
                    Get.to(()=> onTap[6]);
                    break;
                  case 7:
                    Get.to(()=> onTap[7]);
                    break;
                  case 8:
                    Get.to(()=> onTap[8]);
                    break;
                  case 9:
                    Get.to(()=> onTap[9]);
                    break;
                  case 10:
                    Get.to(()=> onTap[10]);
                    break;
                  case 11:
                    Get.to(()=> onTap[11]);
                    break;
                  case 12:
                    Get.to(()=> onTap[12]);
                    break;
                  case 13:
                    Get.to(()=> onTap[13]);
                    break;
                  case 14:
                    Get.to(()=> onTap[14]);
                    break;
                }
              });
        }).toList(),

      ),
    );
  }
}

class SubList extends StatelessWidget {
  final String title;
  final Function() onTap;
  const SubList({
    super.key,
    required this.title,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        // shadowColor: ColorRes.orangeNormal2,
        // focusColor: ColorRes.orangeNormal2,
        // hoverColor: ColorRes.orangeNormal2,
        // highlightColor: ColorRes.orangeNormalOpa1,
        highlightColor: Colors.transparent,
        // disabledColor: ColorRes.orangeNormal2,
      ),
      child: ListTile(
          onTap: onTap,
          dense: true,
          visualDensity: const VisualDensity(vertical: -4),
          focusColor: ColorRes.orange,
          hoverColor: ColorRes.orange,
          // contentPadding: EdgeInsets.only(top: 0),
          title: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GlobalText(
                str: title,
                color: ColorRes.black,
                fontSize: 11,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
              ),
            ),
          )
      ),
    );
  }
}

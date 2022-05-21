import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/core/extension/context_extension.dart';

class ToyCard extends StatelessWidget {
  const ToyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(ImageConstants.tiger),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColor.customTurquoise,
                  radius: context.dynamicWidth(15),
                  child: Icon(Icons.person),
                ),
                SizedBox(width: 20),
                Text('Jane Doe'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){},
                  child: Icon(Icons.refresh),
                ),
                SizedBox(width: 20,),
                InkWell(
                  onTap: (){},
                  child: Icon(Ionicons.chatbubble_ellipses_outline),
                ),
                SizedBox(width: 20,),
                InkWell(
                  onTap: (){},
                  child: Icon(Icons.favorite_border),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

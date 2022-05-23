import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/core/extension/context_extension.dart';
import 'package:swapy/core/widget/button/custom_circle_button.dart';
import 'package:swapy/screens/home/model/toy_model.dart';

class ProductDetail extends StatelessWidget {
  final Toy toy;

  const ProductDetail({Key? key, required this.toy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: ListView(
      children: [
        Stack(
          children: [
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                child: Container(
                  width: context.currentWidth,
                  child: CachedNetworkImage(
                    imageUrl: toy.image ?? ImageConstants.tiger,
                  ),
                )),
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomCircleButton(
                    icon: Icons.arrow_back_ios,
                  ),
                  CustomCircleButton(
                    icon: Icons.favorite_border,
                  )
                ],
              ),
            )
          ],
        ),
        ListTile(
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: toy.advertiserImage != null
                    ? DecorationImage(image: NetworkImage(toy.advertiserImage!))
                    : null),
          ),
          title: Text(toy.advertiser ?? ''),
          subtitle: Row(
            children: [
              for (var i = 0; i < (toy.advertiserRating?.floor() ?? 0); i++)
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              for (var i = 0; i < 5 - (toy.advertiserRating?.ceil() ?? 0); i++)
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              Text((toy.advertiserRating ?? 0).toString())
            ],
          ),
        ),
        ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.all(12),
          children: [
            Text(toy.name ?? '', style: textTheme.headline3),
            Card(
              child: Container(
                width: double.maxFinite,
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            'Detaylar',
                            style: textTheme.bodyText2
                                ?.copyWith(color: Colors.white),
                          ),
                          backgroundColor: AppColor.customPurple,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Chip(
                          label: Text(
                            'Benzer Ürünler',
                            style: textTheme.bodyText2
                                ?.copyWith(color: Colors.white),
                          ),
                          backgroundColor: AppColor.customYellow,
                        ),
                      ],
                    ),
                    Text(
                      toy.description ?? '',
                      style: textTheme.bodyText2,
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    ));
  }
}

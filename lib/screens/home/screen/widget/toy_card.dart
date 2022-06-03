import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:swapy/core/extension/context_extension.dart';
import 'package:swapy/core/widget/button/custom_button.dart';
import 'package:swapy/screens/home/model/toy_model.dart';

class ToyCard extends StatelessWidget {
  final Toy toy;
  final VoidCallback onTap;
  final VoidCallback? swapDone;
  final bool showSwapDoneButton;

  const ToyCard(
      {Key? key,
      required this.toy,
      required this.onTap,
      this.swapDone,
      this.showSwapDoneButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CachedNetworkImage(
                imageUrl: toy.image ??
                    'https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-line-icon-vectors-png-image_1737850.jpg',
                //height: context.dynamicHeight(100),
                fit: BoxFit.contain,
              ),
              Text(toy.name ?? ''),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(toy
                                    .advertiserImage ??
                                'https://png.pngtree.com/png-vector/20190917/ourmid/pngtree-not-found-line-icon-vectors-png-image_1737850.jpg'))),
                  ),
                  SizedBox(width: 20),
                  Text(toy.advertiser ?? ''),
                ],
              ),
              if (showSwapDoneButton)
                ElevatedButton(
                    onPressed: swapDone,
                    child: Text(
                      'Takas Tamamlandı',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: Colors.white),
                    ))
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.refresh),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(Ionicons.chatbubble_ellipses_outline),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(Icons.favorite_border),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Icon(
                    Icons.monetization_on,
                    color: Colors.amber,
                  ),
                  Text(
                    toy.coin.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

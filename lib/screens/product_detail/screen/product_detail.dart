import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swapy/core/base/view/base_view.dart';
import 'package:swapy/core/constants/color/color.dart';
import 'package:swapy/core/constants/image/image_constants.dart';
import 'package:swapy/core/extension/context_extension.dart';
import 'package:swapy/core/extension/widget_extension.dart';
import 'package:swapy/core/widget/button/custom_button.dart';
import 'package:swapy/core/widget/button/custom_circle_button.dart';
import 'package:swapy/screens/home/model/toy_model.dart';
import 'package:swapy/screens/login/view_model/login_view_model.dart';
import 'package:swapy/screens/product_detail/view_model/product_detail_view_model.dart';

class ProductDetail extends StatelessWidget {
  final Toy toy;

  const ProductDetail({Key? key, required this.toy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ProductDetailViewModel>(
        vmBuilder: ProductDetailViewModel(toy), builder: _buildPage);
  }

  Widget _buildPage(BuildContext context, ProductDetailViewModel viewModel) {
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
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCircleButton(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      onTap: viewModel.navigateToBack,
                    ),
                    CustomCircleButton(
                      icon: Icons.lock,
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListTile(
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: toy.advertiserImage != null
                      ? DecorationImage(
                          image: NetworkImage(
                              toy.advertiserImage ?? ImageConstants.imageNotFound),
                        )
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
                for (var i = 0;
                    i <= 5 - (toy.advertiserRating?.ceil() ?? 0);
                    i++)
                  Icon(
                    Icons.star_border,
                    color: Colors.amber,
                  ),
                Text((toy.advertiserRating ?? 0).toString())
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.all(10),
            children: [
              Text(toy.name ?? '', style: textTheme.headline3),
              Card(
                child: Container(
                  width: double.maxFinite,
                  child: ListView(
                    padding: EdgeInsets.all(12),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
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
                            label: Row(
                              children: [
                                Text(
                                  'Benzer Ürünler',
                                  style: textTheme.bodyText2
                                      ?.copyWith(color: Colors.white),
                                ),
                                Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                  size: context.dynamicHeight(20),
                                )
                              ],
                            ),
                            backgroundColor: AppColor.customYellow,
                          ),
                        ],
                      ),
                      Text(
                        toy.description ?? '',
                        style: textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar:
          toy.advertiserId != LoginViewModel.instance.userInfo?.userUid
              ? CustomButton(
                  text: 'Teklif ver',
                  onTap: viewModel.giveOffer,
                  color: AppColor.customGreen,
                ).horizontalPadding()
              : null,
    );
  }
}

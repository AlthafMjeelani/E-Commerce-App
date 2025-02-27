import 'package:ecommerse/helpers/colors_widget.dart';
import 'package:ecommerse/helpers/spacing_widget.dart';
import 'package:ecommerse/helpers/text_style_widget.dart';
import 'package:ecommerse/screens/cart/controller/screen_cart_provider.dart';
import 'package:ecommerse/screens/productdetails/controller/screen_product_details_provider.dart';
import 'package:ecommerse/screens/wishlist/controller/screen_wishlist_provider.dart';
import 'package:ecommerse/utils/delete_items.dart';
import 'package:ecommerse/widget/no_itemfound_widget.dart';
import 'package:ecommerse/widget/shimmer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenWishlist extends StatelessWidget {
  const ScreenWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController =
        Provider.of<ScreenCartProvider>(context, listen: false);
    final wishlistController =
        Provider.of<ScreenWishlistProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      wishlistController.getAllWishlistProducts();
    });
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          wishlistController.getAllWishlistProducts();
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: AppColors.kBgColor,
          ),
          child: SafeArea(
            child: Consumer(
              builder: (context, ScreenWishlistProvider value, child) {
                return value.isLoading
                    ? Shimmerwidget(
                        itemBuilder: (BuildContext ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 170,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                        itemCount: 4,
                      )
                    : value.wishListProductElement.isEmpty
                        ? const CustomNotFoundWidget(
                            title: "You have't added any\nProduct yet",
                            subtitle: '')
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final wishListProduct =
                                      value.wishListProductElement[index];
                                  value.calculateOfferPrice(wishListProduct);
                                  return GestureDetector(
                                    onTap: () {
                                      value
                                          .calculateOfferPrice(wishListProduct);
                                      context
                                          .read<ScreenProductDetailsProvider>()
                                          .goToDetailsPage(
                                            wishlistController.offerPrice!
                                                .round()
                                                .toString(),
                                            wishListProduct.id!,
                                          );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Container(
                                              height: 150,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          wishListProduct
                                                                  .colors?[0]
                                                                  .images?[0] ??
                                                              ""),
                                                      fit: BoxFit.fill),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppSpacing.ksizedBox25,
                                              Text(
                                                wishListProduct.name ??
                                                    'No Name',
                                                style: AppTextStyle
                                                    .kTextBlack20Size,
                                              ),
                                              AppSpacing.ksizedBox5,
                                              SizedBox(
                                                width: 220,
                                                child: Text(
                                                  wishListProduct.description ??
                                                      'No description',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              AppSpacing.ksizedBox5,
                                              Text(
                                                'Size  :  ${wishListProduct.size?[0]}',
                                                style: AppTextStyle
                                                    .kTextBlack16Bold,
                                              ),
                                              AppSpacing.ksizedBox5,
                                              Text(
                                                '₹${value.offerPrice?.round().toString()}',
                                                style: AppTextStyle
                                                    .kTextBlack20Size,
                                              ),
                                              AppSpacing.ksizedBox5,
                                              SizedBox(
                                                  width: 220,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          cartController.addToCart(
                                                              wishListProduct.id
                                                                  .toString(),
                                                              wishListProduct
                                                                  .size![0],
                                                              wishListProduct
                                                                  .colors![0]
                                                                  .color!);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                          ),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            child: Text(
                                                              'ADD TO CART',
                                                              style: AppTextStyle
                                                                  .kTextBlack,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          value.deleteWishlistItem(
                                                              wishListProduct.id
                                                                  .toString());
                                                        },
                                                        child: const Icon(
                                                          CupertinoIcons
                                                              .heart_fill,
                                                          size: AppTextStyle
                                                              .kIconsize32,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              AppSpacing.ksizedBox5,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    thickness: 3,
                                    color: Colors.white,
                                  );
                                },
                                itemCount: value.wishListProductElement.length),
                          );
              },
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:npassignment/models/product_model.dart';
import 'package:npassignment/services/products_service.dart';
import 'package:npassignment/shared/app_theme_shared.dart';
import 'package:npassignment/shared/dialogs.dart';
import 'package:shimmer/shimmer.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  List<ProductsModel> allProducts = [];
  List<ProductsModel> tempList = [];
  List<ProductsModel> searchedList = [];
  bool searching = false;

  @override
  void initState() {
    fetchAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => DialogShared.doubleButtonDialog(
          context, "Are you sure you want to exit", () {
        SystemNavigator.pop();
      }, () {
        Navigator.pop(context);
      }),
      child: Scaffold(
          appBar: AppThemeShared.appBar(title: "Products", context: context),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: AppThemeShared.textFormField(
                  context: context,
                  hintText: 'Search Products',
                  suffixIcon: const Icon(Icons.search, color: Colors.black),
                  onChanged: (search) => searchProducts(search),
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                ),
              ),
              const SizedBox(height: 8),
              allProducts.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: allProducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }

                                Navigator.pushNamed(context, "/productDetails",
                                    arguments: allProducts[index]);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CachedNetworkImage(
                                          height: 150,
                                          width: 100,
                                          imageUrl: allProducts[index]
                                              .image
                                              .toString()),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 8),
                                            Text(
                                              allProducts[index]
                                                  .title
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(
                                                      fontSize: 16,
                                                      height: 1.2),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              allProducts[index]
                                                  .category
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline1!
                                                  .copyWith(fontSize: 16),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Text(
                                                  " ₹${allProducts[index].price! + 100.0} ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .copyWith(
                                                          fontSize: 18,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "₹" +
                                                      allProducts[index]
                                                          .price
                                                          .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .copyWith(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            RatingBar.builder(
                                              initialRating: allProducts[index]
                                                  .rating!
                                                  .rate!
                                                  .toDouble(),
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              glow: true,
                                              itemSize: 24,
                                              itemCount: 5,
                                              glowRadius: 6,
                                              unratedColor:
                                                  Colors.grey.withOpacity(0.6),
                                              ignoreGestures: true,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0.0),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {},
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : allProducts.isEmpty && !searching
                      ? Expanded(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: ListView.builder(
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 150,
                                        width: 150,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 15),
                                      Column(children: [
                                        Container(
                                          height: 20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              220,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(height: 12),
                                        Container(
                                          height: 20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              220,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(height: 12),
                                        Container(
                                          height: 20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              220,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(height: 12),
                                        Container(
                                          height: 20,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              220,
                                          color: Colors.black,
                                        ),
                                      ])
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Text(
                          "No Products Found",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 18),
                        )
            ],
          )),
    );
  }

  fetchAllProducts() async {
    allProducts = await ProductsService().getAllProducts();
    for (var element in allProducts) {
      tempList.add(element);
    }
    setState(() {});
  }

  searchProducts(String search) {
    if (search.isNotEmpty) {
      searchedList.clear();
      for (var element in tempList) {
        if (element.title
            .toString()
            .toLowerCase()
            .contains(search.toLowerCase())) {
          searchedList.add(element);
        }
      }
      setState(() {
        allProducts.clear();
        for (var element in searchedList) {
          allProducts.add(element);
        }
        searching = true;
      });
    } else {
      allProducts.clear();
      for (var element in tempList) {
        allProducts.add(element);
      }
      setState(() {
        searching = false;
      });
    }
  }
}

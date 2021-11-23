import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:npassignment/models/product_model.dart';
import 'package:npassignment/services/products_service.dart';
import 'package:npassignment/shared/app_theme_shared.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetails extends StatefulWidget {
  final ProductsModel? productsModel;

  const ProductDetails({Key? key, this.productsModel}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<ProductsModel> similarProductsList = [];
  bool favourite = false;
 

  @override
  void initState() {
    super.initState();
    similarProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppThemeShared.appBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: "Product Details",
          context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.width * 0.7,
                        imageUrl: widget.productsModel!.image.toString(),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              favourite = !favourite;
                            });
                          },
                          icon: Icon(
                            favourite
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: favourite ? Colors.red : Colors.grey[600]!,
                            size: 32,
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.productsModel!.title.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating:
                        widget.productsModel!.rating!.rate!.toDouble(),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    glow: true,
                    itemSize: 24,
                    itemCount: 5,
                    glowRadius: 6,
                    unratedColor: Colors.grey.withOpacity(0.6),
                    ignoreGestures: true,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  Text("(" +
                      widget.productsModel!.rating!.count.toString() +
                      " ratings)")
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    " ₹${widget.productsModel!.price! + 100.0} ",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 18, decoration: TextDecoration.lineThrough),
                  ),
                  Text(
                    " ₹${widget.productsModel!.price!} ",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              const Divider(
                color: Colors.grey,
                thickness: 1.5,
              ),
              Text(
                "Description",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                widget.productsModel!.description.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 14, height: 1.2),
              ),
              const SizedBox(height: 8),
              const Divider(
                color: Colors.grey,
                thickness: 1.5,
              ),
              const SizedBox(height: 8),
              AppThemeShared.argonButtonShared(
                context: context,
                height: 45,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xff74DFE7),
                buttonText: "Add To Cart",
                onTap: (p0, p1, p2) {},
              ),
              const SizedBox(height: 12),
              AppThemeShared.argonButtonShared(
                context: context,
                height: 45,
                width: MediaQuery.of(context).size.width,
                color: AppThemeShared.buttonColor,
                buttonText: "Buy Now",
                onTap: (p0, p1, p2) {},
              ),
              const SizedBox(height: 20),
              Text(
                "Similar Products",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 300,
                child: similarProductsList.isNotEmpty
                    ? ListView.builder(
                        itemCount: similarProductsList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return similarProductItem(index);
                        },
                      )
                    : similarProductsShimmer(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  similarProducts() async {
    List<ProductsModel> tempList = [];
    tempList = await ProductsService().getAllProducts();
    for (var product in tempList) {
      if (product.category == widget.productsModel!.category &&
          product.id != widget.productsModel!.id) {
        similarProductsList.add(product);
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  Widget similarProductItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, "/productDetails",
            arguments: similarProductsList[index]),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    width: 150,
                    height: 150,
                    imageUrl: similarProductsList[index].image.toString(),
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    similarProductsList[index].title.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 16, height: 1.2),
                  ),
                  const SizedBox(height: 8),
                  RatingBar.builder(
                    initialRating:
                        similarProductsList[index].rating!.rate!.toDouble(),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    glow: true,
                    itemSize: 20,
                    itemCount: 5,
                    glowRadius: 6,
                    unratedColor: Colors.grey.withOpacity(0.6),
                    ignoreGestures: true,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        " ₹${similarProductsList[index].price! + 100.0} ",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "₹" + similarProductsList[index].price.toString(),
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget similarProductsShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.black,
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 12),
                Container(
                  color: Colors.black,
                  height: 20,
                  width: 120,
                ),
                const SizedBox(height: 8),
                Container(
                  color: Colors.black,
                  height: 20,
                  width: 120,
                ),
                const SizedBox(height: 8),
                Container(
                  color: Colors.black,
                  height: 20,
                  width: 120,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      color: Colors.black,
                      height: 20,
                      width: 56,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      color: Colors.black,
                      height: 20,
                      width: 56,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

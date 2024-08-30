import 'dart:io';
import 'dart:ui' as ui;

import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import '../../controller/quotes_controller.dart';
import 'category_screen.dart';
import 'like_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () {
              if (controller.quoteList.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // liquidSwipe this make the slide wavy
              return LiquidSwipe.builder(
                liquidController: controller.liquidController,
                slideIconWidget: const Icon(Icons.arrow_back_outlined),
                fullTransitionValue: 300,
                enableSideReveal: false,
                preferDragFromRevealedArea: false,
                enableLoop: false,
                ignoreUserGestureWhileAnimating: true,
                itemCount: controller.quotes.length,
                itemBuilder: (context, index) {
                  //checking for the index is out bound or not

                  index = index % controller.quotes.length;
                  image = controller.initialImages.isNotEmpty &&
                          index < controller.initialImages.length
                      ? controller.initialImages[index]
                      : 'assets/img/love1.jpg';

                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(image),
                      ),
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.2,
                          ),
                          Text(
                            controller.quotes[index].category,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          Text(
                            controller.quotes[index].quote,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  '- ${controller.quotes[index].author}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog.fullscreen(
                                      backgroundColor: Colors.black,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: RepaintBoundary(
                                              key: repaintKey,
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(image),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .quotes[index].quote,
                                                      style: const TextStyle(
                                                        fontSize: 24,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    const SizedBox(height: 12),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10),
                                                          child: Text(
                                                            '- ${controller.quotes[index].author}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            textAlign:
                                                                TextAlign.right,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceAround,
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  RenderRepaintBoundary
                                                  boundary =
                                                  repaintKey
                                                      .currentContext!
                                                      .findRenderObject()
                                                  as RenderRepaintBoundary;

                                                  ui.Image image =
                                                  await boundary
                                                      .toImage();
                                                  ByteData? byteData =
                                                  await image.toByteData(
                                                      format: ui
                                                          .ImageByteFormat
                                                          .png);

                                                  Uint8List img =
                                                  byteData!.buffer
                                                      .asUint8List();

                                                  final imgPath =
                                                  await getApplicationDocumentsDirectory();
                                                  final file = File(
                                                      "${imgPath.path}/img.png");

                                                  file.writeAsBytes(
                                                      img);
                                                  ShareExtend.share(
                                                      file.path,
                                                      'image');
                                                },
                                                icon: const Icon(
                                                  Icons.share,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  RenderRepaintBoundary boundary = repaintKey
                                                      .currentContext!
                                                      .findRenderObject()
                                                  as RenderRepaintBoundary;

                                                  ui.Image image = await boundary.toImage();

                                                  ByteData? byteData = await image.toByteData(
                                                      format: ui.ImageByteFormat.png);

                                                  Uint8List img =
                                                  byteData!.buffer.asUint8List();

                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      behavior: SnackBarBehavior.floating,
                                                      margin: EdgeInsets.all(10),
                                                      content: Text('Saved to the gallery!'),
                                                    ),
                                                  );
                                                  ImageGallerySaver.saveImage(img);
                                                },
                                                icon: const Icon(
                                                  Icons.save_alt,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.ios_share,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              Obx(
                                () => IconButton(
                                  onPressed: () {
                                    // checking that quote exist before in list or not
                                    controller.checkFavouriteExistBefore(
                                        controller.quotes[index]);
                                    controller.toggleColorOfFavourite(index);
                                  },
                                  icon: (controller.quotes[index].isFavorite)
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 30,
                                        )
                                      : const Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  FlutterClipboard.copy(
                                      controller.quotes[index].quote);
                                  Get.snackbar(
                                      'Copied!', 'Quote copied to clipboard',
                                      snackPosition: SnackPosition.BOTTOM,
                                      colorText: CupertinoColors.white);
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            top: 40,
            left: 15,
            child: GestureDetector(
              onTap: () => categoryModalBottomSheet(context, controller),
              child: Container(
                height: height * 0.05,
                width: width * 0.32,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.5),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.category),
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 40,
            child: GestureDetector(
              onTap: () {
                Get.to(() => const LikedQuotesScreen(),
                    transition: Transition.rightToLeftWithFade);
              },
              child: Hero(
                tag: 'background',
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

var repaintKey = GlobalKey();
String image = '';
var controller = Get.put(QuotesController());

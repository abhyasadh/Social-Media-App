import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:yaallo/features/home/domain/entity/post_entity.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/themes/app_theme.dart';

class ImageSlider extends StatefulWidget {
  final PostEntity post;

  const ImageSlider({required this.post, super.key});

  @override
  State createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  double _imageHeight = 200.0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool isImage(String filename) {
    final extension = filename.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(extension);
  }

  Widget _buildImage({required String imageUrl, void Function()? onTap, String? urlTitle, String? urlDescription}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(color: AppTheme.primaryColor),
                  ),
                ),
                errorWidget: (context, url, error) => const SizedBox(
                  height: 200,
                  child: Center(child: Icon(Icons.error)),
                ),
                imageBuilder: (context, imageProvider) {
                  final listener = ImageStreamListener((info, _) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() {
                          _imageHeight =
                              constraints.maxWidth / info.image.width *
                                  info.image.height;
                        });
                      }
                    });
                  });

                  final stream = imageProvider.resolve(const ImageConfiguration());
                  stream.addListener(listener);

                  return Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    width: constraints.maxWidth,
                    height: _imageHeight,
                  );
                },
              );
            },
          ),
          if (urlTitle != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              child: Text(
                urlTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          if (urlDescription != null)
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, bottom: 12),
              child: Text(
                urlDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    if (widget.post.media == null || widget.post.media!.isEmpty) {
      return _buildImage(imageUrl: widget.post.urlimg!, onTap: () async {
        if (await canLaunchUrl(Uri.parse(widget.post.urlsel!))) {
          await launchUrl(Uri.parse(widget.post.urlsel!));
        } else {
          throw 'Could not launch ${widget.post.urlsel!}';
        }
      }, urlTitle: widget.post.urlti, urlDescription: widget.post.urldes);
    } else if (widget.post.media!.length == 1) {
      final media = widget.post.media!.first.filename!;
      if (isImage(media)) {
        return _buildImage(imageUrl: 'https://media.yaallo.com/upload/img/$media');
      }
    } else {
      return Column(
        children: [
          SizedBox(
            height: _imageHeight,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.post.media!.length,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                final media = widget.post.media![index].filename!;
                return _buildImage(imageUrl: 'https://media.yaallo.com/upload/img/$media');
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.post.media!.length, (index) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index ? const Color.fromRGBO(0, 0, 0, 0.9) : const Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }),
          ),
        ],
      );
    }
    return const Center(child: Text('Unsupported media format'));
  }
}

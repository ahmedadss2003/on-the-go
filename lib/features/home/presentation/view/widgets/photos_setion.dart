import 'dart:async';
import 'package:flutter/material.dart';
import 'package:on_the_go/features/home/data/models/image_model.dart';

class PhotoDisplaySection extends StatefulWidget {
  final List<ImageModel> imageUrls;
  const PhotoDisplaySection({super.key, required this.imageUrls});

  @override
  State<PhotoDisplaySection> createState() => _PhotoDisplaySectionState();
}

class _PhotoDisplaySectionState extends State<PhotoDisplaySection>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();

    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < widget.imageUrls.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _autoScrollTimer?.cancel();
    super.dispose();
  }

  void _goToPrevious() {
    if (_currentPage > 0) {
      _currentPage--;
    } else {
      _currentPage = widget.imageUrls.length - 1;
    }
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _goToNext() {
    if (_currentPage < widget.imageUrls.length - 1) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: EdgeInsets.all(width < 600 ? 5 : 0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: width < 1000 ? 400 : 700,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.imageUrls.length,
                  onPageChanged:
                      (index) => setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    return Hero(
                      tag: 'image_$index',
                      child: Image.network(
                        widget.imageUrls[index].url,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Navigation Buttons with enhanced styling
            Positioned(
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: _goToPrevious,
                ),
              ),
            ),

            Positioned(
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: _goToNext,
                ),
              ),
            ),

            // Dots indicator
            Positioned(
              bottom: 15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.imageUrls.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 8,
                    width: _currentPage == index ? 24 : 8,
                    decoration: BoxDecoration(
                      color:
                          _currentPage == index
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// List<String> imagesList = [
//   "https://c1.wallpaperflare.com/path/166/465/276/al-azhar-mosque-cairo-egypt-d6a7075b46189d7d3a681f835292206f.jpg",
//   "https://r4.wallpaperflare.com/wallpaper/750/820/6/hotel-room-reef-view-wallpaper-11cc7934f6b988d5688c076d31d9a34b.jpg",
//   "https://r4.wallpaperflare.com/wallpaper/595/361/169/pharaoh-egypt-cairo-museum-mask-of-tutankhamun-wallpaper-c980e86d61ca1d8bc697f8bf2091569d.jpg",
//   "https://c1.wallpaperflare.com/path/297/806/371/chair-golden-decorated-valuable-3c6f08827c7cdc73dd25fe7c9f430e05.jpg",
//   "https://r4.wallpaperflare.com/wallpaper/237/762/531/esna-temple-egypt-africa-wallpaper-f9c0188d312a2d6b26f7383f2011d6fd.jpg",
//   "https://r4.wallpaperflare.com/wallpaper/246/806/550/nature-landscape-desert-sand-wallpaper-8384d07c32485729ac2a6416852d3a5a.jpg",
//   "https://r4.wallpaperflare.com/wallpaper/656/149/266/egypt-egyptian-ancient-building-wallpaper-92218270fd56ae8b9af8b2e590e81922.jpg",
//   "https://r4.wallpaperflare.com/wallpaper/36/579/683/abu-simbel-egypt-sculpture-statue-wallpaper-9281b2e0ed966eabbae89235b0381932.jpg",
//   "https://r4.wallpaperflare.com/wallpaper/865/548/9/animals-color-coral-fishes-wallpaper-a9c028bd11daed7b2627e8df8051d6ed.jpg",
//   "https://r4.wallpaperflare.com/wallpaper/615/107/638/beach-sandy-beach-lagoon-tropical-landscape-wallpaper-88c64d8850f0dce870dc91aeb8e244ca.jpg",
//   "https://r4.wallpaperflare.com/wallpaper/371/373/249/nature-beach-sea-water-wallpaper-2920388dc13a7dab76e718ef60a1d6ad.jpg",
//   "https://r4.wallpaperflare.com/wallpaper/631/683/713/nature-bridge-sky-city-wallpaper-7980180df11add3bc617f84fb001566d.jpg",
//   "https://r4.wallpaperflare.com/wallpaper/529/70/359/sphynx-pyramid-egypt-old-building-wallpaper-8dd6fc2a5d3a7e546c9b8ae982673d57.jpg",
//   "https://r4.wallpaperflare.com/wallpaper/529/70/359/sphynx-pyramid-egypt-old-building-wallpaper-8dd6fc2a5d3a7e546c9b8ae982673d57.jpg",
// ];

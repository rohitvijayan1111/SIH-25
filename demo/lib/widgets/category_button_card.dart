// import 'package:flutter/material.dart';

// class CategoryButtonCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final IconData icon;
//   final Color backgroundColor;
//   final VoidCallback onTap;

//   const CategoryButtonCard({
//     Key? key,
//     required this.title,
//     required this.subtitle,
//     required this.icon,
//     required this.backgroundColor,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(16),
//           onTap: onTap,
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Icon container
//                 Container(
//                   width: 48,
//                   height: 48,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(icon, color: Colors.white, size: 24),
//                 ),
//                 const Spacer(),
//                 // Title
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 // Subtitle
//                 Text(
//                   subtitle,
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.8),
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//--------------------------------------------
//SECOND
// import 'package:flutter/material.dart';

// class CategoryButtonCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final IconData icon;
//   final Color backgroundColor;
//   final VoidCallback onTap;

//   const CategoryButtonCard({
//     Key? key,
//     required this.title,
//     required this.subtitle,
//     required this.icon,
//     required this.backgroundColor,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isSmallScreen = screenWidth < 380;
//     final isMediumScreen = screenWidth >= 380 && screenWidth < 600;

//     // Responsive sizing
//     final cardPadding = isSmallScreen ? 12.0 : (isMediumScreen ? 16.0 : 20.0);
//     final iconSize = isSmallScreen ? 20.0 : (isMediumScreen ? 24.0 : 28.0);
//     final iconContainerSize = isSmallScreen
//         ? 80.0
//         : (isMediumScreen ? 78.0 : 76.0);
//     final titleFontSize = isSmallScreen ? 14.0 : (isMediumScreen ? 16.0 : 18.0);
//     final subtitleFontSize = isSmallScreen
//         ? 10.0
//         : (isMediumScreen ? 12.0 : 13.0);
//     final borderRadius = isSmallScreen ? 12.0 : (isMediumScreen ? 16.0 : 20.0);

//     return Container(
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(borderRadius),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//           BoxShadow(
//             color: backgroundColor.withOpacity(0.3),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(borderRadius),
//           onTap: onTap,
//           splashColor: Colors.white.withOpacity(0.2),
//           highlightColor: Colors.white.withOpacity(0.1),
//           child: Container(
//             padding: EdgeInsets.all(cardPadding),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Icon container with responsive sizing
//                 Container(
//                   width: iconContainerSize,
//                   height: iconContainerSize,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.25),
//                     borderRadius: BorderRadius.circular(borderRadius * 0.6),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Icon(icon, color: Colors.white, size: iconSize),
//                 ),

//                 const Spacer(),

//                 // Title with responsive font size
//                 FittedBox(
//                   fit: BoxFit.scaleDown,
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: titleFontSize,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.5,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),

//                 SizedBox(height: isSmallScreen ? 2 : 4),

//                 // Subtitle with responsive font size
//                 FittedBox(
//                   fit: BoxFit.scaleDown,
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     subtitle,
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.85),
//                       fontSize: subtitleFontSize,
//                       fontWeight: FontWeight.w500,
//                       letterSpacing: 0.3,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//------------------------------------------

//THIRD
import 'package:flutter/material.dart';

class CategoryButtonCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  final String? imagePath;
  final String? imageUrl;
  final Color backgroundColor;
  final VoidCallback onTap;

  const CategoryButtonCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.icon,
    this.imagePath,
    this.imageUrl,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 380;
    final isMediumScreen = screenWidth >= 380 && screenWidth < 600;

    // Responsive sizing
    final cardPadding = isSmallScreen ? 12.0 : (isMediumScreen ? 16.0 : 20.0);
    final imageSize = isSmallScreen ? 100.0 : (isMediumScreen ? 90.0 : 90.0);
    final titleFontSize = isSmallScreen ? 14.0 : (isMediumScreen ? 16.0 : 18.0);
    final subtitleFontSize = isSmallScreen
        ? 10.0
        : (isMediumScreen ? 12.0 : 13.0);
    final borderRadius = isSmallScreen ? 12.0 : (isMediumScreen ? 16.0 : 20.0);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Container(
            padding: EdgeInsets.all(cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image/Icon at the top
                _buildTopImage(imageSize, borderRadius),

                const Spacer(),

                // Title with responsive font size
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                SizedBox(height: isSmallScreen ? 2 : 4),

                // Subtitle with responsive font size
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: subtitleFontSize,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopImage(double size, double borderRadius) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(borderRadius * 0.6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius * 0.6),
        child: _getImageWidget(size),
      ),
    );
  }

  Widget _getImageWidget(double size) {
    // Priority: imagePath > imageUrl > icon
    if (imagePath != null) {
      return Image.asset(
        imagePath!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackIcon(size);
        },
      );
    } else if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildLoadingWidget(size);
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackIcon(size);
        },
      );
    } else {
      return _buildFallbackIcon(size);
    }
  }

  Widget _buildFallbackIcon(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon ?? Icons.category,
        color: Colors.white,
        size: size * 0.4,
      ),
    );
  }

  Widget _buildLoadingWidget(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: SizedBox(
          width: size * 0.3,
          height: size * 0.3,
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
        ),
      ),
    );
  }
}

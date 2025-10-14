// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../controllers/app_controller.dart';
// import '../models/service_section.dart';
// import '../widgets/service_card.dart';
// import '../widgets/category_button_card.dart';

// class CategoriesScreen extends StatelessWidget {
//   const CategoriesScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Column(
//                 children: [
//                   // App logo/icon (you can add an icon here)
//                   Container(
//                     width: 200,
//                     height: 200,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child:
//                         // CircleAvatar(
//                         // child:
//                         Image.asset(
//                           'assets/logoABC.jpg',
//                           width: 100,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         ),
//                     // ),
//                   ),

//                   SizedBox(height: 8),

//                   // App Name with enhanced styling
//                   Text(
//                     'Agri Bharat Connect',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                       letterSpacing: 2,
//                     ),
//                   ),

//                   Text(
//                     'ABC',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.black.withOpacity(0.9),
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),

//                   SizedBox(height: 4),

//                   // Powered by section with enhanced design
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.15),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.3),
//                         width: 1,
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.verified_outlined,
//                               size: 16,
//                               color: Colors.black.withOpacity(0.9),
//                             ),
//                             SizedBox(width: 6),
//                             Text(
//                               'Powered by',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           'ONDC • Beckn Protocol',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         SizedBox(height: 2),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.security,
//                               size: 14,
//                               color: Colors.black.withOpacity(0.9),
//                             ),
//                             SizedBox(width: 4),
//                             Text(
//                               'Secured with Hyperledger Blockchain',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black.withOpacity(0.8),
//                                 fontStyle: FontStyle.italic,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               //   ServiceCard(
//               //     title: 'Upload Produce',
//               //     subtitle: 'Everyday Essentials',
//               //     icons: const [
//               //       Icons.upload,
//               //       Icons.local_shipping,
//               //       Icons.inventory_2,
//               //     ],
//               //     rightText: 'No min. order value',
//               //     gradient: const LinearGradient(
//               //       colors: [Color(0xFF9C27B0), Color(0xFFE91E63)],
//               //       begin: Alignment.topLeft,
//               //       end: Alignment.bottomRight,
//               //     ),
//               //     onTap: () {
//               //       context.read<AppController>().navigateToSection(
//               //         ServiceSection.uploadProduce,
//               //       );
//               //     },
//               //   ),
//               //   ServiceCard(
//               //     title: 'Browse Products',
//               //     subtitle: 'Fruits & Veggies',
//               //     icons: const [Icons.shopping_basket, Icons.eco],
//               //     rightText: 'Lowest prices',
//               //     gradient: const LinearGradient(
//               //       colors: [Color(0xFF2196F3), Color(0xFF03DAC6)],
//               //       begin: Alignment.topLeft,
//               //       end: Alignment.bottomRight,
//               //     ),
//               //     onTap: () {
//               //       context.read<AppController>().navigateToSection(
//               //         ServiceSection.browseProducts,
//               //       );
//               //     },
//               //   ),
//               //   ServiceCard(
//               //     title: 'Source and Sell',
//               //     subtitle: 'Buy and Sell produce',

//               //     icons: const [
//               //       Icons.handshake,
//               //       Icons.storefront,
//               //       Icons.inventory,
//               //     ],
//               //     rightText: 'Best quality guaranteed',
//               //     gradient: const LinearGradient(
//               //       colors: [Color(0xFF09203f), Color(0xFF537895)],

//               //       begin: Alignment.topLeft,
//               //       end: Alignment.bottomRight,
//               //     ),
//               //     onTap: () {
//               //       context.read<AppController>().navigateToSection(
//               //         ServiceSection.sourceAndSell,
//               //       );
//               //     },
//               //   ),
//               //   ServiceCard(
//               //     title: 'Farmer Services',
//               //     subtitle: 'Tools & Fertilizers',
//               //     icons: const [Icons.handyman, Icons.agriculture, Icons.store],
//               //     rightText: 'Best quality guaranteed',
//               //     gradient: const LinearGradient(
//               //       colors: [Color(0xFF006400), Color(0xFF228B22)],
//               //       begin: Alignment.topLeft,
//               //       end: Alignment.bottomRight,
//               //     ),
//               //     onTap: () {
//               //       context.read<AppController>().navigateToSection(
//               //         ServiceSection.farmerEssentials,
//               //       );
//               //     },
//               //   ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: GridView.count(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 0.85, // Adjust this for card proportions
//                     children: [
//                       CategoryButtonCard(
//                         title: 'Updated',
//                         subtitle: 'Latest news highlights',
//                         icon: Icons.newspaper,
//                         backgroundColor: const Color(0xFF6366F1), // Purple/Blue
//                         onTap: () {
//                           context.read<AppController>().navigateToSection(
//                             ServiceSection.uploadProduce,
//                           );
//                         },
//                       ),
//                       CategoryButtonCard(
//                         title: 'Politics',
//                         subtitle: 'Latest political news',
//                         icon: Icons.account_balance,
//                         backgroundColor: const Color(0xFFEC4899), // Pink
//                         onTap: () {
//                           context.read<AppController>().navigateToSection(
//                             ServiceSection.browseProducts,
//                           );
//                         },
//                       ),
//                       CategoryButtonCard(
//                         title: 'Technology',
//                         subtitle: 'Innovations and trends',
//                         icon: Icons.settings,
//                         backgroundColor: const Color(0xFF10B981), // Green
//                         onTap: () {
//                           context.read<AppController>().navigateToSection(
//                             ServiceSection.sourceAndSell,
//                           );
//                         },
//                       ),
//                       CategoryButtonCard(
//                         title: 'Sports',
//                         subtitle: 'Latest sports news',
//                         icon: Icons.sports_soccer,
//                         backgroundColor: const Color(0xFF3B82F6), // Blue
//                         onTap: () {
//                           context.read<AppController>().navigateToSection(
//                             ServiceSection.farmerEssentials,
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//SECOND

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../controllers/app_controller.dart';
// import '../models/service_section.dart';
// import '../widgets/category_button_card.dart';

// class CategoriesScreen extends StatelessWidget {
//   const CategoriesScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Compact Header
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () => Navigator.pop(context),
//                         child: Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade200,
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(Icons.arrow_back, size: 20),
//                         ),
//                       ),
//                       const Expanded(
//                         child: Center(
//                           child: Text(
//                             'The News',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 36),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   const Text(
//                     'Choose Categories',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     'Choose your favorite topics and personalize your news feed',
//                     style: TextStyle(fontSize: 14, color: Colors.grey),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),

//             // Grid Layout - NO Expanded here!
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: GridView.count(
//                 shrinkWrap:
//                     true, // Important: This allows the grid to size itself
//                 physics:
//                     const NeverScrollableScrollPhysics(), // Disable grid scrolling
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 childAspectRatio: 0.85,
//                 children: [
//                   CategoryButtonCard(
//                     title: 'Updated',
//                     subtitle: 'Latest news highlights',
//                     icon: Icons.newspaper,
//                     backgroundColor: const Color(0xFF6366F1),
//                     onTap: () {
//                       context.read<AppController>().navigateToSection(
//                         ServiceSection.uploadProduce,
//                       );
//                     },
//                   ),
//                   CategoryButtonCard(
//                     title: 'Politics',
//                     subtitle: 'Latest political news',
//                     icon: Icons.account_balance,
//                     backgroundColor: const Color(0xFFEC4899),
//                     onTap: () {
//                       context.read<AppController>().navigateToSection(
//                         ServiceSection.browseProducts,
//                       );
//                     },
//                   ),
//                   CategoryButtonCard(
//                     title: 'Technology',
//                     subtitle: 'Innovations and trends',
//                     icon: Icons.settings,
//                     backgroundColor: const Color(0xFF10B981),
//                     onTap: () {
//                       context.read<AppController>().navigateToSection(
//                         ServiceSection.sourceAndSell,
//                       );
//                     },
//                   ),
//                   CategoryButtonCard(
//                     title: 'Sports',
//                     subtitle: 'Latest sports news',
//                     icon: Icons.sports_soccer,
//                     backgroundColor: const Color(0xFF3B82F6),
//                     onTap: () {
//                       context.read<AppController>().navigateToSection(
//                         ServiceSection.farmerEssentials,
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             // Add some bottom spacing
//             const SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../controllers/app_controller.dart';
import '../models/service_section.dart';
import '../widgets/category_button_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenSize = mediaQuery.size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final isTablet = screenWidth > 600;
    final isSmallScreen = screenWidth < 380;

    // Responsive values
    final horizontalPadding = isSmallScreen ? 12.0 : (isTablet ? 24.0 : 16.0);
    final verticalPadding = isSmallScreen ? 12.0 : (isTablet ? 24.0 : 20.0);
    final crossAxisSpacing = isSmallScreen ? 12.0 : (isTablet ? 20.0 : 16.0);
    final mainAxisSpacing = isSmallScreen ? 12.0 : (isTablet ? 20.0 : 16.0);
    final gridAspectRatio = isLandscape ? 1.2 : (isTablet ? 1.0 : 0.85);
    final crossAxisCount = isLandscape && !isTablet ? 4 : 2;

    // Header responsive sizing
    final headerTitleSize = isSmallScreen ? 16.0 : (isTablet ? 20.0 : 18.0);
    final mainTitleSize = isSmallScreen ? 20.0 : (isTablet ? 28.0 : 24.0);
    final subtitleSize = isSmallScreen ? 12.0 : (isTablet ? 16.0 : 14.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;

            return Column(
              children: [
                // Responsive Header
                // Container(
                //   padding: EdgeInsets.symmetric(
                //     vertical: verticalPadding,
                //     horizontal: horizontalPadding,
                //   ),
                //   child: Column(
                //     children: [
                //       // Top navigation bar
                //       Row(
                //         children: [
                //           GestureDetector(
                //             onTap: () => Navigator.pop(context),
                //             child: Container(
                //               padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                //               decoration: BoxDecoration(
                //                 color: Colors.grey.shade200,
                //                 shape: BoxShape.circle,
                //                 boxShadow: [
                //                   BoxShadow(
                //                     color: Colors.black.withOpacity(0.1),
                //                     blurRadius: 4,
                //                     offset: const Offset(0, 2),
                //                   ),
                //                 ],
                //               ),
                //               child: Icon(
                //                 Icons.arrow_back,
                //                 size: isSmallScreen ? 18 : 20,
                //                 color: Colors.black87,
                //               ),
                //             ),
                //           ),
                //           Expanded(
                //             child: Center(
                //               child: Text(
                //                 'The News',
                //                 style: TextStyle(
                //                   fontSize: headerTitleSize,
                //                   fontWeight: FontWeight.w600,
                //                   color: Colors.black87,
                //                   letterSpacing: 0.5,
                //                 ),
                //               ),
                //             ),
                //           ),
                //           SizedBox(width: isSmallScreen ? 30 : 36),
                //         ],
                //       ),

                //       SizedBox(height: isLandscape ? 16 : 24),

                //       // Main title
                //       Text(
                //         'Choose Categories',
                //         style: TextStyle(
                //           fontSize: mainTitleSize,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.black87,
                //           letterSpacing: 0.5,
                //         ),
                //         textAlign: TextAlign.center,
                //       ),

                //       SizedBox(height: isLandscape ? 6 : 8),

                //       // Subtitle
                //       Padding(
                //         padding: EdgeInsets.symmetric(
                //           horizontal: isTablet ? 40 : 20,
                //         ),
                //         child: Text(
                //           'Choose your favorite topics and personalize your news feed',
                //           style: TextStyle(
                //             fontSize: subtitleSize,
                //             color: Colors.grey.shade600,
                //             height: 1.4,
                //             letterSpacing: 0.3,
                //           ),
                //           textAlign: TextAlign.center,
                //           maxLines: 2,
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child:
                      // CircleAvatar(
                      // child:
                      Image.asset(
                        'assets/logoABC.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                  // ),
                ),

                SizedBox(height: 8),

                // App Name with enhanced styling
                Text(
                  'Agri Bharat Connect',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 2,
                  ),
                ),

                Text(
                  'ABC',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 4),

                // Powered by section with enhanced design
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.verified_outlined,
                            size: 16,
                            color: Colors.black.withOpacity(0.9),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Powered by ONDC • Beckn Protocol',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      // Text(
                      //   'ONDC • Beckn Protocol',
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      // SizedBox(height: 2),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Icon(
                      //       Icons.security,
                      //       size: 14,
                      //       color: Colors.black.withOpacity(0.9),
                      //     ),
                      //     SizedBox(width: 4),
                      //     Text(
                      //       'Secured with Hyperledger Blockchain',
                      //       style: TextStyle(
                      //         fontSize: 14,
                      //         color: Colors.black.withOpacity(0.8),
                      //         fontStyle: FontStyle.italic,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),

                // Responsive Grid with perfect spacing
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: isTablet ? 800 : double.infinity,
                        ),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: crossAxisSpacing,
                          mainAxisSpacing: mainAxisSpacing,
                          childAspectRatio: gridAspectRatio,
                          padding: EdgeInsets.symmetric(
                            vertical: isLandscape ? 8 : 16,
                          ),
                          children: [
                            CategoryButtonCard(
                              title: 'Upload Produce',
                              subtitle: 'Latest news highlights',
                              icon: Icons.newspaper_rounded,
                              backgroundColor: Colors.green,
                              onTap: () {
                                _handleCategoryTap(
                                  context,
                                  ServiceSection.uploadProduce,
                                );
                              },
                            ),
                            CategoryButtonCard(
                              title: 'Browser Products',
                              subtitle: 'Latest political news',
                              icon: Icons.account_balance_rounded,
                              backgroundColor: Colors.orange,
                              onTap: () {
                                _handleCategoryTap(
                                  context,
                                  ServiceSection.browseProducts,
                                );
                              },
                            ),
                            CategoryButtonCard(
                              title: 'Source & Sell',
                              subtitle: 'Innovations and trends',
                              icon: Icons.settings_rounded,
                              backgroundColor: Colors.blue,
                              onTap: () {
                                _handleCategoryTap(
                                  context,
                                  ServiceSection.sourceAndSell,
                                );
                              },
                            ),
                            CategoryButtonCard(
                              title: 'Farmer Services',
                              subtitle: 'Latest sports news',
                              icon: Icons.sports_soccer_rounded,
                              backgroundColor: const Color(0xFF3B82F6),
                              onTap: () {
                                _handleCategoryTap(
                                  context,
                                  ServiceSection.farmerEssentials,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom safe area padding
                SizedBox(height: mediaQuery.padding.bottom > 0 ? 8 : 16),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleCategoryTap(BuildContext context, ServiceSection section) {
    // Add haptic feedback
    HapticFeedback.lightImpact();

    context.read<AppController>().navigateToSection(section);
  }
}

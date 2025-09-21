import 'package:flutter/material.dart';
import '../../utils/constantdata.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<IconData> icons;
  final String rightText;
  final Gradient gradient;
  final VoidCallback onTap;

  const ServiceCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icons,
    required this.rightText,
    required this.gradient,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding,
          vertical: AppConstants.smallPadding,
        ),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: AppConstants.subtitleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: AppConstants.captionFontSize,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: icons.map((icon) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 16,
                      ),
                    )).toList(),
                  ),
                  Text(
                    rightText,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: AppConstants.captionFontSize - 1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

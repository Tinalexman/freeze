import 'package:flutter/material.dart';

class PricingCard extends StatelessWidget {
  final String title;
  final String price;
  final String subtitle;
  final List<String> features;
  final Color color;
  final bool isPopular;

  const PricingCard({
    super.key,
    required this.title,
    required this.price,
    required this.subtitle,
    required this.features,
    required this.color,
    this.isPopular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPopular ? color : Colors.grey.withOpacity(0.3),
          width: isPopular ? 3 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isPopular
                ? color.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          if (isPopular)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Most Popular',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (isPopular) const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              if (price != '\$0')
                const Text(
                  '/month',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.check, color: color, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(feature, style: const TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Handle pricing selection
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$title plan selected!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isPopular ? color : Colors.transparent,
                foregroundColor: isPopular ? Colors.white : color,
                side: BorderSide(color: color),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                isPopular ? 'Get Started' : 'Choose Plan',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

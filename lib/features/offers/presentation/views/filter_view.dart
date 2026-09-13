// Refactored and optimized FilterScreen widget implementing smooth fluid animations, refined UI matching the design specifications, and clean code architecture.
import 'package:credora/core/utils/size_config.dart';
import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool isAndroidSelected = true;
  bool isDesktopSelected = true;
  String selectedCategory = "Featured Offers";
  String selectedSort = "Recommended";

  final List<String> categories = [
    "Featured Offers",
    "Surveys",
    "Gaming Offers",
    "Watch Videos",
    "Free Offers",
    "Mobile App Offers",
    "Free Trial Offers",
    "Sign Up Offers",
  ];

  final List<String> sortOptions = [
    'Recommended',
    'Easiest',
    'Newest',
    'Payout High to Low',
    'Payout Low to High',
    'Trending',
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: const BackButton(color: AppColors.text),
        title: const Text(
          "Discover & Filter",
          style: TextStyle(
            color: AppColors.text,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              setState(() {
                selectedCategory = "Featured Offers";
                selectedSort = "Recommended";
                isAndroidSelected = true;
                isDesktopSelected = true;
              });
            },
            icon: const Icon(
              Icons.refresh_rounded,
              color: AppColors.danger,
              size: 16,
            ),
            label: const Text(
              "Reset All",
              style: TextStyle(
                color: AppColors.danger,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          // 1. Search Specific Offers Section
          _buildFilterSection(
            title: "Search",
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.surfaceSoft,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: const TextField(
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: "Search specific offers...",
                  hintStyle: TextStyle(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(Icons.search, color: AppColors.textMuted),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 2. Target Device Cards Section
          _buildFilterSection(
            title: "Target Device",
            child: Row(
              children: [
                Expanded(
                  child: _buildDeviceCard(
                    title: "Android",
                    icon: Icons.android_rounded,
                    isSelected: isAndroidSelected,
                    onTap: () {
                      setState(() {
                        if (isAndroidSelected && isDesktopSelected) {
                          isAndroidSelected = false;
                        } else {
                          isAndroidSelected = !isAndroidSelected;
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDeviceCard(
                    title: "Desktop",
                    icon: Icons.computer_rounded,
                    isSelected: isDesktopSelected,
                    onTap: () {
                      setState(() {
                        if (isAndroidSelected && isDesktopSelected) {
                          isDesktopSelected = false;
                        } else {
                          isDesktopSelected = !isDesktopSelected;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 3. Sort Order Chip Wrap Section
          _buildFilterSection(
            title: "Sort Order",
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  sortOptions.map((option) {
                    final isSelected = selectedSort == option;
                    return AnimatedScale(
                      scale: isSelected ? 1.02 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        child: ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isSelected) ...[
                                const Icon(
                                  Icons.check,
                                  size: 14,
                                  color: AppColors.onPrimary,
                                ),
                                const SizedBox(width: 6),
                              ],
                              Text(option),
                            ],
                          ),
                          selected: isSelected,
                          selectedColor: AppColors.primary,
                          backgroundColor: AppColors.surfaceSoft,
                          labelStyle: TextStyle(
                            color:
                                isSelected
                                    ? AppColors.onPrimary
                                    : AppColors.text,
                            fontWeight:
                                isSelected ? FontWeight.w800 : FontWeight.w600,
                            fontSize: 13,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color:
                                  isSelected
                                      ? AppColors.primary
                                      : AppColors.border,
                            ),
                          ),
                          onSelected: (_) {
                            setState(() {
                              selectedSort = option;
                            });
                          },
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
          const SizedBox(height: 20),

          // 4. Offer Categories Selectable List
          _buildFilterSection(
            title: "Offer Categories",
            child: Column(
              children:
                  categories.map((category) {
                    final isSelected = selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOutCubic,
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? AppColors.primary.withValues(alpha: 0.08)
                                  : AppColors.surfaceSoft,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color:
                                isSelected
                                    ? AppColors.primary
                                    : AppColors.border,
                            width: isSelected ? 1.5 : 1.0,
                          ),
                          boxShadow:
                              isSelected
                                  ? [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.12,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                  : [],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              child: Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color:
                                          isSelected
                                              ? AppColors.primary
                                              : Colors.transparent,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color:
                                            isSelected
                                                ? AppColors.primary
                                                : AppColors.textMuted,
                                        width: 1.5,
                                      ),
                                    ),
                                    child:
                                        isSelected
                                            ? const Icon(
                                              Icons.check,
                                              size: 14,
                                              color: AppColors.onPrimary,
                                            )
                                            : null,
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Text(
                                      category,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight:
                                            isSelected
                                                ? FontWeight.w900
                                                : FontWeight.w700,
                                        color:
                                            isSelected
                                                ? AppColors.primary
                                                : AppColors.text,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // 5. Apply Filters Action Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 3,
                shadowColor: AppColors.primary.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                "Apply Filters",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: AppColors.onPrimary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }

  Widget _buildDeviceCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      height: 95,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
        ),
        boxShadow:
            isSelected
                ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
                : [],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.onPrimary : AppColors.text,
                size: 28,
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? AppColors.onPrimary : AppColors.text,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

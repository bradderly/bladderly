import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/menu/about/about_modal.dart';
import 'package:bradderly/presentation/feature/menu/contactus/contactus_modal.dart';
import 'package:bradderly/presentation/feature/menu/howtouse/howtouse_view.dart';
import 'package:bradderly/presentation/feature/menu/plan/plan_main_modal.dart';
import 'package:bradderly/presentation/feature/menu/profile/user_profile_modal.dart';
import 'package:bradderly/presentation/feature/menu/symptom/symptom_modal.dart';
import 'package:bradderly/presentation/router/route/menu_tap_route.dart';
import 'package:bradderly/presentation/router/route/onboarding_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  String selectedUnit = "ml"; // 초기 선택 값

  void toggleUnit(String unit) {
    setState(() {
      selectedUnit = unit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: context.colorTheme.neutral.shade2,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Menu'.tr(context),
                        style: context.textStyleTheme.b24BoldOutfit.copyWith(
                            color: context.colorTheme.neutral.shade10),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: context.colorTheme.neutral.shade8,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                SettingsSection(
                  title: "Profile".tr(context),
                  items: [
                    SettingsItem(
                      icon: Icons.person,
                      title: "User Profile".tr(context),
                      onTap: () {
                        //   const MenuTapRoute().go(context);
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return UserProfileModal();
                          },
                        );
                      },
                    ),
                  ],
                ),
                SettingsSection(
                  title: "General".tr(context),
                  items: [
                    SettingsItem(
                        icon: Icons.credit_card,
                        title: "Plan".tr(context),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return PlanMainModal();
                            },
                          );
                        }),
                    SettingsItem(
                        icon: Icons.bar_chart,
                        title: "Symptom score".tr(context),
                        onTap: () {
                           showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return SymptomModal();
                          },
                        );
                        }),
                    SettingsItem(
                        icon: Icons.help_outline,
                        title: "How to use".tr(context),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HowtouseView()),
                          );
                        }),
                    SettingsItem(
                        icon: Icons.phone,
                        title: "Contact Us".tr(context),
                        onTap: () {
                           showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return ContactusModal();
                          },
                        );
                        }),
                    SettingsItem(
                        icon: Icons.info_outline,
                        title: "About".tr(context),
                        onTap: () {
                           showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return AboutModal();
                          },
                        );
                        }),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 17, bottom: 16),
                  child: Text(
                    "Unit setting".tr(context),
                    style: context.textStyleTheme.b20Bold.copyWith(
                      color: context.colorTheme.neutral.shade10,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: _buildButton("ml", selectedUnit == "ml")),
                    const SizedBox(width: 8), // 버튼 간 간격
                    Expanded(child: _buildButton("oz", selectedUnit == "oz")),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    const SigninRoute().go(context);
                  },
                  child: Container(
                    width: 256,
                    height: 43,
                    margin: const EdgeInsets.only(top: 85, bottom: 28),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context
                          .colorTheme.vermilion.primary.shade50, // 선택된 버튼 색상
                      borderRadius: BorderRadius.circular(12), // 둥근 모서리
                    ),
                    child: Text(
                      "Sign out".tr(context),
                      style: context.textStyleTheme.b16SemiBold.copyWith(
                        color: context.colorTheme.neutral.shade0, // 텍스트 색상
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String unit, bool isSelected) {
    return GestureDetector(
      onTap: () => toggleUnit(unit),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        height: 43,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? context.colorTheme.vermilion.primary.shade50
              : context.colorTheme.neutral.shade4, // 선택된 버튼 색상
          borderRadius: BorderRadius.circular(12), // 둥근 모서리
        ),
        child: Text(
          unit,
          style: context.textStyleTheme.b16SemiBold.copyWith(
            color: isSelected
                ? context.colorTheme.neutral.shade0
                : context.colorTheme.neutral.shade10, // 텍스트 색상
          ),
        ),
      ),
    );
  }
}

// Profile, General, Unit setting 섹션을 표시하는 위젯
class SettingsSection extends StatelessWidget {
  final String title;
  final List<SettingsItem> items;

  const SettingsSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 17, bottom: 8),
          child: Text(
            title,
            style: context.textStyleTheme.b20Bold.copyWith(
              color: context.colorTheme.neutral.shade10,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: items,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.colorTheme.neutral.shade0,
          boxShadow: [],
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: context.colorTheme.neutral.shade10),
            const SizedBox(width: 12), // 아이콘과 텍스트 간격
            Expanded(
              // 🔥 이걸 추가하면 무한 너비 문제 해결
              child: Text(
                title,
                style: context.textStyleTheme.b16Medium.copyWith(
                  color: context.colorTheme.neutral.shade10,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: 16, color: context.colorTheme.neutral.shade10), // 우측 화살표
          ],
        ),
      ),
    );
  }
}

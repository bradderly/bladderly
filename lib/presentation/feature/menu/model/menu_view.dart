import 'package:bradderly/presentation/common/extension/app_theme_extension.dart';
import 'package:bradderly/presentation/common/extension/string_extension.dart';
import 'package:bradderly/presentation/feature/menu/about/about_modal.dart';
import 'package:bradderly/presentation/feature/menu/contactus/contactus_modal.dart';
import 'package:bradderly/presentation/feature/menu/faq/faq_view_modal.dart';
import 'package:bradderly/presentation/feature/menu/howtouse/howtouse_view.dart';
import 'package:bradderly/presentation/feature/menu/language/language_view_modal.dart';
import 'package:bradderly/presentation/feature/menu/plan/plan_main_modal.dart';
import 'package:bradderly/presentation/feature/menu/profile/user_profile_modal.dart';
import 'package:bradderly/presentation/feature/menu/symptom/symptom_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  String selectedUnit = 'ml'; // 초기 선택 값

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
            child: SingleChildScrollView(
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
                            color: context.colorTheme.neutral.shade10,
                          ),
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
                    title: 'Profile'.tr(context),
                    items: [
                      SettingsItem(
                        icon: Icons.person_outline,
                        title: 'User Profile'.tr(context),
                        onTap: () {
                          // ignore: inference_failure_on_function_invocation
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return const UserProfileModal();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: 'General'.tr(context),
                    items: [
                      SettingsItem(
                        icon: Icons.credit_card,
                        title: 'Plan'.tr(context),
                        onTap: () {
                          // ignore: inference_failure_on_function_invocation
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return const PlanMainModal();
                            },
                          );
                        },
                      ),
                      SettingsItem(
                        icon: Icons.ios_share,
                        title: 'Data export'.tr(context),
                        onTap: () {
                          // ignore: inference_failure_on_function_invocation
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return const SymptomModal();
                            },
                          );
                        },
                      ),
                      SettingsItem(
                        icon: Icons.bar_chart,
                        title: 'Symptom score'.tr(context),
                        onTap: () {
                          // ignore: inference_failure_on_function_invocation
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return const SymptomModal();
                            },
                          );
                        },
                      ),
                      SettingsItem(
                        icon: Icons.language,
                        title: 'Language'.tr(context),
                        subtitle: 'English (United States)'.tr(context),
                        onTap: () {
                          // ignore: inference_failure_on_function_invocation
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return const LanguageViewModal();
                            },
                          );
                        },
                      ),
                      SettingsItem(
                        icon: Icons.help_outline,
                        title: 'FAQ'.tr(context),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return const FaqViewModal();
                            },
                          );
                        },
                      ),
                      SettingsItem(
                        icon: Icons.phone,
                        title: 'Contact Us'.tr(context),
                        onTap: () {
                          // ignore: inference_failure_on_function_invocation
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return const ContactusModal();
                            },
                          );
                        },
                      ),
                      SettingsItem(
                        icon: Icons.info_outline,
                        title: 'About'.tr(context),
                        onTap: () {
                          // ignore: inference_failure_on_function_invocation
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return const AboutModal();
                            },
                          );
                        },
                      ),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'App Version'.tr(context),
                                    style: context.textStyleTheme.b16Regular.copyWith(
                                      color: context.colorTheme.neutral.shade10,
                                    ),
                                  ),
                                  Text(
                                    'Lastest : 2025.01',
                                    style: context.textStyleTheme.b12Medium.copyWith(
                                      color: context.colorTheme.neutral.shade7,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '3.1.0',
                              style: context.textStyleTheme.b14Medium
                                  .copyWith(color: context.colorTheme.vermilion.primary.shade50),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 20, bottom: 16),
                    child: Text(
                      'Unit setting'.tr(context),
                      style: context.textStyleTheme.b20Bold.copyWith(
                        color: context.colorTheme.neutral.shade10,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: _buildButton('ml', selectedUnit == 'ml')),
                      const SizedBox(width: 8), // 버튼 간 간격
                      Expanded(child: _buildButton('oz', selectedUnit == 'oz')),
                    ],
                  ),
                  const SizedBox(height: 4),
                ],
              ),
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
              ? context.colorTheme.vermilion.secondary.shade10
              : context.colorTheme.neutral.shade4, // 선택된 버튼 색상
          borderRadius: BorderRadius.circular(12), // 둥근 모서리
          border: Border.all(
            color: isSelected ? context.colorTheme.vermilion.secondary.shade20 : Colors.transparent, // 선택된 버튼 테두리 색상
            width: 3, // 테두리 두께
          ),
        ),
        child: Text(
          unit,
          style: context.textStyleTheme.b16SemiBold.copyWith(
            color:
                isSelected ? context.colorTheme.vermilion.primary.shade50 : context.colorTheme.neutral.shade6, // 텍스트 색상
          ),
        ),
      ),
    );
  }
}

// Profile, General, Unit setting 섹션을 표시하는 위젯
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.items,
  });
  final String title;
  final List<Widget> items;

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
            elevation: 0, // 그림자 제거
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: context.colorTheme.neutral.shade0,
              ),
              child: Column(
                children: items,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle = '',
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 24, color: context.colorTheme.neutral.shade10),
            const SizedBox(width: 12), // 아이콘과 텍스트 간격
            Expanded(
              // 🔥 이걸 추가하면 무한 너비 문제 해결
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: context.textStyleTheme.b16Regular.copyWith(
                      color: context.colorTheme.neutral.shade10,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: context.textStyleTheme.b14Medium.copyWith(
                      color: context.colorTheme.neutral.shade7,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: context.colorTheme.neutral.shade10,
              ),
            ), // 우측 화살표
          ],
        ),
      ),
    );
  }
}

// Dart imports:
// Flutter imports:
// Project imports:
import 'dart:async';

import 'package:bladderly/core/network_checker/network_checker.dart';
import 'package:bladderly/domain/model/unit.dart';
import 'package:bladderly/presentation/common/bloc/app_config_bloc.dart';
import 'package:bladderly/presentation/common/cubit/locale_cubit.dart';
import 'package:bladderly/presentation/common/cubit/unit_cubit.dart';
import 'package:bladderly/presentation/common/extension/build_context_extension.dart';
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/locale/app_locale.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:bladderly/presentation/router/route/about_route.dart';
import 'package:bladderly/presentation/router/route/export_route.dart';
import 'package:bladderly/presentation/router/route/main_route.dart';
import 'package:bladderly/presentation/router/route/payment_route.dart';
import 'package:bladderly/presentation/router/route/profile_route.dart';
import 'package:bladderly/presentation/router/route/symptom_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key, required this.networkChecker});
  final NetworkChecker networkChecker;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: ModalAppBar(
          backgroundColor: context.colorTheme.neutral.shade2,
          title: 'Menu'.tr(context),
          titleStyle: context.textStyleTheme.b24Bold.copyWith(
            color: context.colorTheme.neutral.shade10,
          ),
          toolbarHeight: 69,
          centerTitle: false,
        ),
        backgroundColor: context.colorTheme.neutral.shade2,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SettingsSection(
                    title: 'Profile'.tr(context),
                    items: [
                      SettingsItem(
                        icon: Icons.person_outline,
                        title: 'User Profile'.tr(context),
                        onTap: () => const ProfileRoute().go(context),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: 'General'.tr(context),
                    items: [
                      SettingsItem(
                        icon: Icons.credit_card,
                        title: 'Plan'.tr(context),
                        onTap: () => const PlanRoute().go(context),
                      ),
                      SettingsItem(
                        onTap: () => const ExportCalendarRoute().push<void>(context),
                        icon: Icons.ios_share,
                        title: 'Data export'.tr(context),
                      ),
                      SettingsItem(
                        onTap: () => const SymptomScoresRoute().go(context),
                        icon: Icons.bar_chart,
                        title: 'Symptom score'.tr(context),
                      ),
                      SettingsItem(
                        onTap: () async {
                          final originLocale = context.read<AppLocaleCubit>().state;

                          final newLocale = await LanguageRoute(originLocale: originLocale).push<AppLocale>(context);

                          if (context.mounted && newLocale != null) {
                            context.read<AppLocaleCubit>().changeLocale(newLocale);
                          }
                        },
                        icon: Icons.language,
                        title: 'Language'.tr(context),
                        subtitle: context.locale.text,
                      ),
                      SettingsItem(
                        icon: Icons.help_outline,
                        title: 'FAQ'.tr(context),
                        onTap: () => const FaqRoute().go(context),
                      ),
                      SettingsItem(
                        icon: Icons.phone,
                        title: 'Contact Us'.tr(context),
                        onTap: () async {
                          final isConnected = await networkChecker.isConnected;

                          if (!context.mounted) return;

                          if (!isConnected) {
                            unawaited(networkChecker.showNetworkAlert(context));
                          } else {
                            const ContactUsRoute().go(context);
                          }
                        },
                      ),
                      SettingsItem(
                        icon: Icons.info_outline,
                        title: 'About'.tr(context),
                        onTap: () => const AboutRoute().go(context),
                      ),
                      BlocBuilder<AppConfigBloc, AppConfigState>(
                        builder: (context, state) => Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'App version'.tr(context),
                                      style: context.textStyleTheme.b16Regular.copyWith(
                                        color: context.colorTheme.neutral.shade10,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(text: 'Latest :'.tr(context)),
                                          const TextSpan(text: ' '),
                                          TextSpan(text: state.updatedDate),
                                        ],
                                        style: context.textStyleTheme.b12Medium
                                            .copyWith(color: context.colorTheme.neutral.shade7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '${state.currentVersion} (${state.currentBuild})',
                                style: context.textStyleTheme.b14Medium
                                    .copyWith(color: context.colorTheme.vermilion.primary.shade50),
                              ),
                            ],
                          ),
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
                  BlocBuilder<UnitCubit, Unit>(
                    builder: (context, state) {
                      final unit = state.name;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                context.read<UnitCubit>().change(Unit.ml);
                              }, //toggleUnit(unit),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: unit == 'ml'
                                      ? context.colorTheme.vermilion.secondary.shade10
                                      : context.colorTheme.neutral.shade4, // 선택된 버튼 색상
                                  borderRadius: BorderRadius.circular(12), // 둥근 모서리
                                  border: Border.all(
                                    color: unit == 'ml'
                                        ? context.colorTheme.vermilion.secondary.shade20
                                        : Colors.transparent, // 선택된 버튼 테두리 색상
                                    width: 3, // 테두리 두께
                                  ),
                                ),
                                child: Text(
                                  'ml',
                                  style: context.textStyleTheme.b16SemiBold.copyWith(
                                    color: unit == 'ml'
                                        ? context.colorTheme.vermilion.primary.shade50
                                        : context.colorTheme.neutral.shade6, // 텍스트 색상
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () => context.read<UnitCubit>().change(Unit.oz),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: unit == 'oz'
                                      ? context.colorTheme.vermilion.secondary.shade10
                                      : context.colorTheme.neutral.shade4, // 선택된 버튼 색상
                                  borderRadius: BorderRadius.circular(12), // 둥근 모서리
                                  border: Border.all(
                                    color: unit == 'oz'
                                        ? context.colorTheme.vermilion.secondary.shade20
                                        : Colors.transparent, // 선택된 버튼 테두리 색상
                                    width: 3,
                                  ),
                                ),
                                child: Text(
                                  'oz',
                                  style: context.textStyleTheme.b16SemiBold.copyWith(
                                    color: unit == 'oz'
                                        ? context.colorTheme.vermilion.primary.shade50
                                        : context.colorTheme.neutral.shade6, // 텍스트 색상
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 24, color: context.colorTheme.neutral.shade10),
            const SizedBox(width: 12),
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

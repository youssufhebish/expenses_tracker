// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `إضافة مصروف`
  String get addExpense {
    return Intl.message(
      'إضافة مصروف',
      name: 'addExpense',
      desc: 'Title for the add expense screen',
      args: [],
    );
  }

  /// `حفظ المصروف`
  String get saveExpense {
    return Intl.message(
      'حفظ المصروف',
      name: 'saveExpense',
      desc: 'Button text to save an expense',
      args: [],
    );
  }

  /// `حفظ`
  String get save {
    return Intl.message(
      'حفظ',
      name: 'save',
      desc: 'Generic save button text',
      args: [],
    );
  }

  /// `إعادة المحاولة`
  String get retry {
    return Intl.message(
      'إعادة المحاولة',
      name: 'retry',
      desc: 'Button text to retry an action',
      args: [],
    );
  }

  /// `دخل`
  String get income {
    return Intl.message(
      'دخل',
      name: 'income',
      desc: 'Label for income transactions',
      args: [],
    );
  }

  /// `مصروف`
  String get expense {
    return Intl.message(
      'مصروف',
      name: 'expense',
      desc: 'Label for expense transactions',
      args: [],
    );
  }

  /// `أدخل المبلغ`
  String get enterAmount {
    return Intl.message(
      'أدخل المبلغ',
      name: 'enterAmount',
      desc: 'Hint text for amount input field',
      args: [],
    );
  }

  /// `اختر التاريخ`
  String get selectDate {
    return Intl.message(
      'اختر التاريخ',
      name: 'selectDate',
      desc: 'Hint text for date selection field',
      args: [],
    );
  }

  /// `رفع صورة`
  String get uploadImage {
    return Intl.message(
      'رفع صورة',
      name: 'uploadImage',
      desc: 'Hint text for image upload field',
      args: [],
    );
  }

  /// `يرجى اختيار فئة`
  String get pleaseSelectCategory {
    return Intl.message(
      'يرجى اختيار فئة',
      name: 'pleaseSelectCategory',
      desc: 'Error message when no category is selected',
      args: [],
    );
  }

  /// `تم إضافة المصروف بنجاح`
  String get expenseAddedSuccessfully {
    return Intl.message(
      'تم إضافة المصروف بنجاح',
      name: 'expenseAddedSuccessfully',
      desc: 'Success message when expense is added',
      args: [],
    );
  }

  /// `فشل في إضافة المصروف. يرجى المحاولة مرة أخرى.`
  String get failedToAddExpense {
    return Intl.message(
      'فشل في إضافة المصروف. يرجى المحاولة مرة أخرى.',
      name: 'failedToAddExpense',
      desc: 'Error message when expense addition fails',
      args: [],
    );
  }

  /// `فشل في حفظ الإيصال. يرجى المحاولة مرة أخرى.`
  String get failedToSaveReceipt {
    return Intl.message(
      'فشل في حفظ الإيصال. يرجى المحاولة مرة أخرى.',
      name: 'failedToSaveReceipt',
      desc: 'Error message when receipt saving fails',
      args: [],
    );
  }

  /// `فشل في تحميل المصروفات`
  String get failedToLoadExpenses {
    return Intl.message(
      'فشل في تحميل المصروفات',
      name: 'failedToLoadExpenses',
      desc: 'Error message when expenses loading fails',
      args: [],
    );
  }

  /// `طعام`
  String get categoryFood {
    return Intl.message(
      'طعام',
      name: 'categoryFood',
      desc: 'Food category name',
      args: [],
    );
  }

  /// `مواصلات`
  String get categoryTransport {
    return Intl.message(
      'مواصلات',
      name: 'categoryTransport',
      desc: 'Transport category name',
      args: [],
    );
  }

  /// `تسوق`
  String get categoryShopping {
    return Intl.message(
      'تسوق',
      name: 'categoryShopping',
      desc: 'Shopping category name',
      args: [],
    );
  }

  /// `ترفيه`
  String get categoryEntertainment {
    return Intl.message(
      'ترفيه',
      name: 'categoryEntertainment',
      desc: 'Entertainment category name',
      args: [],
    );
  }

  /// `صحة`
  String get categoryHealth {
    return Intl.message(
      'صحة',
      name: 'categoryHealth',
      desc: 'Health category name',
      args: [],
    );
  }

  /// `تعليم`
  String get categoryEducation {
    return Intl.message(
      'تعليم',
      name: 'categoryEducation',
      desc: 'Education category name',
      args: [],
    );
  }

  /// `أخرى`
  String get categoryOther {
    return Intl.message(
      'أخرى',
      name: 'categoryOther',
      desc: 'Other category name',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

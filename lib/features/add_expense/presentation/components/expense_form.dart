import 'package:expenses_tracker_lite/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/themes/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../widgets/custom_text_field.dart';
import 'category_grid.dart';

/// Form component for expense/income input fields
/// Contains amount, date, receipt, and category selection fields
class ExpenseForm extends StatelessWidget {
  /// Controller for the amount input field
  final TextEditingController amountController;

  /// Controller for the date input field
  final TextEditingController dateController;

  /// Controller for the receipt input field
  final TextEditingController receiptController;

  /// Currently selected category from the grid
  final String? selectedGridCategory;

  /// Whether this is for income (true) or expense (false)
  final bool isIncome;

  /// Currently selected currency
  final String? selectedCurrency;

  /// List of available currencies
  final List<String> availableCurrencies;

  /// Whether currency rates are loading
  final bool isLoadingCurrencies;

  /// Callback when a category is selected from the grid
  final ValueChanged<ExpenseCategory> onCategorySelected;

  /// Callback when date field is tapped
  final VoidCallback onDateTap;

  /// Callback when receipt field is tapped
  final VoidCallback onReceiptTap;

  /// Callback when currency is changed
  final ValueChanged<String?> onCurrencyChanged;

  /// Current currency conversion rate
  final double currencyRate;

  /// Callback to load currency rates
  final VoidCallback onLoadCurrencies;

  /// Callback when amount value changes
  final ValueChanged<String>? onAmountChanged;

  const ExpenseForm({
    super.key,
    required this.amountController,
    required this.dateController,
    required this.receiptController,
    required this.selectedGridCategory,
    required this.isIncome,
    required this.selectedCurrency,
    required this.availableCurrencies,
    required this.isLoadingCurrencies,
    required this.onCategorySelected,
    required this.onDateTap,
    required this.onReceiptTap,
    required this.onCurrencyChanged,
    this.currencyRate = 1.0,
    required this.onLoadCurrencies,
    this.onAmountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        // Amount input field with currency dropdown
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 12,
              children: [
                // Amount input field
                Expanded(
                  flex: 2,
                  child: CustomTextField(
                    controller: amountController,
                    label: 'Amount',
                    hintText: AppLocalizations.current.enterAmount,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: onAmountChanged,
                  ),
                ),
                // Currency dropdown
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Currency',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(

                          border: Border.all(
                            color: AppColors.lightDivider,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: isLoadingCurrencies
                            ? const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: AppLoader(),
                                ),
                              )
                            : DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedCurrency,
                                  hint: const Text(
                                    'USD',
                                    style: TextStyle(
                                      color: AppColors.lightTextSecondary,
                                      fontSize: 14,
                                    ),
                                  ),
                                  isExpanded: true,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.lightTextSecondary,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  items: availableCurrencies.isEmpty
                                      ? ['USD', 'EUR', 'GBP', 'JPY', 'CAD']
                                            .map(
                                              (currency) =>
                                                  DropdownMenuItem<String>(
                                                    value: currency,
                                                    child: Text(
                                                      currency,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: AppColors
                                                            .lightTextPrimary,
                                                      ),
                                                    ),
                                                  ),
                                            )
                                            .toList()
                                      : availableCurrencies
                                            .map(
                                              (currency) =>
                                                  DropdownMenuItem<String>(
                                                    value: currency,
                                                    child: Text(
                                                      currency,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: AppColors
                                                            .lightTextPrimary,
                                                      ),
                                                    ),
                                                  ),
                                            )
                                            .toList(),
                                  onChanged: (value) {
                                    if (availableCurrencies.isEmpty) {
                                      onLoadCurrencies();
                                    }
                                    onCurrencyChanged(value);
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (selectedCurrency != null &&
                selectedCurrency != 'USD' &&
                amountController.text.isNotEmpty)
              Column(
                children: [
                  const SizedBox(height: 8),
                  Text(
                    ' = \$ ${(double.parse(amountController.text) / currencyRate).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
          ],
        ),

        // Date input field using CustomTextField
        CustomTextField(
          controller: dateController,
          label: 'Date',
          hintText: AppLocalizations.current.selectDate,
          readOnly: true,
          suffixIcon: const Icon(
            Icons.calendar_today,
            color: AppColors.lightTextSecondary,
            size: 20,
          ),
          onTap: onDateTap,
        ),

        // Receipt upload field using CustomTextField
        CustomTextField(
          controller: receiptController,
          label: 'Attach Receipt',
          hintText: AppLocalizations.current.uploadImage,
          readOnly: true,
          suffixIcon: const Icon(
            Icons.camera_alt,
            color: AppColors.lightTextSecondary,
            size: 20,
          ),
          onTap: onReceiptTap,
        ),

        // Category grid
        CategoryGrid(
          selectedCategory: selectedGridCategory,
          isIncome: isIncome,
          onCategorySelected: onCategorySelected,
        ),
      ],
    );
  }
}

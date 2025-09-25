// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addExpense": MessageLookupByLibrary.simpleMessage("Add Expense"),
        "categoryEducation": MessageLookupByLibrary.simpleMessage("Education"),
        "categoryEntertainment":
            MessageLookupByLibrary.simpleMessage("Entertainment"),
        "categoryFood": MessageLookupByLibrary.simpleMessage("Food"),
        "categoryHealth": MessageLookupByLibrary.simpleMessage("Health"),
        "categoryOther": MessageLookupByLibrary.simpleMessage("Other"),
        "categoryShopping": MessageLookupByLibrary.simpleMessage("Shopping"),
        "categoryTransport": MessageLookupByLibrary.simpleMessage("Transport"),
        "enterAmount": MessageLookupByLibrary.simpleMessage("Enter amount"),
        "expense": MessageLookupByLibrary.simpleMessage("Expense"),
        "expenseAddedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Expense added successfully"),
        "failedToAddExpense": MessageLookupByLibrary.simpleMessage(
            "Failed to add expense. Please try again."),
        "failedToLoadExpenses":
            MessageLookupByLibrary.simpleMessage("Failed to load expenses"),
        "failedToSaveReceipt": MessageLookupByLibrary.simpleMessage(
            "Failed to save receipt. Please try again."),
        "income": MessageLookupByLibrary.simpleMessage("Income"),
        "pleaseSelectCategory":
            MessageLookupByLibrary.simpleMessage("Please select a category"),
        "retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saveExpense": MessageLookupByLibrary.simpleMessage("Save Expense"),
        "selectDate": MessageLookupByLibrary.simpleMessage("Select date"),
        "uploadImage": MessageLookupByLibrary.simpleMessage("Upload image")
      };
}

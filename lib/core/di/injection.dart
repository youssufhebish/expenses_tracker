import 'package:get_it/get_it.dart';
import '../../features/home/data/datasources/expense_local_datasource.dart';
import '../../features/home/data/repositories/expense_repository_impl.dart';
import '../../features/home/domain/repositories/expense_repository.dart';
import '../../features/home/domain/usecases/get_expenses_usecase.dart';
import '../../features/home/domain/usecases/get_balance_usecase.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/add_expense/data/datasources/add_expense_local_datasource.dart';
import '../../features/add_expense/data/repositories/add_expense_repository_impl.dart';
import '../../features/add_expense/domain/repositories/add_expense_repository.dart';
import '../../features/add_expense/domain/usecases/add_expense_usecase.dart';
import '../../features/add_expense/domain/usecases/save_receipt_usecase.dart';
import '../../features/add_expense/presentation/bloc/add_expense_bloc.dart';
import '../../features/add_expense/data/datasources/currency_conversion_remote_datasource.dart';
import '../../features/add_expense/data/repositories/currency_conversion_repository_impl.dart';
import '../../features/add_expense/domain/repositories/currency_conversion_repository.dart';
import '../../features/add_expense/domain/usecases/get_currency_conversion_rates_usecase.dart';
import '../services/expense_refresh_service.dart';
import '../services/api_service/api_service.dart';
import '../services/api_service/dio_service.dart';

/// Service locator instance
final sl = GetIt.instance;

/// Initializes dependency injection
/// Registers all dependencies for the application
Future<void> init() async {
  // Bloc
  sl.registerFactory(() => HomeBloc(
        getExpensesUseCase: sl(),
        getBalanceUseCase: sl(),
        getIncomeUseCase: sl(),
        getExpensesAmountUseCase: sl(),
        expenseRefreshService: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetBalanceUseCase(sl()));
  sl.registerLazySingleton(() => GetExpensesUseCase(sl()));
  sl.registerLazySingleton(() => GetIncomeUseCase(sl()));
  sl.registerLazySingleton(() => GetExpensesAmountUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ExpenseLocalDataSource>(
    () => ExpenseLocalDataSourceImpl(),
  );

  // Features - Add Expense
  // Bloc
  sl.registerFactory(() => AddExpenseBloc(
        addExpenseUseCase: sl(),
        saveReceiptUseCase: sl(),
        expenseRefreshService: sl(),
        getCurrencyConversionRatesUseCase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => AddExpenseUseCase(sl()));
  sl.registerLazySingleton(() => SaveReceiptUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrencyConversionRatesUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<AddExpenseRepository>(
    () => AddExpenseRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<CurrencyConversionRepository>(
    () => CurrencyConversionRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AddExpenseLocalDataSource>(
    () => AddExpenseLocalDataSourceImpl(expenseLocalDataSource: sl()),
  );
  sl.registerLazySingleton<CurrencyConversionRemoteDataSource>(
    () => CurrencyConversionRemoteDataSourceImpl(apiService: sl()),
  );

  // Core Services
  sl.registerLazySingleton(() => ExpenseRefreshService());
  sl.registerLazySingleton<ApiService>(() => DioService());

  // Initialize local data source
  final expenseLocalDataSource = sl<ExpenseLocalDataSource>() as ExpenseLocalDataSourceImpl;
  await expenseLocalDataSource.init();
}
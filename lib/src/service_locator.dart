import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:possch/src/core/firebase_authentication/firebase_authentication.dart';
import 'package:possch/src/core/firestore/firestore_service.dart';
import 'package:possch/src/core/storage/shared_preferences_service.dart';
import 'package:possch/src/features/authentication/data/datasource/authentication_datasource.dart';
import 'package:possch/src/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:possch/src/features/authentication/domain/repository/authentication_repository.dart';
import 'package:possch/src/features/authentication/domain/usecase/login_from_storage_usecase.dart';
import 'package:possch/src/features/authentication/domain/usecase/login_with_email_usecase.dart';
import 'package:possch/src/features/authentication/domain/usecase/logout_usecase.dart';
import 'package:possch/src/features/product_type/data/datasource/product_type_datasource.dart';
import 'package:possch/src/features/product_type/data/repository/product_type_repository_impl.dart';
import 'package:possch/src/features/product_type/domain/repository/product_type_repository.dart';
import 'package:possch/src/features/product_type/domain/usecase/fetch_product_type_usecase.dart';
import 'package:possch/src/features/registration/data/datasource/registration_datasource.dart';
import 'package:possch/src/features/registration/data/repository/registration_repository_impl.dart';
import 'package:possch/src/features/registration/domain/repository/registration_repository.dart';
import 'package:possch/src/features/registration/domain/usecase/create_account_usecase.dart';

final GetIt sl = GetIt.instance;

setupServiceLocator() {
  sl.registerFactory<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerFactory<FirebaseFirestore>(() => FirebaseFirestore.instance);

  sl.registerLazySingleton<FirebaseAuthentication>(
      () => FirebaseAuthenticationImpl(sl<FirebaseAuth>()));

  sl.registerLazySingleton<FirestoreService>(
      () => FirestoreServiceImpl(sl<FirebaseFirestore>()));

  sl.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesServiceImpl());

  /**
   * register datasource
   */
  sl.registerLazySingleton<AuthenticationDatasource>(() =>
      AuthenticationDatasourceImpl(
          sl<FirebaseAuthentication>(), sl<SharedPreferencesService>()));

  sl.registerLazySingleton<RegistrationDatasource>(() =>
      RegistrationDatasourceImpl(
          sl<FirebaseAuthentication>(), sl<FirestoreService>()));

  sl.registerLazySingleton<ProductTypeDatasource>(
      () => ProductTypeDatasourceImpl(sl<FirestoreService>()));
  /**
   * register repository
   */
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl<AuthenticationDatasource>()));

  sl.registerLazySingleton<RegistrationRepository>(
      () => RegistrationRepositoryImpl(sl<RegistrationDatasource>()));

  sl.registerLazySingleton<ProductTypeRepository>(
      () => ProductTypeRepositoryImpl(sl<ProductTypeDatasource>()));

  /**
   * register usecase
   */
  sl.registerLazySingleton<LoginWithEmailUseCase>(
      () => LoginWithEmailUseCase(sl<AuthenticationRepository>()));
  sl.registerLazySingleton<LoginFromStorageUseCase>(
      () => LoginFromStorageUseCase(sl<AuthenticationRepository>()));
  sl.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(sl<AuthenticationRepository>()));

  sl.registerLazySingleton<CreateAccountUseCase>(
      () => CreateAccountUseCase(sl<RegistrationRepository>()));

  sl.registerLazySingleton<FetchProductTypeUseCase>(
      () => FetchProductTypeUseCase(sl<ProductTypeRepository>()));
}

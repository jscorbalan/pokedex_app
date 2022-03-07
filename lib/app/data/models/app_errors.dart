abstract class AppError {
  String get message;
}

class ServerError implements AppError {
  @override
  String get message => 'An unknown error ocurred.';
}

class AppCrashError implements AppError {
  String? crashReason;

  AppCrashError({
    this.crashReason,
  });

  @override
  String get message => crashReason ?? 'The app throws an exception. Crashing...';
}

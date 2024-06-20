class AppException implements Exception {
  dynamic message;
  String title;

  AppException([this.message = '', this.title = 'ERROR']);

  @override
  String toString() => '[$title] $message';
}

class PermissionException extends AppException {
  PermissionException(
      [super.message = 'You do not have the right permissions.', super.title = 'PERMISSIONS']);
}

class UserNullException extends AppException {
  UserNullException([super.message = 'User cannot be null', super.title = 'NULL_USER']);
}

class AccountNullException extends AppException {
  AccountNullException([super.message = 'Account cannot be null', super.title = 'NULL_ACCOUNT']);
}

class ValueExistsException extends AppException {
  ValueExistsException([super.message = 'Value already in use.', super.title = 'VALUE_EXISTS']);
}

class ValueEmptyException extends AppException {
  ValueEmptyException([super.message = 'Value cannot be empty.', super.title = 'VALUE_EMPTY']);
}

class UploadFailedException extends AppException {
  UploadFailedException([super.message = 'Upload Failed', super.title = 'UPLOAD_FAILED']);
}

class ObjectNullException extends AppException {
  ObjectNullException([super.message = 'Object is null', super.title = 'OBJECT_NULL']);
}

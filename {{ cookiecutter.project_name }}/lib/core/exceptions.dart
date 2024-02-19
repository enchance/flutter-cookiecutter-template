class AppException implements Exception {
  dynamic message;
  String title;

  AppException([this.message = '', this.title = 'ERROR']);

  @override
  String toString() => '[$title] $message';
}

class ValueExistsException extends AppException {
  ValueExistsException([super.message = 'Value already in use.', super.title = 'VALUE_EXISTS']);
}

class ValueEmptyException extends AppException {
  ValueEmptyException([super.message = 'Value cannot be empty.', super.title = 'VALUE_EMPTY']);
}

class UpdateException extends AppException {
  UpdateException([
    super.message = 'Something is preventing the app from updating.',
    super.title = 'UPDATE_FAIL',
  ]);
}

class CreateException extends AppException {
  CreateException([
    super.message = 'Something is preventing the app from saving.',
    super.title = 'CREATE_FAIL',
  ]);
}

class DeleteException extends AppException {
  DeleteException([
    super.message = 'Something is preventing the app from deleting.',
    super.title = 'DELETE_FAIL',
  ]);
}

abstract class AdminStates {}

class GetAllUsersInitialState extends AdminStates {}

class GetAllUsersLoadingState extends AdminStates {}

class GetAllUsersSuccessState extends AdminStates {}

class GetAllUsersFailuerState extends AdminStates {}

class ChangePageSize extends AdminStates{}

class DeleteUsersLoadingState extends AdminStates {}

class DeleteUsersSuccessState extends AdminStates {}

class DeleteUsersFailuerState extends AdminStates {}

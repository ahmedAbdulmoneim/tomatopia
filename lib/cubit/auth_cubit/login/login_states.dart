abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginFailureState extends LoginStates {}

class AddFCMTokenLoading extends LoginStates {}

class AddFCMTokenSuccess extends LoginStates {}

class AddFCMTokenFailure extends LoginStates {}

class ChangeLoginPasswordVisibilityState extends LoginStates {}

abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {}

class ProfileFailureState extends ProfileStates {}

class ChangeNameLoadingState extends ProfileStates {}

class ChangeNameSuccessState extends ProfileStates {}

class ChangeNameFailureState extends ProfileStates {}

class LoadProfileImageState extends ProfileStates {}

class PicProfileImageState extends ProfileStates {}

class DeleteUserImage extends ProfileStates{}

class AddProfileImageLoadingState extends ProfileStates{}
class AddProfileImageSuccessState extends ProfileStates{}
class AddProfileImageFailureState extends ProfileStates{}

class ChangePasswordLoadingState extends ProfileStates {}

class ChangePasswordSuccessState extends ProfileStates {}

class ChangePasswordFailuerState extends ProfileStates {}

class SuffixIconVisibility extends ProfileStates{}

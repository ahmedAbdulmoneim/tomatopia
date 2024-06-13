
abstract class AiModelStates {}

class AiModelInitialState extends AiModelStates {}

class AiModelLoadingState extends AiModelStates {}

class AiModelSuccessState extends AiModelStates {}

class AiModelFailureState extends AiModelStates {}

class GetDiseaseInfoLoadingState extends AiModelStates {}

class GetDiseaseInfoSuccessState extends AiModelStates {}

class GetDiseaseInfoFailureState extends AiModelStates {}

class LoadImageGallerySuccessState extends AiModelStates {}

class PicImageCameraSuccessState extends AiModelStates {}

class ClearImageState extends AiModelStates {}

class ShowAdviceMessageState extends AiModelStates {}


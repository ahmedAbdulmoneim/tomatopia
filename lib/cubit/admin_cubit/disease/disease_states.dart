abstract class DiseaseStates {}

class GetAllDiseaseInitialState extends DiseaseStates {}

class GetAllDiseaseLoadingState extends DiseaseStates {}

class GetAllDiseaseSuccessState extends DiseaseStates {}

class GetAllDiseaseFailureState extends DiseaseStates {}


class AddDiseaseLoadingState extends DiseaseStates {}

class AddDiseaseSuccessState extends DiseaseStates {}

class AddDiseaseFailureState extends DiseaseStates {}

class GetDiseaseByNameLoadingState extends DiseaseStates {}

class GetDiseaseByNameSuccessState extends DiseaseStates {}

class GetDiseaseByNameFailureState extends DiseaseStates {}

class ChooseImage extends DiseaseStates{}
class ClearSearchedDisease extends DiseaseStates{}

class DeleteDiseaseLoadingState extends DiseaseStates {}

class DeleteDiseaseSuccessState extends DiseaseStates {}

class DeleteDiseaseFailureState extends DiseaseStates {}
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:on_the_go/features/home/data/models/image_model.dart';
import 'package:on_the_go/features/home/domain/use_cases/get_images_usecase.dart';

part 'get_images_state.dart';

class GetImagesCubit extends Cubit<GetImagesState> {
  GetImagesCubit(this.getImagesUsecase) : super(GetImagesInitial());

  final GetImagesUsecase getImagesUsecase;

  List<ImageModel>? _getImagesCashe;
  Future<void> getImages() async {
    emit(GetImagesLoading());
    if (_getImagesCashe != null) {
      emit(GetImagesSuccess(_getImagesCashe!));
      return;
    }
    try {
      final images = await getImagesUsecase.call();
      _getImagesCashe = images;
      emit(GetImagesSuccess(images));
    } catch (e) {
      emit(GetImagesError(e.toString()));
    }
  }
}

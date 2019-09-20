import './require.dart';

ApiCategoriesPkAllVideos(String pk) async{
  var res =await service.get('tube/categories/${pk}/all_videos');
  return res;
}
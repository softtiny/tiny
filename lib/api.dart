import './require.dart';

ApiCategoriesPkAllVideos(String pk) async{
  print("categories start");
  var res =await service.get('tube/categories/${pk}/all_videos').catchError((err){
    print(err);
  });
  print("categories end");
  return res;
}
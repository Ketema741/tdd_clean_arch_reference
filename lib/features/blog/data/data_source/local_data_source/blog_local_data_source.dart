import 'package:tdd_clean_architecture/features/blog/data/models/blog_hive_model.dart';
import 'package:hive/hive.dart';

abstract class BlogLocalDataSource {
  Future<void> saveBlogs(List<BlogModel> blogs);
  Future<List<BlogModel>> getBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  static const String _boxName = 'blogsBox';

  @override
  Future<void> saveBlogs(List<BlogModel> blogs) async {
    await Hive.close();
    final box = await Hive.openBox<BlogModel>(_boxName);
    await box.clear(); // Clear existing data
    await box.addAll(blogs);
  }

  @override
  Future<List<BlogModel>> getBlogs() async {
    final box = await Hive.openBox<BlogModel>(_boxName);
    return box.values.toList();
  }
}

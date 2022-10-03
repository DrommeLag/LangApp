import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lang_app/models/article.dart';
import 'package:lang_app/models/article_tag.dart';
import 'package:lang_app/models/news.dart';
import 'package:lang_app/models/progress.dart';
import 'package:lang_app/models/task.dart';
import 'package:lang_app/models/test.dart';

class DatabaseService {
  DatabaseService._privateCons();

  static final DatabaseService _instance = DatabaseService._privateCons();

  factory DatabaseService() {
    return _instance;
  }

  final CollectionReference<News> _newsRef = FirebaseFirestore.instance
      .collection('news')
      .withConverter(
          fromFirestore: ((snapshot, options) =>
              News.fromFirebase(snapshot.data()!)),
          toFirestore: ((news, options) => news.toFirebase()));

  final _taskRef = FirebaseFirestore.instance
      .collection('levels')
      .withConverter<Task>(
          fromFirestore: ((snapshot, options) =>
              Task.fromFirebase(snapshot.data()!)),
          toFirestore: ((test, options) => test.toFirestore()));

  final _testRef = FirebaseFirestore.instance
      .collection('tests')
      .withConverter<Test>(
          fromFirestore: ((snapshot, options) =>
              Test.fromFirestore(snapshot.data()!)),
          toFirestore: ((data, options) => data.toFirestore()));

  final _userProgressRef =
      FirebaseFirestore.instance.collection('user-progress');

  final _articleRef =
      FirebaseFirestore.instance.collection('articles').withConverter<Article>(
            fromFirestore: (snapshot, _) =>
                Article.fromFirebase(snapshot.data()!, snapshot.id),
            toFirestore: (value, _) => value.toFirebase(),
          );

  final _articleRestRef = FirebaseFirestore.instance
      .collection('articles-rest')
      .withConverter<String>(
          fromFirestore: ((snapshot, options) =>
              snapshot.data()!["rest"] as String),
          toFirestore: ((value, options) => {"rest": value}));

  final _articleTagRef = {
    ArticleCategory.forMe: FirebaseFirestore.instance
        .collection('articles-category-forme')
        .withConverter(
            fromFirestore: ((snapshot, options) => ArticleTag.fromFirestore(
                snapshot.data()!, ArticleCategory.forMe)),
            toFirestore: ((value, options) => value.toFirestore())),
    ArticleCategory.brands: FirebaseFirestore.instance
        .collection('articles-category-brands')
        .withConverter(
            fromFirestore: ((snapshot, options) => ArticleTag.fromFirestore(
                snapshot.data()!, ArticleCategory.brands)),
            toFirestore: ((value, options) => value.toFirestore())),
    ArticleCategory.media: FirebaseFirestore.instance
        .collection('articles-category-media')
        .withConverter(
            fromFirestore: ((snapshot, options) => ArticleTag.fromFirestore(
                snapshot.data()!, ArticleCategory.media)),
            toFirestore: ((value, options) => value.toFirestore())),
    ArticleCategory.something: FirebaseFirestore.instance
        .collection('articles-category-something')
        .withConverter(
            fromFirestore: ((snapshot, options) => ArticleTag.fromFirestore(
                snapshot.data()!, ArticleCategory.something)),
            toFirestore: ((value, options) => value.toFirestore())),
    ArticleCategory.sport: FirebaseFirestore.instance
        .collection('articles-category-sport')
        .withConverter(
            fromFirestore: ((snapshot, options) => ArticleTag.fromFirestore(
                snapshot.data()!, ArticleCategory.sport)),
            toFirestore: ((value, options) => value.toFirestore())),
  };

  Future setNews(News news, String id) async {
    _newsRef.doc(id).set(news);
  }

  Future<News> getNews(String id) async {
    return _newsRef.doc(id).get().then((value) => value.data()!);
  }

  Future<Iterable<News>> getAllNews() async {
    return _newsRef.get().then((value) => value.docs.map((e) => e.data()));
  }

  Future<Task> getTask(String id) async {
    return _taskRef.doc(id).get().then((value) => value.data()!);
  }

  setTask(Task task, String id) {
    _taskRef.doc(id).set(task);
  }

  Future<Test> getTest(String id) async {
    return _testRef.doc(id).get().then((value) => value.data()!);
  }

  Future<Iterable<Test>> getTests() async {
    return _testRef.get().then((value) => value.docs.map((e) => e.data()));
  }

  setTest(Test test, String id) {
    _testRef.doc(id).set(test);
  }

  Future<UserProgress> getProgress() {
    return _userProgressRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => UserProgress.fromFirestore(value.data()!));
  }

  updateProgress(int level, int status) {
    _userProgressRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({level.toString(): status});
  }

  checkProgress(String uid) async {
    _userProgressRef.doc(uid).get().then((value) {
      if (value.data() == null) {
        _userProgressRef.doc(uid).set(UserProgress.template.toFirestore());
      }
    });
  }

  Future<Article> getArticle(String id) async {
    return _articleRef.doc(id).get().then((value) => value.data()!);
  }

  Future<Iterable<Article>> getAllArticles() async {
    return _articleRef
        .get()
        .then((value) => value.docs.map((element) => element.data()));
  }

  Future<void> getRestArticle(Article article) async {
    await _articleRestRef
        .doc(article.id)
        .get()
        .then((value) => article.giveRestText(value.data()!));
  }

  Future<void> sendArticle(Article article, ArticleCategory category) async {
    var ref = await _articleRef.add(article);
    await _articleRestRef.doc(ref.id).set(article.restText);

    await _articleTagRef[category]!
        .add(ArticleTag(ref.id, DateTime.now(), category));
  }

  Future<void> updateArticle(String id, Article article) async {
    _articleRef.doc(id).update(article.toFirebase());
    _articleRestRef.doc(id).update({"rest": article.restText});
  }

  Future<Iterable<Article>> getRecentArticleByCategory(
      ArticleCategory category, DateTime? last) async {
    late Iterable<ArticleTag> info;
    if (last == null) {
      info = await _articleTagRef[category]!
          .orderBy("publishing", descending: true)
          .limit(10)
          .get()
          .then((value) => value.docs.map((e) => e.data()));
    } else {
      info = await _articleTagRef[category]!
          .orderBy("publishing", descending: true)
          .startAfter([last.millisecondsSinceEpoch])
          .limit(10)
          .get()
          .then((value) => value.docs.map((e) => e.data()));
    }
    var articlesRef = info.map((e) => _articleRef.doc(e.id).get());
    var articles = await Future.wait(articlesRef);
    var articlesOut = articles.map((e) => e.data()!).toList();
    info.forEachIndexed((index, element) {
      articlesOut[index].publishing = element.publishing;
    });
    return articlesOut;
  }
}

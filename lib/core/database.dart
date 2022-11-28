import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lang_app/models/view_point.dart';
import 'package:lang_app/models/news.dart';
import 'package:lang_app/models/progress.dart';
import 'package:lang_app/models/task.dart';
import 'package:lang_app/models/test.dart';

import '../models/view_point_region.dart';

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

  final CollectionReference<ViewPoint> _viewPointRef = FirebaseFirestore.instance
      .collection('view-points')
      .withConverter(
      fromFirestore: ((snapshot, options) =>
          ViewPoint.fromFirebase(snapshot.data()!)),
      toFirestore: ((data, options) => data.toFirebase()));

  final CollectionReference<ViewPointRegion> _viewPointsByRegionRef = FirebaseFirestore.instance
      .collection('view-points-regions')
      .withConverter(
      fromFirestore: ((snapshot, options) =>
          ViewPointRegion.fromFirebase(snapshot.data()!)),
      toFirestore: ((data, options) => data.toFirebase()));

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

  Future<ViewPoint> getViewPoint(int id) async {
    return _viewPointRef.doc(id.toString()).get().then((value) => value.data()!);
  }

  Future<Iterable<ViewPoint>> getViewPoints() async {
    return _viewPointRef.get().then((value) => value.docs.map((e) => e.data()));
  }

  setViewPoint(ViewPoint viewPoint, String id) {
    _viewPointRef.doc(id).set(viewPoint);
  }

  Future<ViewPointRegion> getViewPointsByRegion(String id) async {
    return _viewPointsByRegionRef.doc(id).get().then((value) => value.data()!);
  }

  setViewPointRegion(ViewPointRegion viewPointRegion, String id) {
    _viewPointsByRegionRef.doc(id).set(viewPointRegion);
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
    _userProgressRef.doc(uid).get().then((value){ 
      if(value.data() == null){
        _userProgressRef.doc(uid).set(UserProgress.template.toFirestore());
      }
      });
  }
}

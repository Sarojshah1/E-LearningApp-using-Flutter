import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:llearning/App/constants/formatdate.dart';
import 'package:llearning/features/Courses/data/model/ReviewModel.dart';
import 'package:llearning/features/Courses/data/model/course_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/reviewViewModel.dart';
import 'PaymentPage.dart';

class CourseDetailsPage extends ConsumerStatefulWidget {
  final CourseModel course;

  const CourseDetailsPage({Key? key, required this.course}) : super(key: key);

  @override
  _CourseDetailsPageState createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends ConsumerState<CourseDetailsPage> {
  int visibleReviewCount = 2; // Number of reviews to show initially
  bool showAllReviews = false;
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 0;
  int _currentPage = 1;
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      ref.read(reviewViewModelProvider.notifier).getReviews(widget.course.id);
    });
  }
  String activeTab = "overview";


  void _handleBuyNow() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage(course: widget.course)));
  }

  void _submitReview() async{
    final review=_reviewController.text;
   final viewModel=ref.read(reviewViewModelProvider.notifier);
   await viewModel.addReviews(widget.course.id,review , _rating.round());
    _reviewController.clear();
    setState(() {
      _rating = 0;
    });
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    final reviewstate=ref.watch(reviewViewModelProvider);
    print(reviewstate.reviews);


    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  'http://10.0.2.2:3000/thumbnails/${course.thumbnail}',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.black.withOpacity(0.6),
                    child: Text(
                      course.title,
                      style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTabButton('Overview'),
                  _buildTabButton('Description'),
                  _buildTabButton('Reviews'),
                ],
              ),
            ),
            SizedBox(height: 10),
            if (activeTab == "overview") _buildOverview(course),
            if (activeTab == "description") _buildDescription(course),
            if (activeTab == "reviews") _buildReviews(reviewstate.reviews),
            SizedBox(height: 20),
            _buildIncludes(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          activeTab = label.toLowerCase();
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: activeTab == label.toLowerCase() ? Colors.blue : Colors.grey[400],
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOverview(CourseModel course) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Course Overview', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.blue, size: 20),
              SizedBox(width: 8),
              Expanded(child: Text('Duration: ${course.duration}')),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 20),
              SizedBox(width: 8),
              Expanded(child: Text('Level: ${course.level}')),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.person, color: Colors.green, size: 20),
              SizedBox(width: 8),
              Expanded(child: Text('Created By: ${course.createdBy.name}')),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.purple, size: 20),
              SizedBox(width: 8),
              Expanded(child: Text('Created Date: ${FormatDate.formatDateOnly(course.createdAt)}')),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.book, color: Colors.red, size: 20),
              SizedBox(width: 8),
              Expanded(child: Text('Total Lessons: ${course.lessons.length}')),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _handleBuyNow,
            child: Text('Buy Now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(CourseModel course) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Course Description', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(course.description),
        ],
      ),
    );
  }

  Widget _buildReviews(List<ReviewModel> reviews) {
    final sortedReviews = reviews
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    double overallRating = sortedReviews.isNotEmpty
        ? reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length
        : 0;
    final startIndex = visibleReviewCount * (_currentPage-1);
    final endIndex = (startIndex + visibleReviewCount) > sortedReviews.length ? sortedReviews.length : (startIndex + visibleReviewCount);
    final visibleReviews = sortedReviews.sublist(startIndex , endIndex );

    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overall Rating',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              RatingBarIndicator(
                rating: overallRating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 30.0,
                direction: Axis.horizontal,
              ),
              SizedBox(width: 10),
              Text(
                '$overallRating (${reviews.length} reviews)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Reviews',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ...visibleReviews.map((review) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: 'http://10.0.2.2:3000/profile/${review.userId.profilePicture}',
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(review.userId.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: review.rating.toDouble(),
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                          SizedBox(width: 10),
                          Text(
                           FormatDate.formatDateOnly( review.createdAt),
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(review.comment),
                    ],
                  ),

                ),
              ),
            );
          }).toList(),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentPage > 0)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentPage--;
                    });
                  },
                  child: Text('Previous'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              if (endIndex < sortedReviews.length)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _currentPage++;
                    });
                  },
                  child: Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
            ],
          ),

          SizedBox(height: 20),
          Text(
            'Add Your Review',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 10),
          RatingBar.builder(
            itemCount: 5,
            itemSize: 40,
            initialRating: _rating,
            itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          SizedBox(height: 10),
          TextField(
            controller: _reviewController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Your Review',

            ),
            maxLines: 5,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _submitReview,
            child: Text('Submit Review',style: TextStyle(color: Colors.white),),
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    ),)

          ),
        ],
      ),
    );
  }


  Widget _buildIncludes() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child:const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('This Course Includes', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.video_library, color: Colors.blue, size: 24),
              SizedBox(width: 8),
              Text('Access to all videos'),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.article, color: Colors.green, size: 24),
              SizedBox(width: 8),
              Text('Course materials'),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.help, color: Colors.purple, size: 24),
              SizedBox(width: 8),
              Text('Quizzes and exams'),
            ],
          ),
        ],
      ),
    );
  }
}

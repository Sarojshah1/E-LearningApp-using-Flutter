class ApiEndpoints {

  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/api";

  static const limit = 10;
  // Optionally, adjust the baseUrl to match your network setup or deployment environment

// user routes
  static const String register = "$baseUrl/user/register";
  static const String login = "$baseUrl/user/login";
  static const String profile = "$baseUrl/user/profile";
  static const String allUsers = "$baseUrl/user";
  static const String changePassword = "$baseUrl/user/change-password";
  static const String updateDetails = "$baseUrl/user/update-details";
  static const String updateProfilePicture = "$baseUrl/user/update-profile-picture";
//   course routes
static const String getCourses="$baseUrl/courses/pagination";
// reviews
  static const String addReviews="$baseUrl/review/reviews";
  static String getReviewUrl(String courseId) {
    return "$baseUrl/review/reviews/course/$courseId";
  }
  static String getCourseUrl(String courseId) {
    return "$baseUrl/courses/$courseId";
  }

//   blogs
static const String getBlogs="$baseUrl/blog/blogs";

  static const String getLearnings="$baseUrl/enroll/user";


//FormPost Api
static const String createPost="$baseUrl/post";
static const String getPost="$baseUrl/post";


}

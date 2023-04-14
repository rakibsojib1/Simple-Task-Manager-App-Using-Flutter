class Urls {
  static String baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String loginUrl = '$baseUrl/login';
  static String registrationUrl = '$baseUrl/registration';
  static String createnewtaskUrl = '$baseUrl/createTask';
  static String newTaskUrls = '$baseUrl/listTaskByStatus/New';
  static String cpmpletedTaskUrls = '$baseUrl/listTaskByStatus/Completed';
  static String changeTaskStatusUrls(String taskId, String status) =>
      '$baseUrl/updateTaskStatus/$taskId/$status';
  static String updatedProfileUrls = '$baseUrl/profileUpdate';

  static String recoverVerifyEmailUrls(String email) =>
      '$baseUrl/RecoverVerifyEmail/$email';
  static String recoverVerifyOTPUrls(String email, String otp) =>
      '$baseUrl/RecoverVerifyEmail/$email/$otp';
  static String resetPassUrls = '$baseUrl/RecoverResetPass';

  static String cancelledTaskUrls = '$baseUrl/listTaskByStatus/Cancelled';
  static String inProgressTaskUrls = '$baseUrl/listTaskByStatus/Progress';

  static String deleteTaskUrl(String id) => '$baseUrl/deleteTask/$id';
}

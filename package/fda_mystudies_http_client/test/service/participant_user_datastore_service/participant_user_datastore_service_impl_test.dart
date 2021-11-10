import 'package:fda_mystudies_http_client/injection/injection.dart';
import 'package:fda_mystudies_http_client/mock/demo_config.dart';
import 'package:fda_mystudies_http_client/service/participant_user_datastore_service/participant_user_datastore_service.dart';
import 'package:fda_mystudies_spec/participant_user_datastore_service/get_user_profile.pb.dart';
import 'package:fda_mystudies_spec/participant_user_datastore_service/registration.pbserver.dart';
import 'package:fda_mystudies_spec/participant_user_datastore_service/update_user_profile.pbserver.dart';
import 'package:fda_mystudies_spec/participant_user_datastore_service/verify_email.pbserver.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../common/common_test_object.dart';

void main() {
  ParticipantUserDatastoreService? participantUserDatastoreService;
  final config = DemoConfig();

  setUpAll(() {
    configureDependencies(config);
    participantUserDatastoreService = getIt<ParticipantUserDatastoreService>();
  });

  group('contact us tests', () {
    test('default scenario test', () async {
      var response = await participantUserDatastoreService!.contactUs('userId',
          'authToken', 'subject', 'feedbackBody', 'email', 'firstName');

      expect(response, CommonTestObject.commonSuccessResponse);
    });
  });

  group('deactivate tests', () {
    test('default scenario test', () async {
      var response = await participantUserDatastoreService!
          .deactivate('userId', 'authToken', 'studyId', 'participantId');

      expect(response, CommonTestObject.commonSuccessResponse);
    });
  });

  group('feedback tests', () {
    test('default scenario test', () async {
      var response = await participantUserDatastoreService!
          .feedback('userId', 'authToken', 'subject', 'feedbackBody');

      expect(response, CommonTestObject.commonSuccessResponse);
    });
  });

  group('get user profile tests', () {
    test('default scenario test', () async {
      var response = await participantUserDatastoreService!
          .getUserProfile('userId', 'authToken');

      expect(
          response,
          GetUserProfileResponse()
            ..message = 'success'
            ..profile = (GetUserProfileResponse_UserProfile()
              ..emailId = 'tester@fda-mystudies.com')
            ..settings = (GetUserProfileResponse_UserProfileSettings()
              ..localNotifications = true
              ..passcode = false
              ..remoteNotifications = true
              ..touchId = false));
    });
  });

  group('register user tests', () {
    test('default scenario test', () async {
      var response = await participantUserDatastoreService!
          .register('emailId', 'password');

      expect(
          response,
          RegistrationResponse()
            ..tempRegId = '1234'
            ..userId = 'test_user_id');
    });
  });

  group('resend confirmation tests', () {
    test('default scenario test', () async {
      var response = await participantUserDatastoreService!
          .resendConfirmation('userId', 'emailId');

      expect(response, CommonTestObject.commonSuccessResponse);
    });
  });

  group('update user profile tests', () {
    test('default scenario test', () async {
      var response = await participantUserDatastoreService!.updateUserProfile(
          'userId', 'authToken', GetUserProfileResponse_UserProfile());

      expect(
          response,
          UpdateUserProfileResponse()
            ..code = 200
            ..message = 'success'
            ..response = 'success');
    });
  });

  group('verify email tests', () {
    test('default scenario test', () async {
      var response = await participantUserDatastoreService!
          .verifyEmail('emailId', 'userId', 'verificationCode');

      expect(
          response,
          VerifyEmailRepsonse()
            ..code = 200
            ..message = 'success'
            ..verified = true
            ..tempRegId = '1234');
    });
  });
}

/*
 {
    "message": "success",
    "profile": {
      "emailId": "tester@fda-mystudies.com"
    },
    "settings": {
      "localNotifications": true,
      "passcode": false,
      "remoteNotifications": true,
      "touchId": false
    }
  }
*/
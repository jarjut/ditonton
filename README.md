# ditonton

[![ci][ci_badge]][ci_link]

Dicoding Academy Flutter Expert Submission Project

This app is a movie catalog app that shows the list of movies and tv shows. The data is fetched from [The Movie Database](https://www.themoviedb.org/).

# Project Criteria

## Clean Architecture

Applications divided into 3 layers:

- Domain : Contains the main requirements and logic related to business needs & applications
- Data : Contains code implementation to get data from external sources.
- Presentation : Contains widget implementation and application display as well as state management.

## Automated Testing

Unit testing with a minimum testing coverage of 95%.

### Running Tests

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

## Using BloC Library

Migrating state management which previously used a provider to become BLoC.

## Continuous Integration

Using Github Actions to run unit tests and check code quality.

## SSL Pinning

Installing an SSL certificate on the application as an additional layer of security for accessing data from the API.

## Integration with Firebase Analytics & Crashlytics

Ensuring developers continue to receive feedback from users, especially regarding stability and error reports.

[ci_badge]: https://github.com/jarjut/ditonton/actions/workflows/main.yaml/badge.svg
[ci_link]: https://github.com/jarjut/ditonton/actions

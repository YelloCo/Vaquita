# Vaquita

This web audit tool allows users to automate the generation of code update reports for use in manual secure code reviews. A custom scheduler generates code diffs to be reviewed by reviewers. Users can also attach information to the code review if any issues are found.

This tool currently only works for code repositories that are tracked via Git.

## Purpose

Vaquita was made to automate the process of generating code diffs for multiple projects and allowing teams to take responsibility over secure code reviews.

## Installation

Please see [Installing.md](docs/installing.md)

## Testing

Lint tests can be achieved by running the following:
  * `bundle exec rake eslint` for javascript
  * `bundle exec bundle exec scss-lint app/assets/stylesheets/` for stylesheets
  * `bundle exec rubocop` for ruby
  * `bundle exec brakeman` for static secure code analysis

Feature tests can be achieved by running the following:
  * `bundle exec rspec`

Test must be written for new features and all tests must pass before merge requests will be approved.

## Screenshots

![Dashboard](/misc/screenshots/dashboard.png?raw=true "Dashboard")
![Reviews](/misc/screenshots/reviews.png?raw=true "Reviews")
![View Review](/misc/screenshots/view_review.png?raw=true "View Review")
![Create Repository](/misc/screenshots/create_repository.png?raw=true "Create Repository")

## Contributing

Please see [Contributing.md](CONTRIBUTING.md)

## License

Please see [License.txt](LICENSE.txt)

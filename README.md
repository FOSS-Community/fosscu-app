# fosscu_app

A mobile app for fosscu community.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## How to setup the project:

Clone the repository using git clone.

Then Run this from terminal.
```dart
pub get
```
Under lib/constants create a new file as apikey.dart, It is your key used to fetch data from github api.

```dart
const apikey = 'paste_your_apikey_here';
```



## Roadmap
Features
- [x] Basic info of Club
- [x] Login, Registration
    - [ ] Documentation links
    - [ ] Repositories
    - [ ] Learning path
    - [ ] Gitpod setup links
    - [ ] View the deployed link for master branch
    - [x] Link to github unclaimed issues
- [ ] Commands to do the following
    - [ ] Seeing the summary of proposals submitted by contributors
    - [x] Listing contributions by profile
- [ ] Share a summary of contributions at the end of the day to each individual channel project wise
    - [x] Total PR Raised by Contributors (not mentors)
    - [x] Total PRs Merged by Contributors (not mentors)
    - [x] Top 5 contributors
    - [x] Contributions for the day (Issues list)
- [ ] Draft proposals
    - [ ] Share with mentors
    - [ ] Allow mentors ping contributors when the proposal is reviewed (not sure how this can be accomplished)
    - [ ] Dashboard to show all proposals a mentors needs to review
- [ ] Final proposals
    - [ ] Submission
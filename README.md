
# FOSSC Flutter App

This repository contains the app for FOSS Community writter in Flutter 

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Overview

The Flutter app is designed to manage events, get details about the recent raised PRs, recent merged PRs, a Learning page to get started with git and github, And much more.

## Prerequisites

Before you proceed, ensure you have the following prerequisites installed and set up:

1. [Flutter SDK](https://flutter.dev/docs/get-started/install) - Install Flutter and set up your development environment.

2. [Firebase Account](https://firebase.google.com/) - Set up a Firebase project 

3. [GitHub Personal Access Token](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token) - Create a GitHub Personal Access Token to access the GitHub API.

4. [Airtable Account](https://airtable.com/) - Sign up for an Airtable account to obtain a Personal Access Token.

## Installation

1. Clone this repository to your local machine using the following command:

   ```
   git clone https://github.com/FOSS-Community/fosscu-app.git
   ```

2. Change your working directory to the app folder:

   ```
   cd fosscu-app
   ```

3. Fetch the Flutter dependencies:

   ```
   flutter pub get
   ```

## Configuration

### Firebase Setup

setup using this link https://firebase.flutter.dev/docs/overview/

### Constants Configurations

1. Open the Flutter app in your favorite code editor.

2. Create a file `lib/constants/apikey.dart`.


```
const apikey =  'REPLACE_WITH_YOUR_GITHUB_PAT'; 
const airtablePAT =  'REPLACE_WITH_YOUR_AIRTABLE_PAT';

const baseID =  'AIRTABLE_BASE_ID';

const table =  'AIRTABLE_TABLE_ID';

const xptable =  'AIRTABLE_XP_TABLE_ID'; 
```

## Usage

Now that you have completed the configuration, it's time to run the app:

1. Ensure you have an Android/iOS emulator running or a physical device connected.

2. Run the app using the following command:

   ```
   flutter run
   ```

3. The app will launch on your emulator/device, and you can explore its beautiful UI.

## Contributing

We welcome and appreciate contributions to make this Flutter app even more amazing. Feel free to submit issues and pull requests.

1. Fork this repository to your GitHub account.

2. Create a new branch with a descriptive name for your changes.

3. Make your improvements and commit your changes.

4. Push the changes to your forked repository.

5. Open a pull request to this repository, describing the changes you made.

## License

This Flutter app is distributed under the [MIT License](LICENSE).





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
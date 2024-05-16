# FOSSCU App

Welcome to **FOSSCU APP**! A mobile app made for FOSS-Community.

## Features

- **FOSSCU Events**: Register for tech events organized by [FOSSCU](https://fosscu.org/) directly from our app.
- **FOSS-Community Updates**: Get all the updates of FOSS-Community right at your finger tips.
- **Resources**: Hand Curated resources to kickstart your coding journey.
- **Create your FOSSCU Account**: With our FOSSCU Account on FOSSCU App and claim XPs.

## Screenshots

Below are some screenshots showcasing different parts of the app. 

<div style="display: flex; flex-direction: row;">
    <img src="https://github.com/Utkarsh4517/fosscu-app/assets/71646773/8fcf2823-684e-402e-9d3b-6c29679e89b2" alt="Screenshot 1" width="200"/>
    <img src="https://github.com/Utkarsh4517/fosscu-app/assets/71646773/0ffaba94-e239-4be7-9039-3f3d4a28698c" alt="Screenshot 2" width="200"/>
    <img src="https://github.com/Utkarsh4517/fosscu-app/assets/71646773/5e759fce-cfa9-4234-9214-63f2aad560d7" alt="Screenshot 3" width="200"/>
    <img src="https://github.com/Utkarsh4517/fosscu-app/assets/71646773/c4bd40bd-a5fb-449b-baea-f24e0906b567" alt="Screenshot 4" width="200"/>
      <img src="https://github.com/Utkarsh4517/fosscu-app/assets/71646773/4c44a589-2582-4ef5-9b59-8a8bcc0e9b21" alt="Screenshot 4" width="200"/>
      <img src="https://github.com/Utkarsh4517/fosscu-app/assets/71646773/62a35659-391b-4ce3-90d4-ae0744a4c608" alt="Screenshot 4" width="200"/>
      <img src="https://github.com/Utkarsh4517/fosscu-app/assets/71646773/089df310-0b2c-4ffa-a88c-7e8cb50129a6" alt="Screenshot 4" width="200"/>
</div>



## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Comes bundled with Flutter.
- Node.js and npm installed. You can download and install them from [Node.js official website](https://nodejs.org/).
- An IDE like [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/).


### Installation on Local

To get started with  FOSSCU App, follow these steps:

**Clone the Repository**:
   
    ```bash
    git clone https://github.com/FOSS-Community/fosscu-app.git
    cd fosscu_app
    ```

**Install Dependencies**:
    ```bash
    flutter pub get
    ```


### Creating A Personal access token for GitHub APIs 
- [Github Docs](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)


### Setting up Airtable
- Create an account on [Airtable](https://airtable.com)
- Create a personal access token [PAT](https://airtable.com/create/tokens)
- Create a new base inside a workspace
- Under that base create a new table

- Inside the `lib/constants` create a new file named `apikey.dart`
    ```
    const apikey = 'your_github_personal_access_token;
    const airtablePAT = 'your_airtable_personal_access_token';
    const baseID = 'your_airtable_base_id';
    const table = 'your_airtable_table_id'; 
    
    ```

### Setting up Firebase
- Go to the [Firebase Console](https://console.firebase.google.com/).
- Click on "Add Project" and follow the setup steps.
- Install Firebase CLI `npm install -g firebase-tools`
- Install FlutterFire CLI - `dart pub global activate flutterfire_cli`
- run `firebase login`
- run `flutterfire configure`
- Select the Firebase project that you just created on the [Firebase Console](https://console.firebase.google.com/).
- Now go to [Firebase Console](https://console.firebase.google.com/) and   
    1. Enable Authentication with Google as Sign in Provider
    2. Create a new Firestore Database


- Create a new Debug SHA-1 and SHA-256 Keys [Guide](https://stackoverflow.com/questions/51845559/generate-sha-1-for-flutter-react-native-android-native-app)
- Go to the Project Settings on the [Firebase Console](https://console.firebase.google.com/) and the `SHA-1` and `SHA-256` Keys in the `SHA Certificate Fingetprint` Section.


### Now we are all set to run the app locally

### Running the App

1. **Connect a Device**: Connect an Android or iOS device, or start an emulator.
2. **Build and Run**:
    ```bash
    flutter run
    ```

### How to become an admin user of the app?
- Go to your Firestore Database
- Create a new collection named  `admin`
- Create a new document named `admin_right` inside the `admin` collection.
- Add a new String type field inside the document with the email you want the admin access.
    - example:
    ```
    Field: admin1
    Type: string
    Value: admin1@gmail.com
    ```


## Contributing

We welcome contributions to the FOSSCU App! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch:
    ```bash
    git checkout -b feature/your-feature-name
    ```
3. Make your changes and commit them:
    ```bash
    git commit -m "Add new feature"
    ```
4. Push to the branch:
    ```bash
    git push origin feature/your-feature-name
    ```
5. Open a pull request.

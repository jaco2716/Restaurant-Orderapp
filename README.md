# restaurantorderapp

Add new Flavor TODO list:
1. Create main_<flavor>.dart file, create main function with Flavor initialize then runApp(MyApp()):
    void main() {
        F.appFlavor = Flavor.flavorName;
        runApp(MyApp());
    }
    - Add flavor values to flavors.dart.

2. Create Launch configuration:
    {
        "name": "Flavor: <flavorName>",
        "type": "dart",
        "request": "launch",
        "program": "lib/main_<flavor>.dart",
        "args": [
            "--flavor",
            "<flavor>"
        ]
    },
    
3. iOS Setup in Xcode:
    - Add new scheme in Target -> Runner
    - In project->runner->info Create debug, profile, release for flavor.
    - Edit Scheme and select the correct Build configuration for all tabs.
    - In Targets->Runner->Build Settings, search bundle indentifier and input correct Bundle ID.
    - (Only do first time) In info.plist add field "Bundle display name" With value "$(APP_DISPLAY_NAME)"
    - In Targets->Runner->Build Settings, find (Or add) user defined setting named "APP_DISPLAY_NAME" and set display name for different schemes.

4. Android setup.
    - in android->app->build.gradle add flavor (Added in "android" section under "defaultConfig"):
        flavorDimensions "app"
        productFlavors {
            flavorname {
                dimension "app"
                applicationId "dk.wejeo.restaurantorderapp.flavorname"
                versionCode 1
                versionName "1.0"
            }
            flavorname2 {
                dimension "app"
                applicationId "dk.wejeo.restaurantorderapp.flavorname2"
                versionCode 1
                versionName "1.0"
            }
        }
    
    - In android->app->src Create folders flavorName/res/values and in that folder create strings.xml with following code: (If first time also create Strings file in src->main->res->values)
        <?xml version="1.0" encoding="utf-8"?>
        <resources>
            <string name="app_name">FLAVOR DISPLAY NAME</string>
        </resources>
        
    - (Only first time) In androidManifest.xml write code inside application< ...  android:label="@string/app_name">:

5. Generate launcher icon for Flavor (Add flutter_launcher_icons dev_dependecy):
    - Create yaml "flutter_launcher_icons-flavorName.yaml" file with code: 
        flutter_icons:
            android: true
            ios: true
            image_path: "assets/flavorName/icons/appicon_flavorName.png"
            
    - run command in terminal (Replace * with yaml file name):
        flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons-flavorName.yaml

    - For iOS in targets-Runner-buildSettings, search asset and input correct icon assets for each flavor. (Asset Catalog App Icon Set Name).

    - For android //TODO change to fit different icon types.

6. Firebase setup with flavors:
    - Add firebase dependecies.
    - iOS Firebase faster build times: In Podfile: (Change "8.0.0" to relvant version: check link on code line).
        inside -> target 'Runner' do:
            pod 'FirebaseFirestore', :git => 'https://github.com/invertase/firestore-ios-sdk-frameworks.git', :tag => '8.8.0'

    - ((Not for Flavor?) if base configurations are not set...-> set all configurations to none in Xcode Project->Runner  and then pod install)

    - If error: "CocoaPods could not find compatible versions for pod "Firebase/Firestore":"
Write in terminal: "pod repo update" and then "pod install".
            
    - Initialize firebase before runApp() in main functions:
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp();

    - (iOS) Add GoogleServices-info.plist to config/flavorName/ and drag it in xcode.
    - (Android) Add google-services.json to app/src/flavorName/
    
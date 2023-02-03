# Flutter Accura Scan OCR


Accura Scan OCR is used for Optical character recognition.

Accura Scan Face Match is used for Matching 2 Faces, Source face and Target face. It matches the User Image from a Selfie vs User Image in document.

Accura Scan Authentication is used for your customer verification and authentication. Unlock the True Identity of Your Users with 3D Selfie Technology


Below steps to setup Accura Scan's SDK to your project.

## Note:-
Add `flutter_accurascan_ocr` under dependencies in your pubspec.yaml file.
**Usage**
Import flutter library into file.
`import 'package:flutter_accurascan_ocr/flutter_accurascan_ocr.dart';`

## 1.Setup Android

**Add this permissions into Android’s AndroidManifest.xml file.**

```
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature android:name="android.hardware.camera" />
<uses-feature android:name="android.hardware.camera.autofocus" />
```

**Add it in your root build.gradle at the end of repositories.**

```
allprojects {
   repositories {
       google()
       jcenter()
       maven {
           url 'https://jitpack.io'
           credentials { username 'jp_ssguccab6c5ge2l4jitaj92ek2' }
       }    
    }
}
```

**Add it in your app/build.gradle file.**

```
packagingOptions {
   pickFirst 'lib/arm64-v8a/libcrypto.so'
   pickFirst 'lib/arm64-v8a/libssl.so'
   
   pickFirst 'lib/armeabi-v7a/libcrypto.so'
   pickFirst 'lib/armeabi-v7a/libssl.so'
   
   pickFirst 'lib/x86/libcrypto.so'
   pickFirst 'lib/x86/libssl.so'
   
   pickFirst 'lib/x86_64/libcrypto.so'
   pickFirst 'lib/x86_64/libssl.so'
   
}
```

## 2.Setup iOS

1.Install Git LFS using command install `git-lfs`

2.Run `pod install`

**Add this permissions into iOS Info.plist file.**

```
<key>NSCameraUsageDescription</key>
<string>App usage camera for scan documents.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>App usage photos for get document picture.</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>App usage photos for save document picture.</string>
```

## 3.Setup Accura Scan licenses into your projects

Accura Scan has two license require for use full functionality of this library. Generate your own Accura license from here
**key.license**

This license is compulsory for this library to work. it will get all setup of accura SDK.

**For Android**

```
Create "assets" folder under app/src/main and Add license file in to assets folder.
- key.license // for Accura Scan OCR
Generate your Accura Scan license from https://accurascan.com/developer/dashboard
```
**For iOS**
```
Place both the license in your project's Runner directory, and add the licenses to the target.
```



## 4.Get license configuration from SDK. It returns all active functionalities of your license.

### Setting up License
```
  Future<void> getMetaData() async{
    try {
      await AccuraOcr.getMetaData().then((value) =>
          setupConfigData(json.decode(value)));
    }on PlatformException{}
    if (!mounted) return;
  }
```


**Error:** String

**Success:** JSON String Response = {

**countries:** Array[<CountryModels>],

**barcodes:** Array[],

**isValid:** boolean,

**isOCREnable:** boolean,

**isBarcodeEnable:** boolean,

**isBankCardEnable:** boolean,

**isMRZEnable:** boolean

}

### Setting up Configuration's,Error mssages and Scaning title messages

```
 Future<void> setAccuraConfig() async{
    try {

      await AccuraOcr.setFaceBlurPercentage(80);
      await AccuraOcr.setHologramDetection(true);
      await AccuraOcr.setLowLightTolerance(10);
      await AccuraOcr.setMotionThreshold(25);
      await AccuraOcr.setMinGlarePercentage(6);
      await AccuraOcr.setMaxGlarePercentage(99);
      await AccuraOcr.setBlurPercentage(60);
      await AccuraOcr.setCameraFacing(0);
      await AccuraOcr.isCheckPhotoCopy(false);

      await AccuraOcr.SCAN_TITLE_OCR_FRONT("Scan Front side of ");
      await AccuraOcr.SCAN_TITLE_OCR_BACK("Scan Back side of ");
      await AccuraOcr.SCAN_TITLE_OCR("Scan ");
      await AccuraOcr.SCAN_TITLE_MRZ_PDF417_FRONT("Scan Front Side of Document");
      await AccuraOcr.SCAN_TITLE_MRZ_PDF417_BACK("Scan Back Side of Document");
      await AccuraOcr.SCAN_TITLE_DLPLATE("Scan Number plate");
      await AccuraOcr.SCAN_TITLE_BARCODE("Scan Barcode");
      await AccuraOcr.SCAN_TITLE_BANKCARD("Scan BankCard");


      await AccuraOcr.ACCURA_ERROR_CODE_MOTION("Keep Document Steady");
      await AccuraOcr.ACCURA_ERROR_CODE_DOCUMENT_IN_FRAME("Keep document in frame");
      await AccuraOcr.ACCURA_ERROR_CODE_BRING_DOCUMENT_IN_FRAME("Bring card near to frame");
      await AccuraOcr.ACCURA_ERROR_CODE_PROCESSING("Processing");
      await AccuraOcr.ACCURA_ERROR_CODE_BLUR_DOCUMENT("Blur detect in document");
      await AccuraOcr.ACCURA_ERROR_CODE_FACE_BLUR("Blur detected over face");
      await AccuraOcr.ACCURA_ERROR_CODE_GLARE_DOCUMENT("Glare detect in document");
      await AccuraOcr.ACCURA_ERROR_CODE_HOLOGRAM("Hologram Detected");
      await AccuraOcr.ACCURA_ERROR_CODE_DARK_DOCUMENT("Low lighting detected");
      await AccuraOcr.ACCURA_ERROR_CODE_PHOTO_COPY_DOCUMENT("Can not accept Photo Copy Document");
      await AccuraOcr.ACCURA_ERROR_CODE_FACE("Face not detected");
      await AccuraOcr.ACCURA_ERROR_CODE_MRZ("MRZ not detected");
      await AccuraOcr.ACCURA_ERROR_CODE_PASSPORT_MRZ("Passport MRZ not detected");
      await AccuraOcr.ACCURA_ERROR_CODE_ID_MRZ("ID MRZ not detected");
      await AccuraOcr.ACCURA_ERROR_CODE_VISA_MRZ("Visa MRZ not detected");
      await AccuraOcr.ACCURA_ERROR_CODE_UPSIDE_DOWN_SIDE("Document is upside down. Place it properly");
      await AccuraOcr.ACCURA_ERROR_CODE_WRONG_SIDE("Scanning wrong side of Document");
      await AccuraOcr.isShowLogo(0);

      await AccuraOcr.setAccuraConfigs();

    }on PlatformException{}
  }
  
```

## 5.Method for scan MRZ documents.

   ```
Future<void> startMRZ() async {
 try {
   var config = [
     mrzselected,
   ];
   await AccuraOcr.startMRZ(config)
       .then((value) => {
     setState((){
       dynamic result = json.decode(value);
     })
   }).onError((error, stackTrace) => {
   });
 } on PlatformException {}
}
```

**MRZType:** String

#### value: other_mrz or passport_mrz or id_mrz or visa_mrz<br></br>

**Success:** JSON Response {

**front_data:** JSONObjects?,

**back_data:** JSONObjects?,

**type:** Recognition Type,

**face:** URI?

**front_img:** URI?

**back_img:** URI?

}

**Error:** String


## 6.Method for scan OCR documents.
   ```
Future<void> startOCR() async {
 try {
   var config = [
     widget.countrySelect['id'],
     cardSelected['id'],
     cardSelected['name'],
     cardSelected['type'],
   ];
   await AccuraOcr.startOcrWithCard(config)
       .then((value) =>
   {
     setState(() {
       dynamic result = json.decode(value);
     })
   })
       .onError((error, stackTrace) =>
   {
   });
 } on PlatformException {}
}
```

**CountryId:** integer

**value:** Id of selected country.

**CardId:** integer

**value:** Id of selected card.

**CardName:** String

**value:** Name of selected card.

**CardType:** integer

**value:** Type of selected card.

**Success:** JSON Response {
}

**Error:** String



## 7.Method for scan bankcard.

   ```
Future<void> startBankCard() async{
   
 try{
   await AccuraOcr.startBankCard().then((value) => {
     setState((){
       dynamic result = json.decode(value);
     })
   });
 }on PlatformException{}
}
   ```

**Success:** JSON Response {
}

**Error:** String


Contributing
See the contributing guide to learn how to contribute to the repository and the development workflow.

License:
MIT


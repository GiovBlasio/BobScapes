plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")

}

import java.util.Properties

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties().apply {
    load(keystorePropertiesFile.inputStream())
}

android {
    compileSdk = 35
    ndkVersion = "27.0.12077973"
    namespace = "com.fergusonlynchllc.bobscapes"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.fergusonlynchllc.bobscapes"
        minSdk = 21
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
        keyAlias = keystoreProperties["keyAlias"] as String?
        keyPassword = keystoreProperties["keyPassword"] as String?
        storeFile = keystoreProperties["storeFile"]?.let { file(it as String) }
        storePassword = keystoreProperties["storePassword"] as String?
    }
        // release {
        //     keyAlias = keystoreProperties['keyAlias']
        //     keyPassword = keystoreProperties['keyPassword']
        //     // storeFile = keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        //     storeFile = if (keystoreProperties["storeFile"] != null) {
        //         file(keystoreProperties["storeFile"] as String)
        //     } else {
        //         null
        //     }
        //     storePassword = keystoreProperties['storePassword']
        // }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
             isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.core:core-ktx:1.13.1")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.7.0")
    implementation("androidx.activity:activity-ktx:1.8.1")
    implementation("androidx.fragment:fragment-ktx:1.7.1")
    implementation(platform("com.google.firebase:firebase-bom:32.0.0"))
    implementation("com.google.firebase:firebase-analytics")
}

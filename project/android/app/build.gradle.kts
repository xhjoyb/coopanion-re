plugins {
    id("com.android.application")
}

android {
    namespace = "com.palai.prootsmoke"
    compileSdk = 35

    defaultConfig {
        applicationId = "com.palai.prootsmoke"
        minSdk = 24
        targetSdk = 35
        versionCode = 1271
        versionName = "12.71"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }

    lint {
        abortOnError = false
        checkReleaseBuilds = false
    }
}

dependencies {
    // 原包无第三方依赖，全部使用 android.jar + JDK 内置类
}

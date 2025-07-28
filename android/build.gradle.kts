buildscript {
    val kotlin_version by extra("2.2.0")

    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:8.1.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version")
        classpath("com.google.gms:google-services:4.3.15")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Imposta la directory di build personalizzata per il root project
val newBuildDir = rootProject.projectDir.resolve("../build")
rootProject.buildDir = newBuildDir

subprojects {
    buildDir = rootProject.buildDir.resolve(project.name)
    evaluationDependsOn(":app")
}

// Task clean per eliminare la directory build
tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}

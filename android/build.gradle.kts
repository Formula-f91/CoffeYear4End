allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

subprojects {
    configurations.all {
        resolutionStrategy {
            force("androidx.core:core:1.13.1")
            force("androidx.core:core-ktx:1.13.1")
            force("androidx.activity:activity:1.9.3")
            force("androidx.navigationevent:navigationevent-android:1.0.0-alpha01")
            
            force("androidx.lifecycle:lifecycle-runtime:2.8.4")
            force("androidx.lifecycle:lifecycle-viewmodel:2.8.4")
            force("androidx.lifecycle:lifecycle-common:2.8.4")
        }
    }

    // แก้ปัญหา "Namespace not specified" ให้กับโมดูลอื่นๆ อัตโนมัติ
    plugins.withType<com.android.build.gradle.api.AndroidBasePlugin> {
        extensions.configure<com.android.build.gradle.BaseExtension> {
            if (namespace == null) {
                namespace = project.group.toString()
            }
        }
    }
}
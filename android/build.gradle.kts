allprojects {
    // comment: Configure repositories, prefer IPv4, and force resolution strategy to fix customview and annotation transform errors.
    repositories {
        System.setProperty("java.net.preferIPv4Stack", "true")
        google()
        mavenCentral()
        maven(url = "https://maven.google.com")
        maven(url = "https://jitpack.io")
    }

    configurations.all {
        resolutionStrategy {
            force("androidx.customview:customview:1.1.0")
            force("androidx.annotation:annotation:1.9.0")
        }
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
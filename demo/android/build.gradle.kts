<<<<<<< HEAD
=======
buildscript{
    repositories{
        google()
        mavenCentral()
    }
    dependencies{
        classpath("com.google.gms:google-services:4.3.15")
    }
}

>>>>>>> 89f70c0f0ca5889202553f4504723363d59b1deb
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

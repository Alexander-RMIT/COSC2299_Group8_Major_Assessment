# RMIT SEPT 2022 Major Project

# Group 8

## Members
* Alexander (s3895606)
* Weixi Guan (s3830776)
* Ethan (s3902240)
* Pak Yin Lai (s3827212)
* Rylan (s3896416)

## Records

* GitHub repository :https://github.com/Alexander-RMIT/COSC2299_Group8_Major_Assessment.git
* Jira Board : https://sept-group8.atlassian.net/jira/software/projects/A1/boards/1
* Discord : No link due to Discord invite link being expired in 24hrs.
* Heroku BackEnd: https://neighborhood-doctors-backend.herokuapp.com/

## System Requirements
- Java JDK 11 (Recommanded) or above
- Installed Maven (User Variable Path & System Variable Path)
- Installed MySQL WorkBench 8.0 CE application
- Installed Android Studio
- Installed an emulator (Recommanded: Pixel XL API 31 with Android 12.0 | x86_64, storage: ≥1024MB)
- Installed Postman (Optional)
- Installed Docker
- Installed VS Code or any other IDE
- Have a MySQL database server running on your local machine (Port: 3306, username: root, password: root)
- Have a schema named "neighborhood_doctors" created in your MySQL database server

## How to run?
* Method 1 - Original
1. Clone the repository
2. Switch to the `feature` branch
3. Open folder Backend/neighborhood_doctor in VS Code and run the backend
4. Open Android Studio and create an emulator
5. Run the app on the emulator in Android Studio
6. Run backend application in VS Code
7. Enjoy the app!

* Method 2 - Docker
1. Do step 1 to 5 from Method 1
2. In VS Code, open the terminal and type `mvn clean install` (Make sure you have Maven installed)
3. Open CMD as administrator
4. (CMD as Admin) Run `cd <Your_directory>/COSC2299_Group8_Major_Assessment/Backend/neighborhood_doctor` to go to the backend folder
5. (CMD as Admin) Run `docker network create spring-net` to create a network bridge 
6. (CMD as Admin) Run `docker-compose build` to build the docker image, MySQL database and the backend application
7. Before running the images to the containers, make sure your port 3306 is not occupied by any other applications
8. (CMD as Admin) Run `docker-compose up` to run the docker image to two different containers
9. Enjoy the app!

## Code documentation - v0.1.0 - Sept 20th, 2022
* Users are welcomed personally upon logging into the application
* Users can enter Neighborhood_Doctor app
* Users can sign up account as patient
* Users can sign in account as administrator, doctor and patient
* Users can sign out their account
* Administrators can create new administrator, doctor and patient accounts
* Doctors can view patient's health information
* Doctors can view patient's symptoms
* Doctors can view patient status
* Doctors can change their availability
* Doctors can set up their availability
* Doctors can enter chat session
* Patients can enter chat session
* Patients can view their health information
* Patients can enter their symptoms
* Patients can view their symptoms
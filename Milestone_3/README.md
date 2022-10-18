# MILESTONE 3 - Group 8

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

## Branches description
- The difference between `feature` and `deploy` is that `feature` is the branch that we use to develop the feature, and `deploy` is the branch that we use to deploy the feature to the production environment. The reason why we use two branches is that we want to make sure that the feature is stable before we deploy it to the production environment. Also, for the `feature` branch, Flutter is using `http://10.0.2.2:8080/` but `https://neighborhood-doctors-backend.herokuapp.com/` is used for the Flutter in `deploy` branch.
- The `main` branch is the branch that we use to upload all milestones required files.

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

* Method 3 - Using Cloud Services
BackEnd - Spring Boot Application
1. Switch to the `deploy` branch
2. We use [Heroku](https://dashboard.heroku.com/apps) to deploy our BackEnd Server using MySQL database.
3. Add-on ClearDB in order to use MySQL database.
4. Click this [Link](https://neighborhood-doctors-backend.herokuapp.com/) to our BackEnd Website. \

FrontEnd - Flutter Application
1. [![Codemagic build status](https://api.codemagic.io/apps/634e6f35816f0ccc02af928f/634e6f35816f0ccc02af928e/status_badge.svg)](https://codemagic.io/apps/634e6f35816f0ccc02af928f/634e6f35816f0ccc02af928e/latest_build)
2. We use [codemagic](https://codemagic.io/start/) Flutter/mobile app host to deploy our App, support both Android and iOS.
3. Click this [Link](https://codemagic.io/app/634e6f35816f0ccc02af928f/build/634e801822ff8d39234d73d4) to download our App and install on your local machine.
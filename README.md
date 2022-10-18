# RMIT SEPT 2022 Major Project [deploy]

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

## How do we deploy?
* BackEnd - Spring Boot Application
- We use [Heroku](https://dashboard.heroku.com/apps) to deploy our BackEnd Server using MySQL database.
- Add-on ClearDB in order to use MySQL database.
- Click this [Link](https://neighborhood-doctors-backend.herokuapp.com/) to our BackEnd Website.

* FrontEnd - Flutter Application
- [![Codemagic build status](https://api.codemagic.io/apps/634e6f35816f0ccc02af928f/634e6f35816f0ccc02af928e/status_badge.svg)](https://codemagic.io/apps/634e6f35816f0ccc02af928f/634e6f35816f0ccc02af928e/latest_build)
- We use [codemagic](https://codemagic.io/start/) Flutter/mobile app host to deploy our App, support both Android and iOS.
- Click this [Link](https://codemagic.io/app/634e6f35816f0ccc02af928f/build/634e801822ff8d39234d73d4) to download our App and install on your local machine.

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
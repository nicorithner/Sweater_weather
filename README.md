# Sweater Weather

![](https://img.shields.io/badge/Rails-6.0.3.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=4e03fc) ![](https://img.shields.io/badge/Ruby-2.5.3-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=fc0324) ![Badge](https://marcgrimme.github.io/simplecov-small-badge/badges/coverage_badge_total.svg) 

## Table of Contents

- [Overview](#overview)

<hr>

## Overview
<p align="left">
This Turing Module 3 project provides the developer with a series of wireframes and instructions to produce endpoints that the project front-end developers (ficticious) could use.
Using request such as `GET /api/v1/forecast?location=denver,co` the app can

* retrieve the weather for a city, 
* retrieve a background image for that city, 
* register and user, 
* log an existing user and 
* plan a road trip (duration of the trip and weather at arrival)
</p>

<br/>

<p align="center">
<img src="wireframe_example.png" width="400">
<p>

<p align="left">
The projects asks to using T.D.D. (test driven development) to develop the project functionality. Gems such as **simplecov**, **webmock**, and **vcr**, among others help us drive this process.
The testing requirements expected 'sad path' path testing along with functionality. This means to test for when the user doesn't do what is expected. For example, entering the wrong password or omitting the confirmation password.
</p>

<img align="right" src="json_example.png" width="300">



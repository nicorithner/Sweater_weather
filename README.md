# Sweater Weather

<div align="center">
  <p><strong>An API Rails App Project</strong></p>
  <p> Backend Development - Cohort 2006</p>
  <small>Nico Rithner - 2020</small>
</div>

## Table of Contents

- [Overview](#overview)
- [Specifications](#specifications)

## Overview

[Sweater Weather](https://backend.turing.io/module3/projects/sweater_weather/requirements) is a Turing Module 3 project that provides the developer with a series of wireframes and instructions to produce endpoints that the project front-end developers (ficticious) could use.
Using request such as `GET /api/v1/forecast?location=denver,co` the app can

- retrieve the weather for a city,
- retrieve a background image for that city,
- register and user,
- log an existing user and
- plan a road trip (duration of the trip and weather at arrival)

<br/>

<p align="center">
<img src="wireframe_example.png" width="500"><br/>
<small>sample wireframe</small>
<p>

<p align="left">
The projects asks to using T.D.D. (test driven development) to develop the project functionality. Gems such as **simplecov**, **webmock**, and **vcr**, among others help us drive this process.
The testing requirements expected 'sad path' path testing along with functionality. This means to test for when the user doesn't do what is expected. For example, entering the wrong password or omitting the confirmation password.
</p>

<p align="center">
<img src="json_example.png" width="350"><br/>
<small>sample json</small>
</p>

<hr>

## Specifications

![](https://img.shields.io/badge/Rails-6.0.3.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=4e03fc) ![](https://img.shields.io/badge/Ruby-2.5.3-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=fc0324) ![Badge](https://marcgrimme.github.io/simplecov-small-badge/badges/coverage_badge_total.svg) 

This project runs on `Rails: 6.0.34` and `Ruby: 2.5.3`<br/>

To check your current versions, run:
```ruby
$ ruby -v
ruby 2.5.3p105 (2018-10-18 revision 65156) [x86_64-darwin19]
$ rails -v
Rails 6.0.3.4
```

### Gems

This project uses the following additional gems:<br/>
You can find the most current version at [Rubygems.org](https://rubygems.org/)

#### Production

<ul>
<li><a href="https://rubygems.org/gems/bcrypt">bcrypt:</a> <small> The bcrypt Ruby gem provides a simple wrapper for safely handling passwords.</small></li>
<li><a href="https://rubygems.org/gems/faraday">faraday:</a> <small>HTTP/REST API client library</small></li>
<li><a href="https://rubygems.org/gems/figaro">figaro:</a> <small>Simple, Heroku-friendly Rails app configuration using ENV and a single YAML file</small></li>
<li><a href="https://rubygems.org/gems/jsonapi-serializer">jsonapi-serializer:</a> <small>Fast, simple and easy to use JSON:API serialization library (also known as fast_jsonapi).</small></li>
</ul>

#### Test and Development

<ul>
<li><a href="https://rubygems.org/gems/pry">pry:</a> <small>Pry is a runtime developer console and IRB alternative that attempts to bring REPL driven programming to the Ruby language </small></li>
<li><a href="https://rubygems.org/gems/rspec-rails">rspec-rails:</a> <small>rspec-rails is a testing framework for Rails 5+</small></li>
<li><a href="https://rubygems.org/gems/rubocop">rubocop:</a> <small>RuboCop is a Ruby code style checking and code formatting tool. It aims to enforce the community-driven Ruby Style Guide.</small></li>
<li><a href="https://rubygems.org/gems/simplecov">simplecov:</a> <small>Code coverage for Ruby with a powerful configuration library and automatic merging of coverage across test suites</small></li>
<li><a href="https://rubygems.org/gems/shoulda-matchers">shoulda-matchers:</a> <small>Shoulda Matchers provides RSpec compatible one-liners to test common Rails functionality</small></li>
<li><a href="https://rubygems.org/gems/webmock">webmock:</a> <small>WebMock allows stubbing HTTP requests and setting expectations on HTTP requests.</small></li>
<li><a href="https://rubygems.org/gems/vcr">vcr:</a> <small>Record your test suite's HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests</small></li>
</ul>

### APIs

In this project we used the following APIs:

<ul>
<li><a href="https://openweathermap.org/appid">OpenWeather:</a> <small> Weather information for any location on the globe. Some apis are paid. We used OneCall </small></li>
<li><a href="https://developer.mapquest.com/user/me/apps">MapQuest Developer:</a> <small> Mapping, Geocoding, Directions, and Search provider. Free and paid APIs</small></li>
<li><a href="https://pixabay.com/service/about/api/">Pixabay Developer API:</a> <small> Access to over 2.1 million photos, illustrations, vector graphics, and videos.</small></li>
</ul>

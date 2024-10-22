# Appointments App

This is a simple appointments web app for small businesses.    
[![Build Status](https://app.travis-ci.com/UribeNelson/nu-appointments.svg?branch=master)](https://app.travis-ci.com/UribeNelson/nu-appointments)
[![Ruby on Rails CI](https://github.com/UribeNelson/nu-appointments/actions/workflows/rubyonrails.yml/badge.svg)](https://github.com/UribeNelson/nu-appointments/actions/workflows/rubyonrails.yml)
[![Fly Deploy](https://github.com/UribeNelson/nu-appointments/actions/workflows/main.yml/badge.svg)](https://github.com/UribeNelson/nu-appointments/actions/workflows/main.yml)

It's being developed using:

* Ruby 3.0.2
* Yarn 1.22.10
* Postgresql 13.2

If you want to run it locally, make sure to set your local Postgresql credentials inside the development section of `config/database.yml` before running the db commands:

1. `bundle install` for ruby dependencies
2. `yarn` for node dependencies
3. `rails db:create` to create the database
4. `rails db:migrate` to apply database migrations
5. finally `rails s` to run the app

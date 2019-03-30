# README
[![Build Status](https://travis-ci.com/GreatHearts/giving_profiles.svg?branch=master)](https://travis-ci.com/GreatHearts/giving_profiles)

## Setup
In the folder where you cloned the project:
1. `bundle`
1. `rails db:create`
1. `rails db:migrate`
1. `rails db:seed`
1. `rails server` or simply `rails s`

## Checks
Run the following rake tasks before committing. By default the linter will run RuboCop w/ autocorrect.
* To run all tasks: `rails check`
* To run just RuboCop: `rails check:lint`
* To run RuboCop w/o autocorrect: `rails check:lint:no_fix`

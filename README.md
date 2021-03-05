# RPG Character Tracker

RPG (Role Playing Game) Character Tracker is a web app for a group of players to keep track of their party's equipment and notes about their campaign. All personal equipment and notes can be viewed on your user page and there is also a page to view entire party's equipment all all notes entered by anyone.

Because some notes and equipment are private you can also denote notes and equipment as private. These notes and equipment will only show up to the user (both on their homepage and on the party list). Secrets can make role playing more fun!

## Summary

  - [Installation](#Installation)
  - [Validations](#Validations)
  - [Gems Used](#gems-used)
  - [Contributing](#contributing)
  - [Authors](#authors)
  - [License](#license)
  - [Acknowledgments](#acknowledgments)

## Installation

Clone this repository.

Install the gems:

    $ bundle install

Migrate Databases:
    
    $ rake db:migrate

Add Seed Data (if you want data pre-loaded for testing):

    $rake db:seed

Run shotgun:

    $ shogtun

Go to local web page: http://localhost:9393/

Create a sign up or use any of the seed users. All passwords for seed users are simply: 123

Seed Users: Syracuse, Michigan, Texas, Seattle, NYC

## Validations

Usernames must be letters and numbers only. No spaces or special characters.
Usernames can not be used more than once and you can not duplicate a user with the same username but in a different case.
Notes can not be saved if they are blank.
Equipment can not be saved if their name or quantity is blank. In addition quantity must be an integer.
After you sign up you will be sent to a Character Update page. You must enter a Character Name before you can view your character. This can be changed at anytime (your username can not be changed).

## Gems Used

This code uses a number of gems, which all will install when you run the bundle install command:

    $ 'sinatra'
    $ 'activerecord', '~> 5.2'
    $ 'sinatra-activerecord', :require => 'sinatra/activerecord'
    $ 'rake'
    $ 'require_all'
    $ 'sqlite3', '~> 1.3.6'
    $ 'thin'
    $ 'shotgun'
    $ 'pry'
    $ 'bcrypt'
    $ 'tux'
    $ 'sinatra-flash'

## Contributing

Original Code was written by the author, Kevin Hines.

## Authors

  - Kevin Hines

    github: [kevhines](https://github.com/kevhines/)

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.md).

## Acknowledgments

- Thanks to Annabel Wilmerding
- Thanks to my classmates
- Thanks to my college friends who got me to play D&D with them
- Thanks to The Flatiron School
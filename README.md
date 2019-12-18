Ruby Rails Project for CSC-324 Software Design and Development

Imagine Grinnell Giving Gardens

![](https://github.com/CSC322-Grinnell/imagine-grinnell/workflows/Unit%20Tests/badge.svg)
![](https://github.com/CSC322-Grinnell/imagine-grinnell/workflows/Linting/badge.svg)

# Running on your machine
1. Install Docker [[link]](https://docs.docker.com/install/)
  - Windows note: you to want to make sure the drive that you have *this folder* in available for bind mounts. Google *docker bind mount windows* for more information. This is required in order to "hot reload" the rails code.
2. Run `docker-compose run rails bin/initialize.sh` to initialize the database
3. Run `docker-compose up`
4. Visit `http://localhost:3000/` in your browser of choice.

## Running tests
Run `docker-compose run rails bin/test.sh`

## Linting

Code style for ruby, javascript, and css/scss files can be checked with `docker-compose run rails bin/lint.sh`.
This is done automatically on pushes to master and pull requests on master, and will show an error if any linting fails.
Some style errors can be automatically fixed with `docker-compose run rails bin/lint.sh --fix`.
These three file types are handled by three different programs, described below:

### Javascript
The javascript in this code has style defined in `.eslintrc` for [eslint](https://eslint.org/), which can be tested with `docker-compose run rails bin/lint.sh --js`.
Automatic fixes can be attempted for some problems with `docker-compose run rails bin/lint.sh --js --fix`.

### CSS
The css and scss files in this repository have styling defined in `.stylelintrc.yml`, based on [these](https://github.com/stylelint/stylelint-config-standard) defaults.
These files can be checked with `docker-compose run rails bin/lint.sh --css`.
Automatic fixes can be attempted for some problems with `docker-compose run rails bin/lint.sh --css --fix`.

### Ruby
Ruby linting is handled by [rubocop](https://www.rubocop.org/en/stable/), with configuration defined in `.rubocop.yml`.
Rubocop can be run with `docker-compose run rails bin/lint.sh --ruby`.
Automatic fixes can be attempted for some problems with `docker-compose run rails bin/lint.sh --ruby --fix`.

# Docker
See [Docker.md](./Docker.md). Read it. Seriously.

# Adding code to this repository / Git style
See the [`Contributing.md`](Contributing.md) file.

# Spring 2019 Readme:

This is the code for creation of the giving gardens webpage associated with Imagine Grinnell.
Documentation for the API can be found when the project is ran at /api-docs.
The documentation utilized Swagger.


DB Seed data can be found at /db/seed_data/

To change the Swagger documentation:

Change the specs at /spec/"spec you want to change".

```
rake rswag:specs:swaggerize
```

Last Active Group: Spring 2019
For Next Group:
Fully develop and fix test cases

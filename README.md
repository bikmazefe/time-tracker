# Time Tracker

## What is this?

This is a simple time tracking app inspired by the core functionalities of Toggl. It allows users to use either the timer mode or the manual mode to enter their time entries and offers various reporting features for admins.

## Install

### Clone the repository

```shell
git clone git@github.com:bikmazefe/time-tracker.git
cd time-tracker
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle && yarn
```

### Initialize the database

```shell
rails db:create db:migrate db:seed
```

## Serve

```shell
rails s
```

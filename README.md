# README

This is a Rails 5.0 based web service that performs queries on DRIVER platform imported data and computes the risk factor for a GPS point based on DRIVER crash data.

# REQUIREMENTS

* ruby 2.3.1
* MySQL

# INSTALLATION NOTES

1. Check out this project and setup rails

```
bundle
rake db:setup
rake db:migrate
```

2. Sign up to https://roadsafety.gov.ph and get a token. Update the .env file and
  edit in the token you obtained

3. Seed your data with the DRIVER data:

```
rake populate:start
```

4. Start the server

```
rails s
```

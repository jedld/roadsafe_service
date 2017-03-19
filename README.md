# README

This is a project I started for the Road Safety Idea Hack 2017 I joined in March 18, 2017
at crowne plaza, ortigas, manila.

This a free and opensource Rails 5.0 based web service that performs queries on DRIVER platform imported data and computes the risk factor for a GPS point based on DRIVER crash data.

The DRIVER platform is a service provided by the Philippine Department of Transportation
with the partnership of World Bank and other private companies for reporting and
exposing anonymized crash data. For more information on the DRIVER platfrom see here:

 https://github.com/WorldBank-Transport/DRIVER
 https://github.com/WorldBank-Transport/DRIVER/blob/master/doc/api-use-case-health-organization.md


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

3. Seed your data with the DRIVER data (You may want to edit this file so that
it queries your preferred date range):

```
rake populate:start
```

4. Start the server

```
rails s
```

5. Test if it works

curl https://localhost:3000/stats?lng=121.0299718&lat=14.5507138&radius=2&hour=11

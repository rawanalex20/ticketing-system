# Description

Ticketing System is a simple ticketing web application developed in rails that enables users to create projects, create and update tickets, and grant access for other users to projects. Ticket can have status either todo, in progress or done. Project is shared via email and user invited can access it. Due date can be set once and whenever it is set an active job is scheduled to run on that due date and then check if its status is done or not and if it's not done yet a reminder email is sent to all users sharing this project to remind them of ticket due.

# Getting Started

## Live app

App is deployed on heruko server:

[https://ticketng-system.herokuapp.com/](https://ticketng-system.herokuapp.com/)

## Local Setup

For running on local server run the following command in the root directory to install all required gems
`bundle install`, then
`rails server`

## Database

Postgres is used for database. To run on local environment edit configurations in **database.yml** with your database name, username, password and other needed info to match your local porstgres server information. You can change it to your desired adapter with another configuration if you are using different dbms.

## Dependencies

Required for development ruby, rails, node, npm, yarn and postgres to be installed.

Other gems are used in project such as active_storage, devise for authentication, aws-sdk-s3 if you are storing files on amazon and rspec for unit testing.

## Mailing

Emails are configured with smtp and sent on gmail. Production configurations uses values of email and app password of environment variables set on heroku,[https://devcenter.heroku.com/articles/config-vars](https://devcenter.heroku.com/articles/config-vars). In development configuration email and application password is left for security. You can write your own email and app password in environment variables. It is recommended to use 2 factor authentication and generate app password instead of original password for your account. For more information: [https://guides.rubyonrails.org/action_mailer_basics.html#action-mailer-configuration-for-gmail](https://guides.rubyonrails.org/action_mailer_basics.html#action-mailer-configuration-for-gmail)

## Storage

The app uses local storage so you can view pictures and files only if they are stored on your local machine. To use a3 storage or any other service add configurations for this service and write your credetentials. [https://edgeguides.rubyonrails.org/active_storage_overview.html#setup](https://edgeguides.rubyonrails.org/active_storage_overview.html#setup)

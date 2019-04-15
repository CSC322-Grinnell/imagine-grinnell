Ruby Rails Project for CSC-324 Software Design and Development

Imagine Grinnell Giving Gardens

This is the code for creation of the giving gardens webpage associated with Imagine Grinnell.
Documentation for the API can be found when the project is ran at /api-docs.
The documentation utilized Swagger.

DB and Documentation Rake Commands
To change the DB settings:
    Change the code.
    rake db:drop
    rake db:migrate
    rake db:seed
    DB Seed data can be found at /db/seed_data/
    
To change the Swagger documentation:
    Change the specs at /spec/"spec you want to change".
    rake rswag:specs:swaggerize
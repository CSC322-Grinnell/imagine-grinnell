Ruby Rails Project for CSC-324 Software Design and Development

Imagine Grinnell Giving Gardens

# Running on your machine
1. Install Docker [[link]](https://docs.docker.com/install/)
  - Windows note: you to want to make sure the drive that you have *this folder* in available for bind mounts. Google *docker bind mount windows* for more information. This is required in order to "hot reload" the rails code.
2. Run `docker-compose run rails bin/initialize.sh` to initialize the database
3. Run `docker-compose up`
4. Visit `http://localhost:3000/` in your browser of choice.

## What is this docker thing?
The short of it: docker makes it very easy to reproduce environments for running software.
It does this by providing a declarative way of defining most of a linux machine in a single file, called a `Dockerfile` [[documentation]](https://docs.docker.com/engine/reference/builder/), that can then be *built* into a *image*.
These *images* can then be copied to any machine with docker installed, and instantiated as *containers*.
Every *container* instantiated from the same *image* will run as exactly the same environment as every other one, which entirely removes the problem of setting up various pieces of software on a machine by machine basis.
Install docker, and you can run any software with a docker image built for it.

Note that we do not pass images around when developing, but instead just the `Dockerfile`s.
This is the case for two reasons:
1. Docker images are large, and annoying to check into source control
2. Docker images can be derived from `Dockerfile`s in a *mostly* reproducible manner.

Now, the `docker` base program does not provide the most user-friendly ways to keep track of images, containers, and volumes (persistent storage) for projects, hence the existence of `docker-compose`.

### Brief overview of docker-compose

What `docker-compose` does best is allow you to simply define the externalities and dependencies of a service (running in a *container*), for a given project.
In our case this encompasses:
 - Network connections
 - Other services (running in other containers)
 - Persistent storage

Docker-compose finds these in a `docker-compose.yml` file [[documentation]](https://docs.docker.com/compose/compose-file/), and then creates an environment to the specifications defined in `docker-compose.yml`.

### Abbreviated command line reference, in order of usefulness

Note: all `docker-compose` commands recursively search up through parent directories for a `docker-compose.yml` file, so they can be run from any directory under the project root.

#### `docker-compose up`
Runs the project.

First, it checks that you have images for the services defined in `docker-compose.yml`, and fetches/builds them if not.
It then starts all of the services (rails, db) and keeps them running until you press control c.
Note that it does *not* check if `Dockerfiles` have been changed, and that they will have to be manually rebuilt into images with `docker-compose build` or the `--build` flag.

#### `docker-compose run [service] [command]`
Runs `[command]` in the container associated with service `[service]`, with all of `[service]`'s dependencies up.
Has similar constraints to `docker-compose up` with regards to rebuilding images.

Some useful derivatives include:
 - `docker-compose run rails bash` - pulls up a bash shell in the rails container. Great for troubleshooting
 - `docker-compose run db bash` - pulls up a bash shell in the postgres container. Useful if you need direct access to the database.
 - `docker-compose run rails bin/initialize.sh` - runs the initialization script
 - `docker-compose run rails rake db:migrate` - migrate the database
 - `docker-compose run rails bundle [...]` - Run a bundle command. Note that you'll need to rebuild the rails image after doing this, as the only changes that will persist are those to the `Gemfile` and `Gemfile.lock`.

#### `docker-compose build [service]`
Rebuilds the image associated with `[service]`. In our case we really only care about the case where `[service]` is `rails`.
Required after updates to the `Dockerfile`, `Gemfile`, or `Gemfile.lock`.

#### `docker ps`
Lists all currently running containers, anywhere on your system.

#### `docker-compose down`
Stops the docker-compose process in the current folder.

#### `docker stop [container identifier]`
 Stops the container referenced by `[container identifier]`. In general you're going to want to copy that id from the output of `docker ps`

### Common pitfalls
 - You can only have only one functional `docker-compose` process per `docker-compose.yml`.
Doing so, however, will not break everything outright, but only cause a host of weirdness, usually manifesting as your code not running in your browser, the database not appearing to change, or your changes in your text editor not showing up in the container.
Note that also occurs when includes running `docker-compose run` and `docker-compose up` concurrently.
 - Changes to a container's file system will not stick around between executions unless explicitly persisted through a bind mount to the host filesystem, or a volume.
The most common manifestation of this is that `bundle` commands run inside a container will not appear to change anything, but there are numerous other things that you may want to do involving changes to the filesystem outside of this folder. Just know that doing so requires at minimum rebuilding the relevant image.

# Resetting things
 - If you accidentally have multiple copies of `docker-compose` running in this directory, `docker-compose down` will clean them up. Usually happens for me when I have a terminal window I forgot about, and get errors about ports already being bound.
 - To reset your databases to their initial state, run `docker-compose run rails bin/initialize.sh -R`
 - To rebuild the rails docker image, run `docker-compose build rails`
 - To do a hard removal of all docker information, you can run `docker container prune`, `docker image prune`, and `docker volume prune`. May be a good idea if you are running out of disk space.

# Adding code to this repository / Git style
See the [`Contributing.md`](Contributing.md) file.

# Old README as I am not to change anything

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

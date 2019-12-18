# Docker
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

## Why would you use such a crazy thing?
First, a blatant appeal to authority: Containers are huge in Real IT™.
As one example, Google uses them extensively enough that they wrote [Kubernetes](https://www.redhat.com/en/topics/containers/what-is-kubernetes), and according to the same article all of their software runs in containers.
Experience with the technology will be something that many employers will be happy to see.

As for why we decided to use it, there were a few small reasons:
 - Using docker makes it near trivial to use postgresql on developer machines instead of SQLite. Normally this is a pain in the a%%.
 - Everyone has the same version of ruby and bundle,

### Some random articles on the matter
 - [What is docker and why is it so darn popular](https://www.zdnet.com/article/what-is-docker-and-why-is-it-so-darn-popular/)
 - [When not to use docker](https://www.channelfutures.com/open-source/when-not-to-use-docker-understanding-the-limitations-of-containers)
 - [Wikipedia](https://en.wikipedia.org/wiki/Docker_(software))

## Abbreviated command line reference, in order of usefulness

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
 - `docker-compose run rails rails console` - Run rails console in the rails container.
    Note the fact that you have to type rails twice; the first to say which container to run in, the second as the first part of the command `rails console`
 - `docker-compose run db bash` - pulls up a bash shell in the postgres container. Useful if you need direct access to the database.
 - `docker-compose run rails bin/initialize.sh` - runs the initialization script
 - `docker-compose run rails rake db:migrate` - migrate the database
 - `docker-compose run rails bundle [...]` - Run a bundle command. Note that you'll need to rebuild the rails image after doing this, as the only changes that will persist are those to the `Gemfile` and `Gemfile.lock`.

#### `docker-compose exec [service] [command]`
Runs `[command]` in the *currently running* container for `[service]`.
Basically the same as `docker-compose run`, but it attaches to a container that is currently running instead of spinning up a new one.

This command has the following advantages over `docker-compose run`:
 - Doesn't require spinning up a new, separate, container to run commands, which can take a second.
 - `docker-compose exec rails bash` gives a shell with actual complete access to the environment of the rails server if `docker-compose up` is running
 - Guarantees access to the same docker volumes that `docker-compose up` uses. If `docker-compose up` is running, and you run `docker-compose run rails bash`, the two processes can have entirely different ideas of what the database looks like, as well as the folders with mounts defined in [docker-compose.yml](./docker-compose.yml).

#### `docker-compose build [service]`
Rebuilds the image associated with `[service]`. In our case we really only care about the case where `[service]` is `rails`.
Required after updates to the `Dockerfile`, `Gemfile`, or `Gemfile.lock`.

#### `docker ps`
Lists all currently running containers, anywhere on your system.

#### `docker-compose down`
Stops the docker-compose process in the current folder.

#### `docker-compose down -v`
Stops the docker-compose processes in the current folder, *and removes all volumes*.
This command is notable as it fixes the 'yarn integrity check failed' error with rails, at the cost of losing the current database (and therefore needing re-initialization).

#### `docker stop [container identifier]`
 Stops the container referenced by `[container identifier]`. In general you're going to want to copy that id from the output of `docker ps`

### Common pitfalls
 - You can only have only one functional `docker-compose` process per `docker-compose.yml`.
Doing so, however, will not break everything outright, but only cause a host of weirdness, usually manifesting as your code not running in your browser, the database not appearing to change, or your changes in your text editor not showing up in the container.
Note that also occurs when includes running `docker-compose run` and `docker-compose up` concurrently.
 - Changes to a container's file system will not stick around between executions unless explicitly persisted through a bind mount to the host filesystem, or a volume.
The most common manifestation of this is that `bundle` commands run inside a container will not appear to change anything, but there are numerous other things that you may want to do involving changes to the filesystem outside of this folder. Just know that doing so requires at minimum rebuilding the relevant image.
 - Anonymous volumes (i.e. node_modules) usually persist after `docker-compose build rails` is run, and *will override the state of the filesystem created by docker-compose build*. This means that you will sometimes need to remove all volumes with `docker-compose down -v`
# Resetting things
 - If you accidentally have multiple copies of `docker-compose` running in this directory, `docker-compose down` will clean them up. Usually happens for me when I have a terminal window I forgot about, and get errors about ports already being bound.
 - To reset your databases to their initial state, run `docker-compose run rails bin/initialize.sh -R`. If that doesn't work, run `docker-compose down -v` and then `docker-compose run rails bin/initialize.sh -R`.
 - To rebuild the rails docker image, run `docker-compose build rails`.
 - To do a hard removal of all docker information, you can run `bin/nuke-docker.sh` *on your host machine*. May be a good idea if you are running out of disk space. On windows this script will not work, but there are comments at the top of the script describing how to achieve the same effect on windows.

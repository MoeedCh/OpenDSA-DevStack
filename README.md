Setting up the OpenDSA Development Environment (OpenDSA-DevStack)
=================================================================

## NEW Full Instructions:

1. Install [Docker](https://docs.docker.com/get-docker/).  It is the only requirement, and it runs on just about every platform. [Docker Troubleshooting](https://github.com/OpenDSA/OpenDSA-DevStack/edit/documentationUpdates/README.md#docker-issues)
2. Clone this repostory.  Download could work too. 
3. Run the setup for your projects: `docker-compose run setup make <<service>>`
   - The service name will match the `up` Docker command, listed in the projects table below.
4. Spin up your service: `docker-compose up <<service>>`
   - If you are using code-workout and/or opendsa-lti, you should also initialize their databases with: `docker-compose exec opendsa-lti rake db:populate` or `docker-compose exec code-workout rake db:create db:populate`
5. Go to your service's URL

### OpenDSA Projects:

| Repository                                             | Docker command                   | Service's URL after `up` command              |
|--------------------------------------------------------|----------------------------------|-----------------------------------------------|
| [OpenDSA](https://github.com/OpenDSA/OpenDSA)          | `docker-compose up opendsa`      | https://opendsa.localhost.devcom.vt.edu/      |
| [OpenDSA-LTI](https://github.com/OpenDSA/OpenDSA-LTI)  | `docker-compose up opendsa-lti`  | https://opendsa-lti.localhost.devcom.vt.edu/  |
| [CodeWorkout](https://github.com/web-cat/code-workout) | `docker-compose up code-workout` | https://code-workout.localhost.devcom.vt.edu/ |
| [OpenPOP](https://github.com/OpenDSA/OpenPOP)          | `docker-compose up openpop`      | https://openpop.localhost.devcom.vt.edu/      |

----------

### Navigating Projects and using Docker:

The `docker-compose.yml` file is how `docker-compose` manages the many images and containers where your services are running.  The `Dockerfile` is used by `docker` to create the image of a useful machine environment, which can produce containers to do the work.

- `docker-compose run <<service>> bash` allows you to dive into container and have a shell and command line interface.
- `docker-compose up <<services>>` Begins services in new containers.  Meant for tasks that have no 'finish', like a server.
   - `docker-compose down` to both stop and remove the containers that were brought up.
- `docker-compose run <<service>> <<commands>>`  starts a **new container** with a task than has a 'finish';  Some example commands are: `python test.py` or `bash`
   - replace `run` with `exec` to use a **running** container instead.
- `docker-compose build <<services>>` Builds a new image for services (Note: old containers are **not** updated)
- `docker images` and `docker container list` displays the images/containers that are *currently active*.  Can add `--all` to see inactive ones as well.

### Useful tips and options:

- Adding the `--detach` or `-d` option allows some docker commands to run in the *background*, giving you back control of the command line.
- Setting a `docker-compose` alias is nice to avoid typing it as much.  We recommend `docc=docker-compose`
- On Windows, you may want to do `git config --global core.filemode false`.  Repositories cloned within Docker can show many changes to the file permissions when `git diff` is used outside of the Docker container.
- The `up` command can spin up several services, e.g.: `docker-compose up opendsa opendsa-lti code-workout`
- There are also two specific profiles set up for common development stacks
  - `docker-compose --profile odsa-cw up` will bring up a stack including OpenDSA-LTI and CodeWorkout
  - `docker-compose --profile cw-op up` will bring up a stack including CodeWorkout and OpenPOP
- In the `docker-compose.yml` the `opendsa-lti` container has a few arguments that you can use to declare which branches of OpenDSA and OpenDSA-LTI you want to use

### Troubleshooting 
#### Docker Issues 
If you are having trouble building the OpenDSA Docker Images, first make sure that Docker itself is properly functioning. Before running any commands, ensure that the Docker Daemon is up and running and then run the command below in your terminal to pull a sample docker image. 

1. Pull the Docker Image 
`docker pull shreyamallamula/dockernginx`
2. Run the Docker Image 
`docker run -d -p 5000:80 shreyamallamula/dockernginx`
3. Point to the right IP address 
http://localhost:5000/ 

If you are not able to pull this image, reinstall Docker, or double check that you followed all the steps correctly. Some possible reasons Docker might not have installed correctly can be found below. 

#### Windows - Hyper-V 
If you are having trouble running Docker on a Windows 10 (or earlier) system, double check that Hyper-V is enabled. This setting might've been manually turned off in the past if you were running a Virtual Machine like VMWare in classes such as CS 2505/2506 . This setting should be automatically turned on by the Docker Desktop Windows Installer, but if a conflicting system (like VMWare is running) is still running, it needs to be manually checked. If you are actively running a conflicting system use the instructions found for Windows 11 instead. 

#### Windows 11
Docker on Windows was classically supported through Hyper-V, which no longer exists in Windows 11. Due to this, some manual shuffling of systems needs to be done to run Docker on these machines. The simplest approach seems to be to install a Linux Subsystem like WSL [Windows Subsystem for Linux](https://hope.edu/academics/computer-science/student-resources/using-wsl.html). After WSL is running, you should be able to download Docker, however you will still need to run Docker commands through an IDE that supports the Docker Platform. Many IDE's such as [IntelliJ](https://www.jetbrains.com/help/idea/docker.html#:~:text=IntelliJ%20IDEA%20provides%20Docker%20support,as%20described%20in%20Install%20plugins.) and [VSCode](https://code.visualstudio.com/docs/containers/overview) have plugins to support this, so use an IDE that you are comfortable with. After setting up the system, pull the sample docker image noted earlier in this section, to confirm success. 

----------
----------
----------

## OLD Installation Steps:

1. Install [Docker](https://docs.docker.com/get-docker/)
2. Install Make (Make can be found in the default package manager on Linux, in Brew on Mac, and [here](https://sourceforge.net/projects/ezwinports/files/make-4.3-without-guile-w32-bin.zip/download) for Windows.  For a Windows installation, you should put the entire folder in Program Files, NOT Program Files (x86). Then, edit your environment variable PATH to add: C:/Program Files/Make/bin. If you don’t know how to edit an environment variable on Windows, google for “windows set environment variable”.)
3. Clone this repository
4. `$ cd OpenDSA-DevStack`
5. `$ make setup` or `$ ./setup.sh` (first time only)
* **If you are Windows User:** Windows paths are case insensitive, make sure you have both repository cloned and named **exactly** `opendsa-lti` and `opendsa` (**remove any spaces or return character**).
6. `$ make up` or `$ docker-compose -f docker-compose.yml up`
7. Once you see `RAILS_ENV=development bundle exec thin start --ssl --ssl-key-file server.key --ssl-cert-file server.crt -p 80` in the terminal (this may take a few minutes)
8. `$ make database` or `$ ./db_setup.sh` (first time only and in another terminal) then, the app will be available at:

   * https://localhost:8443 for OpenDSA-LTI server (note the HTTPS because we are using SSL)

## Stop the Containers:

After you finish your work, you need to bring down the Docker containers.

1. If you entered the container, exit the terminal by typing `exit`
2. Change directory to `OpenDSA-DevStack`
3. `$ make down` or `$ docker-compose -f docker-compose.yml down`

## Re-run Development Servers:

If you have taken down the containers using `$ make down` you can restart them by running `$ make up` again or `$ make restart`.

## Reprovision The Containers:

If anything went wrong, you want to reset your database, or just want to reset the app for any reason, follow these steps.

1. Change directory to `OpenDSA-DevStack`
2. `$ git pull`
3. `$ make nuke` or `$ docker-compose down -v`
4. `$ make up`

## Container sudo password:

When running commands in the container, there is not sudo password, (in case you need to execute any commands that require sudo).

## Development Workflow:

The provisioning script will clone the OpenDSA and OpenDSA-LTI repositories inside the OpenDSA-DevStack directory.
The OpenDSA-DevStack directory is shared between your host
machine and the Docker containers, so you can do your development to any
of these repositories on your host machine using your preferred tools
or IDEs (from "outside" the container environment).
All changes that you make will take effect immediately, and you can
test them through the virtual machine server URLs provided
earlier.
You can commit and push your changes from your host
machine.
**However, if you want to compile books in OpenDSA, you have to do
that from within the container.**
Do so as follows:

1. Open a new terminal on your host machine
2. `$ cd OpenDSA-DevStack`
3. `$ make ssh` or `$ docker-compose exec opendsa-lti bash` (you don't need to do `make up` if the container is already up and running)
4. `$ cd /opendsa`
5. `make <<CONFIG_FILE_NAME>>`

## Keep OpenDSA-DevStack up to date:

Other developers might make changes to any of the repositories cloned
by the OpenDSA-DevStack.
To keep your local version up to date with
the latest version do the following:

1. Open a new terminal
2. Change directory to `OpenDSA-DevStack`
3. `$ make update` or `$ ./get_latest.sh`

## Common Errors

Make sure that you have started Docker before running of the Makefile commands.

If you are on Windows, you may run into issues with line endings.  If you do, simply open Git Bash and run `$ dos2unix filename` to fix them.  This will most likely happen on a script file.

If you are on Windows, you may run into issues with any `docker exec` commands (such as `make ssh`).  To solve them, you may have to start any such command with `winpty`.

## `opendsa` Database Test Data

The initial database population is defined by lib/tasks/sample_data.rake.
It uses the factories defined in spec/factories/* to generate entities.
If you add new model classes and want to generate test data in the
database, please add to the sample_data.rake file so that this population
will happen automatically for everyone.  The sample_data.rake contains
only "sample/try out" data for use during development, and it won't
appear on the production server.  Initial database contents provided
for all new installs, including the production server, is described
in db/seeds.rb instead.

  - `opendsa` database includes the following **admin** account:
    - admin@opendsa.org (pass: adminadmin)
  - `opendsa` database also includes the following accounts:
    - example-1@railstutorial.org (pass: hokiehokie), has instructor access
    - example-*@railstutorial.org (pass: hokiehokie) 50 students

    It also includes the following other objects:
    - Five terms (Spring, Summer I, Summer II, Fall, and Winter 2016),
    - one organization (VT)
    - one course (CS 1114)
    - two offerings of 1114 (one each term)
      - one course offering is set up with the admin and instructor
        as instructors, and all other sample accounts as students

## Generate Canvas course using OpenDSA web interface.

1. Make sure OpenDSA-DevStack is up to date by following the instructions [here](https://github.com/OpenDSA/OpenDSA-DevStack/blob/master/README.md#keep-opendsa-devstack-up-to-date).
2. After you are done you should have OpenDSA-LTI server running. Go to https://localhost:8443 to make sure your application is up and running.
3. Follow the instructions on the instructor's [guide page](https://localhost:8443/home/guide) to set up your Canvas course. **Note:** skip the first step in this guide since you can use the **admin** account (admin@opendsa.org, pass: adminadmin) to cerate the course.

## OLD Production deployment workflow

If you are responsible for maintaining an OpenDSA-LTI production
server, follow the instructions in this section to perform deployment
to the production server.

Deployment to the production server is initiated from the development
environment.
It starts with changes you make to OpenDSA-LTI or OpenDSA
repositories in OpenDSA-DevStack.
First, test these changes locally using OpenDSA-DevStack development
servers.
Second, commit and push any OpenDSA-LTI and OpenDSA changes.
Finally, initiate the production deployment command from within
OpenDSA-DevStack.
It is important to push your changes before the deployment.
Every time you deploy your code, [Capistrano](http://capistranorb.com/) will clone the latest
version of OpenDSA-LTI, then perform the deployment tasks.
One of the tasks gets the latest version of OpenDSA from GitHub as
well.

The following steps need to be done **only once** to generate a pair
of authentication keys.
**Note:** Do not enter a passphrase, and replace **prod_server** with
your domain name.
Some installations use both a staging and a production server.
If yours has both, then you will need to do the ``cat`` line for each
one.

<pre>
   <code>
      <b>Change directory to OpenDSA-DevStack</b>
      $ vagrant up
      $ vagrant ssh
      $ ssh-keygen -t rsa
      $ cat .ssh/id_rsa.pub | ssh deploy@<b>prod_server</b> 'cat >> .ssh/authorized_keys'

      <b>Enter deploy user password for the last time</b>
   </code>
</pre>

Here are the steps that you need to follow every time you want to
perform a production deployment:

<pre>
   <code>
      <b>Change directory to OpenDSA-DevStack</b>
      $ vagrant up
      $ vagrant ssh
      $ cd /vagrant/OpenDSA-LTI
      $ <b>git pull any new code</b>
      $ <b>commit and push any changes</b>
      Execute the following command to deploy to the <b>staging</b> server:
      $ bundle exec cap staging deploy
      Execute the following command to deploy to the <b>production</b> server:
      $ bundle exec cap production deploy
      <b>...</b>
      $ Please enter a branch (&lt;current_branch&gt;): &lt;Branch to deploy. Leave blank to deploy current_branch&gt;
   </code>
</pre>

## Connect to Docker Container Database:

During development, it is convenient to connect to the `opendsa` database from your host machine using [MySQL Workbench](https://www.mysql.com/products/workbench/). Once you installed MySQL Workbench create a new connection to Vagrant VM Database using the following setup:

- Connection Name: OpenDSA-Devstack
- Connection Method: Standard TCP/IP
- MySQL Hostname: 127.0.0.1
- MySQL Server Port: 3307
- Username: root
- Password: opendsa


## Getting Chrome to accept Self Signed SSL for Local Development with Docker

- On the page with the untrusted certificate (`https://` is crossed out in red), click the lock > Certificate Information.
- Click the `Details tab > Export`. Choose `PKCS #7, single certificate` as the file format.
- Then follow my original instructions to get to the Manage Certificates page. Click the `Authorities tab > Import and choose the file to which you exported the certificate.
- If prompted certification store, choose Trusted Root Certificate Authorities
- Check all boxes and click OK. Restart Chrome.

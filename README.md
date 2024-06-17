
#  Welcome to SSME Project

  

##  General

This repository represents a my pet-project. It's a desktop application that is responsible for launching Nodejs applications whether or not its frontend or backend

The name of the project was chosen for a reason: **SSME** or **RS-25** is the name of the [main engine of the space shuttle](https://en.wikipedia.org/wiki/RS-25).

This is a helper for launching our nodejs applications.

At first glance it may seem that this is another [forever](https://github.com/foreversd/forever) or [pm2](https://pm2.keymetrics.io/), the feature of this project in *all-in-box* solution including desktop application, and in the future tui.

The inspiration for writing this app was docker-desktop, so I try to use the same ui/ux

  

###  About

The stack used is

- Sqlite3 for storing running projects.
- Golang as backend part
- Flutter for application

- gRpc for transport (configuration file is attached in the config directory).

- desktop app (now supports only darwin platform)

  

gRpc api file itself is located in the ***api*** directory, you can check out all the methods the api provides.

  

To add a project, the ***CreateNode*** method is used, it adds the path and project name to the database, parses the *package.json* file and adds the "*scripts*" field to the database table.

After that to run the application through the gRpc ***RunNode*** call.

  

***RunNode*** in turn runs the nvm run npm{script} go routine (the *.nvmrc* of the project is parsed) after the process is stopped, the nodes are also stopped

  
  
  

###  Requirements

  

1. App use sqlite3 db so it should be installed on host

2. Also [fnm](https://github.com/Schniz/fnm)

  

###  Make commands

make run

make create_db

make generate

  

###  DB structure

| id  |  name |     cmds   | node_version | default_script|
|-----|-------|------------|--------------|---------------|
| int |varchar| json_array |   varchar    |    varchar    |

  

##  TODO!

1. ~~Add nvm support (with checking **.nvmrc** file)~~ :nvm has strange behavior so i'm move to the fnm
3. add runner from fnm like `fnm exec --using=20 npm run --prefix {path} {dev}`

4. add checking installed nvm or not

5. add build and install script (include desktop app)

6. add npm login

7. add npm private repository check

8. add checking node_modules folder and add script to run npm install
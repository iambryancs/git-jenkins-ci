## GitHub-Jenkins Continuous Integration
Setup a Jenkins installation running Docker in a VM through Vagrant to demonstrate a Jenkins-GitHub Continuous Integration.
A NodeJS app is also provided for testing and will also be run on Docker.

## Requirements
* Make sure your machine supports Virtualization
* VirtualBox installed - get it from https://www.virtualbox.org/wiki/Downloads
* Vagrant installed - get it from http://www.vagrantup.com/downloads.html
* SSH client - you can use [git-scm](https://git-scm.com/downloads)'s built-in ssh client for Windows

## Getting started
1. Fork this repo
2. Clone your forked repo into your machine
3. cd into the repo and run vagrant up
4. Once the machine is up, ssh into your VM by running `vagrant ssh`
5. Run `docker logs jenkins` and look for something like the one below:
  ```
  Jenkins initial setup is required. An admin user has been created and a password generated.
  Please use the following password to proceed to installation:

  ea7358a1dfb44ab38531bba53ca608b7

  This may also be found at: /var/jenkins_home/secrets/initialAdminPassword
  ```
  Take note of the password as you will use that later
1. Open your browser and access http://localhost:8080
1. In Unlock Jenkins page, enter the password mentioned above
1. In Customize Jenkins page, click Install suggested plugins
1. Create your preferred Jenkins user
1. Create a Jenkins job and use `Freestyle project`
1. On the configuration page, do the following:
   * Under `General`, check `GitHub project` and enter your repo's web URL on Project url
   * Under `Source Management`, check `Git` and under Repository URL enter the same URL as above
   * Under `Build Triggers`, check `GitHub hook trigger for GITScm polling` or `Build when a change is pushed to GitHub`
   * Under `Build`, click `Add build step` and select `Execute shell`
     * Under Command, enter the ff:
       ```bash
       chmod +x deploy.sh
       ./deploy.sh
       ```
   * Click Save
1. On your GitHub repo do the following:
   * Click `Settings`
   * On the left, click `Integration Services`
   * Under `Services`, click `Add service` and select `Jenkins (GitHub plugin)`
   * Under `Jenkins hook url`, enter your Jenkins url like `http://x.x.x.x:8080/github-webook/`
     * Where x.x.x.x is your public IP.
     * Make sure your Jenkins installation is visible from the internet
     * You can do this by forwarding port 8080 on your router to your machine
   * Click `Add service`
1. Make a change on the `app.js` (e.g. change 'hello world' to 'hi world') save, commit and push
1. You should see your job automatically being built after the push and will fail because the test part expects a 'hello world' string
   ```js
   #app/test/test.js
   var request = require('supertest');
   var app = require('../app.js');
 
   describe('GET /', function() {
     it('respond with hello world', function(done) {
       request(app).get('/').expect('hello world', done);
     });
   });
   ```
1. Update `app.js` again to the correct one, save, commit and push and you should see your job being built and exit sucessfully
1. If your build finish successfully, the docker container running the app should be running and will be accessible at http://localhost:8000

## License
MIT

## Hastings Server

This is an application that allows users to upload scripts and execute them periodically with email notifications.

The original idea was to create a DSL that significantly simplified programming to allow less technical, business users to create tasks that automate their workflows. You can see the beginnings of that concept [here](https://github.com/berfarah/hastings), but it quickly became overly complicated. Apparently it's really hard to make things really simple.

The way script execution is handled by `hastings-server` is **VERY UNSAFE**.

This is how I would implement the permission structure:
* Create an account for rails
* Create an account for delayed_job
* Create an account for script execution that delayed_job has access to, sandboxed to a different home folder

### Development

Feel free to pull this server down and poke around:

```
git clone git@github.com:berfarah/hastings-server.git
cd hastings-server
bin/install
bin/rails s
```

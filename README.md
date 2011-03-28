# Forrst Feed App

This is a simple [Sinatra](http://www.sinatrarb.com/) web app, that
produces an [Atom](http://en.wikipedia.org/wiki/Atom) feed of a
[Forrst](http://forrst.com) user's post.

## Development

    git clone https://github.com/o-sam-o/forrster-feed-app.git
    bundle install
    rackup
    open http://localhost:9292/kyle

## Deployment

* Create an acount in seconds at [Heroku](http://heroku.com/signup).
* If you do not have an SSH key
you'll need to [generate
one](http://heroku.com/docs/index.html#_setting_up_ssh_public_keys)
and [tell Heroku about
it](http://heroku.com/docs/index.html#_manage_keys_on_heroku)
* `heroku create --stack bamboo-mri-1.9.2 [optional-app-name]` (You can rename your app with `heroku rename`)
* `git push heroku master`

_Deployment instructions mostly copied from [heroku-sinatra-app](https://github.com/sinatra/heroku-sinatra-app)_

## Licence

MIT

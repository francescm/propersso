# README

This is proof of concept of a Ruby on Rails application with Shibboleth authentication, 
pure rails session and a working single sign off.

This application follows: 
[SLOWebappAdaptation](https://wiki.shibboleth.net/confluence/display/SHIB2/SLOWebappAdaptation) 
.

Short things first: it is not worth. There are easier ways to have 
Ruby on Rails and SAML2 auth to go hand in hand, with single 
logout included.

The hard part is not the Shibboleth one: you just need to add a 
[Notify](https://wiki.shibboleth.net/confluence/display/SP3/Notify) 
element in ```shibboleth2.xml```.

The matter is this setup is completely against a few Rails' conventions:
* SOAP support has been dropped from Rails since version 1.2;
* you are not expect to tweak with arbitrary session objects which in turn means:
  * you can't use the trusted cookie session store but you have to switch to the 
  harder database-backed session store, which by the way you need to 
  customize a bit to hold the ```Shib-Session-ID``` data;
  * you need to fight againts encrypted sessions, the default.

Said that, you you want to nevertheless try it, the software version used is:
* Debian GNU/Linux 10 (buster)
* Rails 6.1.3.1
* ruby 3.0.1p64 (2021-04-05 revision 0fb782ee38) [x86_64-linux]

## How it works

You need two tabs: open this application a do a login. On the second tab 
open another application on the same Shibboleth Identity Provider (you are not 
going to need to provide credentials thanks to SSO), then logout. Go back 
to first tab, refresh, you have been logged out. 

## Step by step setup

The project has been created with:

    rails new propersso --skip-active-storage --skip-action-cable
    cd propersso
    rails webpacker:install

Add 'haml' and 'haml-rails' in Gemfile, then create a controller with:

    rails g controller main welcome -e haml
    
The focus of this controller is to allow a user to signin if no session is found, 
or allow a sign off if there is a valid session.    
    
Plug bulma in:

    https://gist.github.com/ro31337/fde256c19074356e4f847a48f696658c

(I skipped the `environment.js` part only).
        
The project needs the activerecord-session_store store gem; please setup it 
as directed in the 
[github page](https://github.com/rails/activerecord-session_store).

Modify sessions table to hold shib_session too:

    rails g migration AddShibsessionToSession shib_session:string
    rake db:migrate

In order to manipulate Session table you need a stub model:

    rails g model session --no-migration

Create the SSO controller:

    rails g controller sso auth -e haml

This controller copies the Shibboleth session to the Rails session. When you create 
the session in the auth controller, take care to populate 
```shib_session``` column.

Note `session.id` is encrypted on the db.
    
And create the SLO controller, responsible for the Logout:    
    
    rails g controller slo front back -e haml

``front`` action deserve no attention.

```back``` action decodes the SOAP payload, extracts the Shib-Session-id, 
uses it to fetch the relevant row from the session table and deletes it.

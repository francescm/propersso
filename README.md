# README

The project has been created with:

    rails new propersso --skip-active-storage --skip-action-cable
    cd propersso
    rails webpacker:install

Add 'haml' and 'haml-rails' in Gemfile, then create a controller with:

    rails g controller main welcome -e haml
    
Plug bulma in:

    https://gist.github.com/ro31337/fde256c19074356e4f847a48f696658c

(I skipped the `environment.js` part only).

To add an image with webpack(er), first edit `app/javascript/packs/application.js` and add:

    const images = require.context('../images', true)
    const imagePath = (name) => images(name, true)

then put image "myImage.svg" in `app/javascript/images`, and reference with:

    = image_pack_tag("media/images/myImage.svg")
    
Create the SSO controller:

    rails g controller sso auth -e haml
    
and the SLO controller:    
    
    rails g controller slo front back -e haml
    
The project seeds the activerecord-session_store store gem; please setup it as directed in the 
[github page](https://github.com/rails/activerecord-session_store).

Modify sessions table to hold shib_session too:

    rails g migration AddShibsessionToSession shib_session:string
    rake db:migrate
    
When you create the session in the auth controller, take care to populate 
```shib_session``` column.
    
    
    https://wiki.shibboleth.net/confluence/display/SHIB2/SLOWebappAdaptation
        
    

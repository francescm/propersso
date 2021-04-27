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
    
    rails g controller slo notify -e haml
        
    

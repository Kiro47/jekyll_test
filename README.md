# The Berry Bunch Website deployer


## What is this?
Essentially in the name of time, and making a quick and easy website we are
using a templating engine called Jekyll to make things easier on us in a way.
It essentially processes everything via some subcommands and makes a decent
looking website with minimal effort.
The deployment script also properly sets all the permissions for the website
and changed the group setting to ensure we should all be able to modify it
the right way.

https://jekyllrb.com/


## How do I deploy the webpage when changes are made?
Just run `deploy.bash` script in `/local/group_projects/cs4760/s20/group2/` ,
this should run everything fine using the renv environment setup.

Assuming this doesn't work and you get an error go yell at @jchelm because he
did a dumb thing in setting it up.  Please also copy and paste the error.


## How do I add documents to the documents web page?
Copy the documents to `deploy_assets/assets/documents/$FOLDER` where `$FOLDER`
is the proper folder you want to use and ensure you set the right permissions
on it.  A quick way to do this is with the following command that you run
in the terminal:
```bash
chown -R "${USER}:cs4760.2" '/local/group_projects/cs4760/s20/group2/deploy_assets/assets/documents'
chmod 554 -R '/local/group_projects/cs4760/s20/group2/deploy_assets/assets/documents'
```
After this just deply the webpage with the `deploy.bash` script, it'll get
automagically added to the web page.

If you're interested in how this is done, it's handled in the `documents.html`
file.

## Modifying the website
Instead of modifying the website directly modify the templates in the
`deploy_assets` directory.  Info on that can be found here:
https://jekyllrb.com/docs/pages/

### Special Variables
Since Jekyll is a templating engine you are able to use variables to make life
easier.  For example, for linking other websites pages you can add
`{{ BASE_PATH }}` as the prefix, which gets replaced as the really dumb
`/classes/cs4760/www/projects/s20/group2/www/` (since we own only a small
subset of the website).
An example of this is including a CSS file:
```html
<link rel="stylesheet" href="{{ BASE_PATH }}/assets/css/documents.css">
```
A common list of them are available here: https://jekyllrb.com/docs/variables/
Many of our custom ones come from the `_config.yml` file which can be accessed
by `site`.


### Special macros
There are also some other magic macros in the format of `{% macro %}`, a
common one you'll find in our page is `{% include JB/setup %}` which
does a lot to build the header, navigation, and footer components (the general
page components) and embeds the rest of the content inside of that.  These
macro functions also support logical statements such as if and else.
A common one is `includes` https://jekyllrb.com/docs/includes/

The macro engine itself is `Liquid` which has docs here:
https://shopify.github.io/liquid/filters/default/

### Front matter
Front matter is the magic sauce jekyll uses to determine what to do with a
given file.  It's pretty simple and obvious to use for the most part.
Details here: https://jekyllrb.com/docs/front-matter/

An important one for note is 'permalink' and 'group' for our uses.
Permalinks are super useful and we should always use them, simply set the
permalink to be `/page_name.html`, for example our documents page is
`/docs.html`. (The permalink name and file name don't have to correspond)

Another important one is the `group`, specifically if the `group` is set to
`navigation` then it will appear as one of the links available in the navigation
bar.  The name there will correspond to the `title` of the page.  Once again
`documents.html` has examples of this.

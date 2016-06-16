##¿Sabes lo que es un API (Application Programming Interface)?

Un **API** es una "librería" creada para poder comunicarse con un software en particular, de manera sencilla. Normalmente esta librería contiene funciones, especificaciones y procedimientos que te permiten comunicarte con ese software para recibir servicios del mismo. 

Un ejemplo muy sencillo es lo que lograremos con este reto combinando la aplicación de propuestas que realizamos en el [tutorial anterior](http://www.codea.mx/posts/26), la integración de la API de **[Twitter](https://dev.twitter.com/overview/api)** y la aplicación de propuestas para Tag CDMX desarrollada por Codea: **[CodeaTag](http://codeatag.herokuapp.com/)**.

Esta aplicación podrá buscar a través de **Twitter** información pública de sus usuarios para utilizarlos como propuestas. Para ello nos comunicaremos con **Twitter** utilizando su API y después mandaremos las propuestas creadas a **CodeaTag** para que Tag CDMX las tome en cuenta para el evento del siguiente año.

## Objetivos Académicos 

- Familiarizarse con el concepto de API
- Utilizar la API de Twitter
- Comunicar nuestra aplicación con servicios externos

## Requisitos

- Haber terminado el [tutorial anterior](http://www.codea.mx/posts/26)
- Tener una cuenta de Twitter con un número movil registrado

Sino tienes cuenta de Twitter o no tienes registrado tu número en la misma puedes seguir estos links:

[Crear cuenta de Twitter](https://twitter.com/signup)

[Registrar número movil en tu cuenta de Twitter](https://twitter.com/settings/devices)

Esto es un requisito de la sección de desarrolladores de Twitter para poder crear tu aplicación.

## Actividades 

### Creación de un Twitter Client

En el tutorial anterior agregamos por ti la gema de Twitter al `Gemfile` de tu aplicación y esta fue instalada junto a las demás gemas de la misma, ahora debemos configurarla para poder comunicarnos con ella.

El primer paso para desarrollar esta aplicación será obtener los códigos de autorización que nos da Twitter para acceder a sus servicios. Entra a la siguiente ruta para hacerlo: [https://dev.twitter.com/apps/new](https://dev.twitter.com/apps/new). 

A continuación vamos a llenar todos los campos que Twitter nos pide para crear nuestra aplicación.

- En el campo **Name:** escribe `codeatag_` seguido de tu nombre o identificador favorito.
- En **Description:** puedes explicar brevemente lo que hará tu aplicación o usar nuestra descripción: `This app creates proposals for TagCDMX using the Twitter API and sends them to CodeaTag app.`
- En **Website:** copia el link que Cloud9 te dio para tu aplicación. Algo parecido a `https://codeatag-username.c9users.io/`.
- En **Callback URL:** vuelve a copiar la misma URL que pusiste en el campo anterior.
- Para terminar este paso deberás aceptar los términos y condiciones de Twitter seleccionando el 'checkbox' debajo de éstas.
- Darle click a `Create your Twitter application`.

Una vez que tu aplicación sea creada de manera correcta, la página te llevará a un panel de configuración. Dentro de este panel accede a la pestaña de `Keys and Access Tokens` donde encontrarás tu `Consumer Key (API Key)` y tu `Consumer Secret (API Secret)`.

Ahora debemos generar los `Access Token` para lo cual deberás ir a la parte inferior de tu página de keys y dar click en el botón que dice `Create my access token`, esto puede tardar unos momentos y deberá darte un mensaje en la misma página, si vuelves a bajar en la misma encontrarás una sección titulada 'Your Access Token' en donde están ahora el `Access Token` y el `Access Token Secret`.

No cierres esta página pues la usaremos más adelante, en este punto deberás tener generados y ubicados los siguientes datos:

- Consumer Key
- Consumer Secret
- Access Token
- Access Token Secret

Ahora sí tienes todo lo necesario para crear un "Twitter Client".

### Obtener token de CodeaTag

Este token te permitirá que las propuestas que agregues a tu aplicación aparezcan en la página principal de **CodeaTag**, se publiquen en **Twitter* y así sean consideradas para crear la lista de invitados del siguiente **Tag CDMX**.

Para conseguir este token debes acceder a la aplicación de CodeaTag entrando al siguiente link:

- [CodeaTag - Nuevo Usuario](http://codeatag.herokuapp.com/users/new)

Ahí debes llenar el formulario que se te presenta, una vez que hayas enviado el mismo verás una página en la que en la parte inferior podrás ver tu `API Token`, manten esta página abierta pues la usaremos en el siguiente paso.


### Configurar la API de Twitter y CodeaTag

La información que generamos en el paso anterior es privada y te pertenece, para protegerla utilizaremos un archivo de Rails en dónde guardaremos tus `tokens` y nadie podrá acceder a ellos más que tú, para esto deberás colocarte en la ruta 'codeatag_app/config/' y crear un nuevo archivo en esta carpeta el cual debes llamar 'twitter_secret.yml', en el agregarás el siguiente código:

```ruby
CONSUMER_KEY: XXXXX
CONSUMER_KEY_SECRET: XXXXX
ACCESS_TOKEN: XXXXX
ACCESS_TOKEN_SECRET: XXXXX
CODEA_TAG_API_TOKEN: XXXXX
```

Ahora ve a la página de tu aplicación en Twitter y sustituye en el archivo de `secrets` las `XXXXX` por cada uno de los 4 primeros token según corresponda.

Una vez que hayas terminado esto deberás ir a tu página de usuario en CodeaTag y copiar el `API token` y sustituir las `XXXXX` de `CODEA_TAG_API_TOKEN` por este código.

Al finalizar tu archivo con los tokens añadidos deberá lucir parecido al siguiente:

```
CONSUMER_KEY: fuhvA2jghbsSJN0gri7uOk
CONSUMER_KEY_SECRET: 3KBDN783hb37BHChGSMjMXCvoCgjnb8mCknHB6DsiEt5j
ACCESS_TOKEN: 68547857-3ys6nuJU87DJNdCAur6nnanak0f789ABCabcuDJC73y6p
ACCESS_TOKEN_SECRET: RY6Jfy945N4ch0zXM87njnuHBYbu7bjbnh6GBNDJtpWz
CODEA_TAG_API_TOKEN: 1257fe2d98nfjn7snjsnuybnha8j7dn
```

Estos códigos no funcionan, así que no los copies a tu aplicación, ten el cuidado de pegar tus propios `token` en el mismo.

Una vez que este archivo está configurado debemos darle a nuestra aplicación la habilidad de leerlos, para esto necesitas abrir el archivo 'secrets.yml' que está en la misma carpeta que el archivo anterior.

En este nuevo archivo debes ubicar en la línea 13 dos líneas de código parecidas al siguiente:

```ruby
development:
  secret_key_base: dc6409787b9428jbh7bd6n2n8n2h7nd882bhbd7g28hdb0s792ybbs9778b86gsb8sb86bs86b2sviusniu27t5evb1i7gisg8g7g68sv6svgs82is2ybuisb2isb682sg07
```

Este es el `secret key` de tu aplicación, debajo de él deberás agregar las siguientes líneas de código:

```ruby

  consumer_key: <%=  ENV["CONSUMER_KEY"] %>
  consumer_secret: <%=  ENV["CONSUMER_KEY_SECRET"] %>
  access_token: <%=  ENV["ACCESS_TOKEN"] %>
  access_token_secret: <%=  ENV["ACCESS_TOKEN_SECRET"] %>
  codea_tag_api_token: <%=  ENV["CODEA_TAG_API_TOKEN"] %>

```
Tu aplicación necesita ahora recargar los archivos para que estos funcionen en la ejecución de la misma, para ellos tiraremos nuestro servidor y lo volveremos a levantar.

Muevete a la pestaña donde está corriendo tu servidor en la consola de Cloud9 y presiona `Ctrl + C` en tu teclado, esto te dará el mensaje 'Exiting' que indica que el servidor se ha detenido.

En este punto si intentas recargar tu aplicación te marcará un error que dirá 'No application seems to be running here!'. Para volver a levantar nuestro servidor debemos correr en la misma pestaña de la consola el siguiente código:

```bash
$ rails s -p $PORT -b $IP
```

Regresa a tu pestaña de consola en la que trabajamos (la primera) y preparate para hacer la integración con Twitter.

##Integración con Twitter

Ahora que tenemos nuestra aplicación corriendo de nuevo empezaremos a hacerle los cambios necesarios para buscar propuestas en Twitter y agregarlas a las nuestras, el primer paso de este proceso será agregar nuevas rutas, navega al archivo 'codeatag_app/config/routes.rb' y debajo de nuestras rutas anteriores agrega las siguientes:

```ruby
  match '/twitter_search', to: 'twitter#search_users', via: 'get', as: 'twitter_search'
  match '/add_proposal', to: 'twitter#add_proposal', via: 'post', as: 'add_proposal'
  match '/twitter_proposal', to: 'twitter#twitter_proposal',     via: 'get'
end
```

La primera ruta la utilizaremos para buscar usuarios de Twitter, la segunda para recibir los usuarios seleccionados y agregarlos a nuestra aplicación.

En la misma carpeta encontrarás un archivo llamado 'application.rb', este se utiliza para definir algunos de los comportamientos básicos de tu aplicación ya que su alcance influencía todos los archivos de la misma.

Dentro de este archivo agregaremos dos partes importantes, el método que lee tus tokens desde los archivos secretos y el cliente con el cual nos comunicaremos con Twitter. Sustituye todo el contenido del archivo por el siguiente:

```ruby
require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"
require "pp"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CodeaTAG
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'twitter_secrets.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end
  end
end

# Aquí es donde vamos a pegar el TwitterClient 
CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key        = Rails.application.secrets.consumer_key
  config.consumer_secret     = Rails.application.secrets.consumer_secret
  config.access_token        = Rails.application.secrets.access_token
  config.access_token_secret = Rails.application.secrets.access_token_secret
end
```

Para que este archivo cargue en tu aplicación necesitamos volver a reiniciar el servidor, recuerda que debes ir a tu pestaña de terminal donde tienes el servidor, presionar `Ctrl + C` y después correr `$ rails s -p $PORT -b $IP` en la misma, con esto nuestro servidor funciona de nuevo, regresa a tu pestaña principal de terminal.

**En los siguientes pasos comenzaremos a hacer cambios a los archivos que ya tenemos, crearemos una migración para añadirles el usuario de Twitter a nuestros 'proposals' y modificaremos la estructura de estos para permitir las nuevas propuestas que haremos desde Twitter**

En tu consola introduce el siguiente código para generar una nueva migración:

```bash
$ rails g migration add_twitter_handle_to_proposals twitter_handle:string
```

Una vez que se ha creado tu archivo de migración necesitas correr esta migración con el siguiente comando:

```bash
$ rake db:migrate
```

Ahora podremos hacer que nuestras propuestas estén relacionadas con el usuario de Twitter que estamos guardando. A continuación haremos algunos cambios a nuestras vistas para acceder a esta funcionalidad.

Lo primero será crear un link para agregar propuestas desde Twitter en el `header` de tu aplicación.

Navega a tu archivo que está ubicado en 'codeatag_app/app/views/layouts/_header.html.erb' y debajo del link de Nueva propuesta (`<li><%= link_to "Nueva propuesta", new_proposal_path %></li>`) agrega la siguiente línea:

```erb
  <li><%= link_to "Propón con Twitter", twitter_proposal_path %></li>
```

Ahora necesitamos un controlador que se encarga de agrupar las funciones relacionadas con Twitter, para generarlo ejecuta el siguiente comando en tu consola:

```bash
$ rails g controller twitter
```

En el vamos a colocar los métodos que se encargarán de:

-Dirigir a la página para nuevas propuestas de Twitter
-Buscar una propuesta en Twitter
-Guardar una nueva propuesta de Twitter

Todas estas funciones se ejecutan sustituyendo el contenido del archivo 'codeatag_app/app/controllers/twitter_controller.rb' por el siguiente código:

```ruby
class TwitterController < ApplicationController
  
  def twitter_proposal
  end
  
  def search_users
    @search_word = params[:twitter][:search]
    @users = CLIENT.user_search(@search_word) 
  end
  
  def add_proposal
    @proposal = Proposal.create(proposal_params)
    flash[:success] = "Propuesta Agregada"
    redirect_to proposals_path
  end
  
end
```

Crearemos también una vista para agregar estas propuestas nuevas, para ello deberás crear el archivo 'twitter_proposal.html.erb' en la ruta 'codeatag_app/app/views/twitter/' y agregarle el siguiente código:

```erb
<div id="first_section">
  <div class="container"> 
    <h1 class="title text-center">¿Cuál es tu propuesta de Speaker?</h1>
    <div class="row">           
      <%= form_tag twitter_search_path, method: "get", remote: true , class: "form-inline" do %>
        <div class="input-group form-group-lg col-md-offset-2 col-md-6 ">
          <div class="input-group-addon">@</div>
          <%= text_field :twitter, :search, class: "form-control" %>
        </div>
        <div class="input-group col-md-2">
          <%= button_tag "Search" , class: "btn btn-lg btn-primary btn-block" %>        
        </div>
      <% end %>
    </div><!-- first_section -->
  </div><!-- container -->
</div>
<div id="search_results" class="row"> 
</div>
```

En la linea 5 le añadimos a nuestro formulario un atributo `remote: true` que modifica su comportamiento por default para utilizar AJAX, lo que permite ver los resultados de tu busqueda sin hacer una nueva petición. Para que esto funcione necesitamos añadir dentro de la misma carpeta el archivo 'search_users.js.erb' y pegar en él el siguiente código:

```js
<% if @users.empty? %>
  $('#search_results').html("<h4 class='text-center'>No se encontro nada!</h4><br><img class='center-block'src='https://codealab.files.wordpress.com/2016/05/screen-shot-2016-05-27-at-7-56-29-pm-e1464397233885.png'>");
<% else %>
  $('#search_results').html("<%= j render('users', users: @users) %>");
<% end %>
```
Después de tener configurado este archivo necesitamos crear uno más en la misma carpeta al que llamaremos '_users.html.erb' con el siguiente código:

```erb
<div  class="row col-md-10 col-md-offset-1">

  <% users.each do |user| %>

    <div class="search_thumbnails col-sm-6 col-md-3">
      <div class="search_img">
        <img src="<%= user.profile_image_url %>">
      </div>
      <div class="search_caption">
        <h5><%= user.name%></h5>
      </div>
      <div class="search_btn">
        <%= form_for Proposal.new, url: add_proposal_path, method: :post do |f| %>
          <%= f.hidden_field :name, value: user.name%>
          <%= f.hidden_field :avatar, value: user.profile_image_url  %>
          <%= f.hidden_field :twitter_handle, value: user.screen_name  %>
          <%= f.submit "+", class: "btn btn-default btn-xs" %>
        <% end %>
      </div>
    </div>

  <% end %>

</div>
```

Con esto ya podrás acceder a tu nueva página en tu aplicación ('Propón con Twitter'), en ella podrás buscar y agregar nuevas propuestas a tu aplicación, intenta agregar varias propuestas por este medio y checa como se ven en tu página principal de propuestas.


##Integración con CodeaTag
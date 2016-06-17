# Tutorial Cloud9

### Crear cuenta
Entra a la página de **[Cloud9](https://c9.io)** y crea una cuenta, seguramente tendrás que activarla en el mail con el que te registraste.

### Crear un nuevo workspace
1. Da click en 'Create a new workspace'
2. En el campo **Create workspace** escribe: `codeatag`
3. En el campo **Description** puedes explicar brevemente lo que hará tu aplicación o usar nuestra descripción: `This app creates proposals for TagCDMX using the Twitter API and sends them to CodeaTag app.` 
4. En la opción **Hosted Workspace** seleccionar **'Public'**
5. En el campo **Clone from Git or Mercurial URL** vamos a pegar la siguiente URL: `https://github.com/softwarenacho/codeatag.git`. Esto nos permite clonar (copiar) un esqueleto  con el código mínimo para empezar con tu aplicación.
6. En **Choose a template** seleccionamos el template `Ruby`.
7. Da click en **Create workspace** para pasar al siguiente paso.

## Objetivos Académicos

- Comprender qué es una aplicación web
- Aprender a crear un CRUD
- Crear tu primera aplicación web

## Introducción

Vamos a crear una aplicación que te permitirá proponer invitados a Tag CDMX para los siguientes eventos.

Para ello crearemos un modelo Propuesta que estará compuesto de 2 atributos:

- name `string` (contendrá el nombre del invitado propuesto)
- avatar `string` (un link a la imagen del invitado)
- twitter_handle `string` (el username de Twitter)

## Actividades

Todas las siguientes instrucciones serán ejecutadas en **Cloud9**. Si necesitas ayuda entendiendo el funcionamiento del sistema pregunta a uno de los instructores.

La estructura de archivos de tu aplicación la puedes encontrar en el lado izquierdo de la interfaz de Cloud9, dentro de la carpeta 'codeatag' están todos los archivos que consituyen tu aplicación.

## Configura tu aplicación

- El primer paso es instalar las gemas que necesita tu aplicación para funcionar. Una gema es una librería de código que añade funcionalidades específicas a tu aplicación. Ejecuta el siguiente comando en la Terminal (Consola) ubicada en la parte inferior de la interfaz de Cloud9:

```bash
$ bundle update
```

- En el esqueleto que te damos existe el archivo `/db/migrate/20160601223404_create_proposals.rb` el cual contiene los atributos del modelo **Proposals** para relacionarlo con la Base de Datos. El siguiente comando ejecuta este archivo, creando una tabla y agregándole esos atributos a la DB. Recuerda ejecutarlo en la Terminal:

``` bash
$ rake db:migrate
```

- Vamos a crear el controlador para el modelo **Proposals**. En tu Terminal ejecuta el siguiente comando:

``` bash
$ rails generate controller proposals
```

Este comando nos crea el archivo `codeatag/app/controllers/proposals_controller.rb`. Dentro de este archivo vamos a crear la funcionalidad necesaria para las acciones del CRUD de **Proposals**.


### CRUD de `Proposals`

CRUD son las siglas de **Create, Read, Update** y **Destroy** y para nuestras aplicaciones está formado de 7 acciones que se explican a continuación:

<table  class="table table-responsive table-bordered table-condensed">
	<tr>
		<th>Acción</th>
		<th>CRUD</th>
		<th>Vista</th>
		<th>Verbo HTTP</th>
    <th>PATH</th>
		<th>Concepto</th>
	</tr>
	<tr>
		<td>New</td>
		<td rowspan="2">CREATE</td>
		<td>new.html.erb</td>
		<td>GET</td>
    <td>/proposals/new</td>
		<td>Muestra el formulario para un nuevo objeto</td>
	</tr>
	<tr>
		<td>Create</td>
		<td></td>
		<td>POST</td>
    <td>/proposals</td>
		<td>Procesa o guarda el nuevo objeto</td>
	</tr>	
	<tr>
		<td>Index</td>
		<td rowspan="2">READ</td>
		<td>index.html.erb</td>
		<td>GET</td>
    <td>/proposals</td>
		<td>Muestra todos los objetos</td>
	</tr>
	<tr>
		<td>Show</td>
		<td>show.html.erb</td>
		<td>GET</td>
    <td>/proposals/:id</td>
		<td>Muestra un objeto especifico</td>
	</tr>
	<tr>
		<td>Edit</td>
		<td rowspan="2">UPDATE</td>
		<td>edit.html.erb</td>
		<td>GET</td>
    <td>/proposals/:id/edit</td>
		<td>Muestra el formulario para editar un objeto</td>
	</tr>
	<tr>
		<td>Update</td>
		<td></td>
		<td>PUT/PATCH</td>
    <td>/proposals/:id</td>
		<td>Guarda los datos editados del objeto</td>
	</tr><tr>
		<td>Destroy</td>
		<td>DELETE</td>
		<td></td>
		<td>DELETE</td>
    <td>/proposals/:id</td>
		<td>Borra un objeto especificado</td>
	</tr>
</table>

## Creando el CRUD

Para crear un objeto `Proposal` necesitamos usar dos acciones:
- `new` - Nos sirve para desplegar un formulario al usuario, donde introducirá el nombre y el link a la foto de la nueva `Proposal`.
- `create` - Nos servirá para crear y guardar la nueva `Proposal` en la base de datos.


**Es importante recordar que todas las acciones (métodos) del controlador las añadirás al archivo `codeatag_app/app/controllers/proposals_controller.rb` dentro de la clase `ProposalsController`, lo que significa que va entre las líneas `class ProposalsController < ApplicationController` y `end`**

#### Acción `new`

Dentro del controlador pega el siguiente código:

``` ruby
  def new
    @proposal = Proposal.new
    # render 'proposal/new.html.erb'
  end
```

La acción anterior crea una `proposal` vacía y como especifica el comentario, se mostrará el archivo 'codeatag_app/app/views/proposals/new.html.erb'. Este archivo no existe todavía.

Crea el archivo 'new.html.erb' dando click derecho sobre la carpeta 'codeatag_app/app/views/proposals/' y seleccionando 'New file' y copia el siguiente código HTML en este nuevo archivo.

``` erb
<div id="first_section">
  <div class="container">
    <h1 class="text-center">Agrega tu propuesta</h1>
    <div class="row">            
      <%= form_for @proposal do |f| %>

      <div class="proposal-input col-md-offset-3 col-md-6 ">         
        <%= f.text_field :name,   placeholder: "Nombre", class: "form-control" %>
      </div>
      <div class="proposal-input col-md-offset-3 col-md-6 ">         
        <%= f.text_field :avatar, placeholder: "Avatar", class: "form-control" %>
      </div>    
      <div class="proposal-input col-md-offset-3 col-md-6">
        <%= f.submit "Crear", class: "btn btn-md btn-primary btn-block" %>
      </div>      
      <% end %>
    </div><!-- first_section -->
  </div><!-- container -->
</div>
```

Una vez que hemos hecho esto, podemos ver nuestra forma en la url de tu aplicación agregandole '/proposals/new' al final de la dirección en tu navegador. Si agregas una propuesta y le das click al botón `crear` verás un error, esto es porque no hemos creado el método `create`.

#### Acción `create`

La forma anterior se enviará a la acción de `create` de nuestro controlador. Por lo tanto necesitamos crear la acción en el controlador con el siguiente código, que contendrá la lógica para crear y guardar el `proposal` en la base de datos, pegalo debajo de tu acción `new`:

``` ruby
  def create
    @proposal = Proposal.new(proposal_params)
    flash[:success] = "Propuesta Agregada"
    @proposal.save
    redirect_to proposals_path
  end

  private

  def proposal_params
    params.require(:proposal).permit(:name, :avatar)
  end
```

En este código definimos dos métodos `create` que guarda nuestra propuesta y utiliza el otro método, `proposal_params` el cual es privado y se encarga de recibir los parámetros que envió la forma y omitir información no permitida.

**Recuerda grabar tu controlador después de añadir nuevo código, todas las acciones nuevas deberás pegarlas antes de la palabra clave `private` y después del último método definido**

El método 'create' crea una nueva `proposal` con los parámetros que le pasó la forma. Después la guarda y redirige al usuario a `proposals_path` que es la vista `index` la cual crearemos en el siguiente paso.

#### Acción `index`

En este paso necesitamos crear una acción `index` en nuestro controlador. Esta acción enlistará todas las `proposals` que existen.

Pega el siguiente código en tu controlador antes del inicio de los métodos privados y después del último método que creaste:

``` ruby
  def index
    @proposals = Proposal.all
    # render 'proposals/index.html.erb'
  end
```
La acción anterior trae de la base de datos todas las `proposals` y como especifica el comentario, se mostrará el archivo 'codeatag_app/app/views/proposals/index.html.erb'. Este archivo no existe todavía.

Crea el archivo 'index.html.erb' en la carpeta 'codeatag_app/app/views/proposals/' y copia el siguiente código que combina HTML y Ruby para enlistar los `proposals` que trajimos de la base de datos.

``` erb
<div id="first_section">
  <div class="container">
    <div class="jumbotron well">
      <h1 class="text-center">Propuestas para TagCDMX</h1>
    </div>
  </div><!-- container -->
</div>
<div  class="row col-md-10 col-md-offset-1">
  <div id="search_results" class="row">
    <% if @proposals.any? %>
      <% @proposals.each do |proposal| %>
        <div class="search_thumbnails col-sm-6 col-md-3">
          <div class="search_img proposal_box">
            <% if proposal.avatar == "" %>
              <%= link_to image_tag("http://icons.veryicon.com/128/Avatar/Face%20Avatars/Male%20Face%20N2.png", class:"img_box"), proposal_path(proposal) %>
            <% else %>
              <%= image_tag(proposal.avatar, class:"img_box")%>
            <% end %>
          </div>
          <div class="search_caption">
            <h5><%= link_to proposal.name, proposal_path(proposal) %></h5>
          </div>
          <div class="search_btn">            
            <%= link_to "E", edit_proposal_path(proposal), class: "btn btn-default btn-xs" %>
            <%= link_to "X", proposal_path(proposal),
            method: :delete,
            data: { confirm: "¿Seguro que quieres eliminar la propuesta?" }, class: "btn btn-default btn-xs" %>
          </div>
        </div>
      <% end %>
    <% else %>
      <p>No has agregado propuestas aún</p>
    <% end  %>
</div>
```

Con esta página agregada ya podemos crear propuestas nuevas, accediendo a la dirección 'https://project-name/proposals/new', recuerda que esto lo debes hacer en la barra de dirección agregando '/proposals/new' al final de tu URL.

Agrega por lo menos 3 propuestas más, recuerda que en avatar deberás poner el link a una imagen de la propuesta que añades y debes poner la dirección de 'proposals/new' cada vez que quieras agregar una nueva.

También configuramos la ruta default de nuestra aplicación, entramos al archivo `codeatag_app/config/routes.rb` y agregamos la siguiente linea antes del 'end'.
``` ruby
root 'proposals#index'
```

Con este cambio si entramos directamente a la url del proyecto podremos ver las propuestas que creamos en el paso anterior.

Como podrás notar en este punto el diseño deja mucho que desear, esto es porque aún no hemos agregado CSS para darle estilo a nuestro proyecto, al crear los archivos HTML ya hemos puesto las etiquetas de clase, ahora sólo nos falta ir a la siguiente ruta 'codeatag-app/app/assets/stylesheets/' en donde deberás cambiar el nombre de 'application.css' a 'application.scss' y en este archivo agregaremos el siguiente código debajo del que ya viene incluido:

``` css
/*
 *= require_tree .
 *= require_self
 */
@import "bootstrap-sprockets";
@import "bootstrap";

.inline-img {
  display: inline-block;
}

.clear {
    clear:both;
}

.pull-right {
    margin-left:5px;
}

// Jumbotron

.jumbotron {
    color: #3F3F3F;
  background-color: rgba(255, 255, 255, 0.21);
  margin-top: 75px;
  border: none;
}

// Centra la ul para poner una nav a la mitad

.navbar {
  text-align:center;
}

.navbar-nav {
    display:inline-block;
    float:none;
}

.logo {
  margin-top: -3px;
  margin-right: 10px;
  padding-top: 9px;
}

#logo_tag {
    float: left;
}

#logo_codea {
    float: right;
}

#content {
    margin-top:50px;
  height:auto;
}

#first_section {
    background:#89E2CA;
    min-height: 250px;
}

h1 {
    font-family: sans-serif;
}

.title {
    margin-top:40px;
    height:130px;
}

.input-group-addon {
    font-size:30px;
    color:#337ab7;

}

.panel-footer {
  margin-bottom: 0;
}


// Twitter Seach Results

#search_results {
    margin-top: 30px;
}

.img_box {
    max-width: 48px;
    max-height: 48px;
    position: relative;
    top: 50%;
    -webkit-transform: translateY(-50%);
    -ms-transform: translateY(-50%);
    transform: translateY(-50%);
}

.proposal_box{
    width: 48px;
    height: 48px;
    vertical-align: middle;
}

.search_thumbnails {
    border: 1px solid #ddd;
    margin-top: 10px;
    padding-left: 0px;
    padding-right: 5px;
}

.search_thumbnails div{
    display:inline-block;
}

.search_btn {
    float:right;
    margin-top: 6px;
}

.search_btn a {
    display: block;
    border: none;

}

.search_btn form {
    margin-top: 7px;
}

.search_caption {
    // margin-left: -8px;
}

.alert {
    margin-top: 15px;
}

.alert-success {
        background-color: rgba(51, 122, 183, 0.85);
    border: none;
    color: #FFF;
}

.proposal-input {
    margin-top: 10px;
    margin-bottom: 10px;
}
```

En este código hemos añadido los estilos para las siguientes partes de la aplicación, y para los siguientes tutoriales que realizarás.

Recarga tu página y podrás notar la diferencia entre una página estilizada y una con sólo HTML.

Cómo podrás ver tus propuestas tiene al lado las letras **E** y **X** las cuales son unos links que nos llevarán a las acciones Editar y Borrar respectivamente, estas las crearemos más adelante en este tutorial.

También agregaremos en este punto un *header* a la aplicación, esto nos permitirá acceder de manera más sencilla a los 2 links principales de nuestra aplicación **Propuestas** y **Nuevas propuestas*, para esto deberás navegar en el directorio de tu aplicación a la ruta 'codeatag_app/app/views/layouts' y cambiar el contenido del archivo 'application.html.erb' por el siguiente:

```erb
<!DOCTYPE html>
<html>
<head>
  <title>CodeaTAG</title>
  <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
  <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  <%= csrf_meta_tags %>
</head>
<body>
  <%= render "layouts/header"  %>
  <div id="content">
  <div id="flash_div">
	  <% flash.each do |key, value| %>
	    <div class="col-md-12 col-sm-12 col-xs-12 form-group flash_message">
	        <%= content_tag(:div, value, class: "alert alert-#{key}") %>
	    </div>  
	  <% end %>
	</div>  
    <%= yield %>
  <div class="clear"></div>
  </div>
</body>
</html>
```

Una vez que hemos hecho esto dentro del mismo folder vamos a crear el archivo '_header.html.erb' y le añadiremos el siguiente código:

```erb
<header class="navbar navbar-fixed-top navbar-inverse">
  <div class="container">
    <%= link_to image_tag("http://codeatag.herokuapp.com/assets/tag_logo-394f282e31e3ec624989e06880ff128e31b78213d137e2eb078c26b4d560c4f1.png", alt: "tag", :height => 40) , "http://tagfestival.com/", class: "logo", id: "logo_tag" %>
    	<ul class="nav navbar-nav" style="text-align:center">
    		<li><%= link_to "Propuestas", root_path %></li>
    		<li><%= link_to "Nueva propuesta", new_proposal_path %></li>
    	</ul>
    <%= link_to image_tag("http://codeatag.herokuapp.com/assets/codeacamp_logo-33e6d9abba6ded2b8cc0144f86cdf60c3c5c00e5302194e6d7e3a10f0edfd3fb.png", alt: "Codea", :height => 40) , "http://codea.mx/", class: "logo", id: "logo_codea" %>
    <nav>
      
    </nav>
  </div>
</header>

```

Recarga tu página y aprovecha las nuevas funcionalidades de tu aplicación para crear las propuestas nuevas que quieras.

#### Acción `show`

En este momento si le das click al nombre de tus propuestas encontrarás un error pues aún no hemos creado la acción que muestra cada una de ellas de manera individual.

La acción `show` mostrará el detalle de una `proposal` en particular. Pega el siguiente código en tu controlador antes de la palabra clave `private` y después del último método que tienes:

``` ruby
  def show
    @proposal = Proposal.find(params[:id])
    # render 'proposals/show.html.erb'
  end
```

**Recuerda guardar tus archivos después de cada cambio**

La acción anterior trae de la base de datos una `proposal` pasándole un `id`. Para acceder al id de la url, utilizamos el hash `params`.
Esta acción mostrará el archivo 'show.html.erb'.

Crea el archivo en la ruta 'codeatag_app/app/views/proposals' y copia en él el siguiente código que mostrará el detalle del `proposal` que trajimos de la base de datos.

``` erb
<div class="col-md-4 col-md-offset-4">
  <div class="panel panel-default">
    <div class="panel-body">
      <%= image_tag(@proposal.avatar, class:"img-responsive")%>
    </div>
    <div class="panel-footer text-center h1">
      <%= @proposal.name %>
      <div class="search_btn">            
        <%= link_to "E", edit_proposal_path(@proposal), class: "btn btn-default btn-xs" %>
        <%= link_to "X", proposal_path(@proposal), method: :delete,
        data: { confirm: "¿Seguro que quieres eliminar la propuesta?" }, class: "btn btn-default btn-xs" %>
      </div>
    </div>
  </div>
</div>
```

Ahora navega a tu página principal de propuestas y da click al nombre de alguna de ellas para que veas la página que acabas de crear.


#### Acción `edit`

La acción `edit`, nos permitirá corregir una `proposal` en caso de que nos hayamos equivocado al introducirla, cambiar el nombre o el link al avatar de la misma.

Como en todas las acciones anteriores vamos a comenzar incluyendo el código necesario en el controlador. Agrega las siguientes líneas al mismo:

``` ruby
  def edit
    @proposal = Proposal.find(params[:id])
    # render 'proposals/edit.html.erb'
  end
```

Para este método tenemos que crear el archivo 'edit.html.erb' en la ruta 'codeatag_app/app/views/proposals/. Agrega el siguiente código en él:

``` erb
<div id="first_section">
  <div class="container">
    <h1 class="text-center">Editar Propuesta</h1>
    <div class="row">            
      <%= form_for @proposal do |f| %>

      <div class="proposal-input col-md-offset-3 col-md-6 ">         
        <%= f.text_field :name,   placeholder: "Nombre", class: "form-control" %>
      </div>
      <div class="proposal-input col-md-offset-3 col-md-6 ">         
        <%= f.text_field :avatar, placeholder: "Avatar", class: "form-control" %>
      </div>    
      <div class="proposal-input col-md-offset-3 col-md-6">
        <%= f.submit "Guardar", class: "btn btn-md btn-primary btn-block" %>
      </div>      
      <% end %>
    </div><!-- first_section -->
  </div><!-- container -->
</div>
```

Con esto ya funcionan los links para editar `E` en las propuestas de tu página Index. Al dar click en cualquiera de estos links, podemos ver nuestra forma, la cual al guardarla genera en este punto un error al no encontrar el método 'update' el cual crearemos a continuación.


#### Acción `update`

La forma anterior se enviará a la acción de `update` de nuestro controlador.  Necesitamos crear la acción con el código que contendrá la lógica para obtener de la base de datos el `proposal` y guardarlo en la base de datos con los nuevos valores. Ve a tu controlador y agrega el siguiente código de la misma manera que haz hecho con los métodos anteriores.

``` ruby
  def update
    @proposal = Proposal.find(params[:id])
    @proposal.update(proposal_params)
    flash[:success] = "Propuesta actualizada"
    redirect_to proposal_path
  end
```

Accede a tus propuestas y edita algunas de ellas, cambiales el nombre y la foto a tu gusto para probar la nueva funcionalidad de tu aplicación. En la última línea indicamos la página que nos mostrará después de actualizar la propuesta (`proposal_path` == acción show).

#### Acción `delete`

La última funcionalidad que nos falta es poder borrar una `proposal`. Para esto vamos a crear la acción `destroy`. Copia el siguiente código en el controlador.

``` ruby
  def destroy
    @proposal = Proposal.find(params[:id])
    @proposal.destroy
    flash[:danger] = "Propuesta borrada"
    redirect_to proposals_path
  end
```

Este código hace que funcionen los links que dicen 'X' en las páginas de propuestas de nuestra aplicación para borrar una de ellas. Pruebalo borrando cualquiera de las propuestas que has añadido.

Tu archivo de controlador debe contener el siguiente código al final de estos pasos:

```ruby
class ProposalsController < ApplicationController
    
  def new
    @proposal = Proposal.new
    # render 'proposal/new.html.erb'
  end
  
  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.save
    flash[:success] = "Propuesta Agregada"
    redirect_to proposals_path
  end
  
  def index
    @proposals = Proposal.all.order(:name)
    # render 'proposals/index.html.erb'
  end
  
  def show
    @proposal = Proposal.find(params[:id])
    # render 'proposals/show.html.erb'
  end
  
  def edit
    @proposal = Proposal.find(params[:id])
    # render 'proposals/edit.html.erb'
  end
  
  def update
    @proposal = Proposal.find(params[:id])
    @proposal.update(proposal_params)
    flash[:success] = "Propuesta actualizada"
    redirect_to proposal_path
  end
  
  def destroy
    @proposal = Proposal.find(params[:id])
    @proposal.destroy
    flash[:danger] = "Propuesta borrada"
    redirect_to proposals_path
  end

  private

  def proposal_params
    params.require(:proposal).permit(:name, :avatar)
  end
end

```

**Con todos estos pasos ya tenemos listo el recurso que hace funcionar todas las acciones CRUD que explicamos al inicio.**

## <center>¡¡Felicidades acabas de crear tu primera app de Rails !!</center>
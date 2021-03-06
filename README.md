SmartTools es una aplicación web la cual permite que usuarios creen campañas publicitarias por medio de videos para promocionar sus productos, a continuación se presentan las herramientas base de su despliegue:

* Ruby on Rails como framework de apliacción web
* ffmpeg como herramienta para el manejo de videos
* Bootstrap como framework frontend
* JW Player como herramienta para reproducción de videos
* Whenever, gema para el manejo de cron
* JMeter como aplicación para realizar pruebas de stress a la aplicación

![SmartTools](https://cloud.githubusercontent.com/assets/2312513/9981678/5c1b0e50-5f89-11e5-9443-b2fe235388d0.png)

# Instalación

Por seguridad al momento de realizar el despliegue es necesario crear el archivo `/config/app_environment_variables.rb` el cual contiene las credenciales para el envío de correos, a continuación se presenta un ejemplo.

```ruby
ENV['gmail_username'] = "user@domain.com"
ENV['gmail_password'] = "p4ssw0rd"
ENV['AWS_ACCESS_KEY_ID']="..."
ENV['AWS_SECRET_ACCESS_KEY']="..."
ENV['database_develop_port']='...'
ENV['database_develop_host']='...'
ENV['database_develop_user']='...'
ENV['database_develop_pass']='...'
ENV['queue_url']=''
ENV['cache_cfg_endpoint']=''
```

# Funcionalidades de SmartTools

Estas son las funcionalidades principales de la aplicación.

## HomePage del Servicio

* Info General de servicio de cloud
* Registarse como administrador de una empresa 
* Iniciar sesión

## HomePage de Empresa o Usuario Administrador

* Administracion de los concursos o campañas (UUID)
  * CRUD de concurso
  * Listados de videos de un concurso.
  * Previsualizar los videos (original como el convertido)

## HomePage de los clientes (Usuarios que realizan los uploads)

* Visualización de los concursos de una empresa
* Reproducir los videos de un concurso determinado
* Subir un video a un concurso

## Batch Job

* Utilizando whenever la aplicación realiza la conversión de videos que se encuentren pendientes

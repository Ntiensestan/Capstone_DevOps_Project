# Using a PHP runtime as a parent image
FROM php:7.2-apache

# Setting working directory in the container
WORKDIR /var/www/html

# Copinging PHP application code into the container
COPY . .

#Installing PHP extensions and Dependencies
RUN apt-get update && \
    apt-get install -y libpng-dev && \
    docker-php-ext-install pdo pdo_mysql gd

# Exposed port
EXPOSE 80

# Start Apache when the container runs
CMD ["apache2-foreground"]

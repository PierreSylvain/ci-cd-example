FROM php:8.2-fpm

# Installer les dépendances nécessaires
RUN apt-get update && \
	apt-get install -y git libzip-dev unzip && \
	docker-php-ext-install pdo pdo_mysql zip && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Définir le répertoire de travail
WORKDIR /var/www/symfony

# Copier les fichiers du projet
COPY . .

# Installer les dépendances Symfony
RUN composer install --no-interaction --prefer-dist

# Exposer le port par défaut de Symfony
EXPOSE 9000

CMD ["php", "-S", "0.0.0.0:9000" , "-t", "public"]

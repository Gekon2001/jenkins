FROM alpine:3.16.3

 ENV TZ=Europe/Kiev
 
 RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && cat > /etc/apk/repositories << EOF http://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/main http://dl-cdn.alpinelinux.org/alpine/v$(cat /etc/alpine-release | cut -d'.' -f1,2)/community EOF && export phpverx=$(alpinever=$(cat /etc/alpine-release|cut -d '.' -f1);[ $alpinever -ge 9 ] && echo  7|| echo 5) && apk add apache2 php$phpverx-apache2 && rm -rf /var/www/html/index.html
 
 COPY src/index.php /var/www/html
     
 EXPOSE 80

 CMD ["apachectl", "-D", "FOREGROUND"]
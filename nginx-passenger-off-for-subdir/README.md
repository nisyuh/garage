Test `passenger_enabled on|off` setting.

### Usage

1. Build: `docker-compose build web`
1. Up: `docker-compose up -d web`
1. Browse: http://localhost:8880/ and http://localhost:8880/laravel/
1. Switch: `passenger_enabled on|off` in `nginx/nginx.conf`
1. Restart: `docker-compose restart web`
1. Browse: http://localhost:8880/ and http://localhost:8880/laravel/
1. Down: `docker-compose down`

### Limitation

Our installation is only to test, and uncertain for practical use.

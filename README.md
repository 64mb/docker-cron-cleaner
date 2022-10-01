# 🗑️ docker-cron-cleaner

---

Lightweight docker cron file cleaner in folder with debounce and crontab setup

### Environment variables  📐
 
| Variable                 | Description                                                               | Example              |
| ------------------------ | ------------------------------------------------------------------------- | -------------------- |
| `COMPOSE_PROJECT_NAME`   | Compose container project id `docker-compose`                             | `dev`                |
| `COMPOSE_PATH_SEPARATOR` | Several `compose` file  separator                                         | `:`                  |
| `COMPOSE_FILE`           | `compose` for deployment, one by one nested                               | `docker-compose.yml` |
| `TIME_ZONE`              | Timezone specific string for cron in linux TZ format                      | `Asia/Yekaterinburg` |
| `CRONTAB`                | Crontab rule for periodic run cleaner: https://crontab.guru               | `*/30 * * * *`       |
| `CLEAN_FILE_AFTER`       | Estimate time in human read format for specific estimate time file delete | `1hour`              |
| `CLEAN_FOLDER`           | Mount point folder for cleaning                                           | `./.temp`            |
| `CLEAN_THROTTLING`       | Debounce sleep in seconds between one run file delete                     | `10`                 |

### Run

- `docker-compose up` - start cleaner in specific mount point

---

Максимально легковесный `docker`-контейнер для очистки устаревших файлов в директории по `cron` расписанию с возможностью настроить задержку между удалениями файлов

### Переменные среды 📐
 
| Переменная               | Описание                                                                           | Пример               |
| ------------------------ | ---------------------------------------------------------------------------------- | -------------------- |
| `COMPOSE_PROJECT_NAME`   | Идентификатор группы контейнеров для `docker-compose`                              | `dev`                |
| `COMPOSE_PATH_SEPARATOR` | Разделитель нескольких `compose` файлов                                            | `:`                  |
| `COMPOSE_FILE`           | `compose` файлы для развертывания, переопределяются в порядке написания            | `docker-compose.yml` |
| `TIME_ZONE`              | Часовой пояс для подсчета `cron` выражения в формате `linux TZ`                    | `Asia/Yekaterinburg` |
| `CRONTAB`                | `Crontab` правило для периодического запуска очисти: https://crontab.guru          | `*/30 * * * *`       |
| `CLEAN_FILE_AFTER`       | Время истечения времени жизни файла от текущего времени в читаемом формате         | `1hour`              |
| `CLEAN_FOLDER`           | Точка монтирования директории в контейнер внутри который будет происходить очистка | `./.temp`            |
| `CLEAN_THROTTLING`       | Время задержки в секундах между удалениями файлов в рамках одного цикла            | `10`                 |
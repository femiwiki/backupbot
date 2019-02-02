[backupbot] [![Docker Badge]][Docker Hub]
========
주기적으로 로컬호스트의 [MySQL을] 덤프하여 [AWS S3]에 업로드합니다.

```bash
docker run --detach \
  --name backupbot \
  --restart always \
  -e 'DB_USERNAME=xxxxxxxx' \
  -e 'DB_PASSWORD=xxxxxxxx' \
  femiwiki/backupbot
```

&nbsp;

--------

The source code of *backupbot* is primarily distributed under the terms of
the [GNU Affero General Public License v3.0] or any later version. See
[COPYRIGHT] for details.

[Docker Badge]: https://badgen.net/docker/pulls/femiwiki/backupbot?icon=docker&label=pulls
[Docker Hub]: https://hub.docker.com/r/femiwiki/backupbot/
[MySQL]: https://www.mysql.com/
[AWS S3]: https://aws.amazon.com/s3/
[페미위키]: https://femiwiki.com
[GNU Affero General Public License v3.0]: LICENSE
[COPYRIGHT]: COPYRIGHT

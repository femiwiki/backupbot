backupbot [![Docker Badge]][Docker Hub]
========
주기적으로 [MySQL]을 덤프하여 [AWS S3]에 업로드합니다.

```bash
docker run --detach \
  --name backupbot \
  --restart always \
  -e 'DB_USERNAME=xxxxxxxx' \
  -e 'DB_PASSWORD=xxxxxxxx' \
  femiwiki/backupbot
# 추가적인 네트워크 설정이 필요합니다.
```

백업 파일의 사용 방법
--------

https://github.com/femiwiki/mediawiki/blob/master/README.md 등의 설명에 따라 미디어위키를 실행한 후 [Restoring a wiki from backup](https://www.mediawiki.org/wiki/Manual:Restoring_a_wiki_from_backup) 메뉴얼을 따릅니다. 예를 들어 mysql 콘테이너에 백업 파일을 복사한 후 다음 커맨드를 실행합니다.

```sh
mysql -uDB_USERNAME -pDB_PASSWORD < dump_of_wikidb.sql #DB_USERNAME과 DB_PASSWORD
```

이후 필요에 따라 [rebuildall.php](https://www.mediawiki.org/wiki/Manual:Rebuildall.php)와 같은 스크립트를 실행합니다.


&nbsp;

--------

The source code of *backupbot* is primarily distributed under the terms of
the [GNU Affero General Public License v3.0] or any later version. See
[COPYRIGHT] for details.

[Docker Badge]: https://badgen.net/badge/icon/docker?icon=docker&label
[Docker Hub]: https://github.com/orgs/femiwiki/packages/container/backupbot
[MySQL]: https://www.mysql.com/
[AWS S3]: https://aws.amazon.com/s3/
[페미위키]: https://femiwiki.com
[GNU Affero General Public License v3.0]: LICENSE
[COPYRIGHT]: COPYRIGHT

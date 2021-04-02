# backupbot [![Docker Badge]][docker hub]

A Docker image for dumping [MySQL] that contains [MediaWiki] data and uploading to [AWS S3] periodically. This image is designed for [FemiWiki].

```bash
# Configuring network is required

# Passing username and password as environment variables
docker run --detach \
  --name backupbot \
  --restart always \
  -e 'DB_USERNAME=xxxxxxxx' \
  -e 'DB_PASSWORD=xxxxxxxx' \
  femiwiki/backupbot

# Alternatively, you can provide LocalSettings.php instead
docker run --detach \
  --name backupbot \
  --restart always \
  -v $PWD/LocalSettings.php:/a/LocalSettings.php \
  femiwiki/backupbot
```

## Environment variables

- `DB_USERNAME`: The user name passed to access the database. If `/a/LocalSettings.php` is exist, this will be ignored.
- `DB_PASSWORD`: The password passed to access the database. If `/a/LocalSettings.php` is exist, this will be ignored.
- `LOCAL_SETTINGS`: The absolute path to LocalSettings.php that declares `$wgDBuser` and `$wgDBpassword`. Default to `/a/LocalSettings.php`.

## Restoring a wiki from backup

```sh
# Replace DB_USERNAME and DB_PASSWORD with actual values
mysql -uDB_USERNAME -pDB_PASSWORD < dump_of_wikidb.sql
```

Run [rebuildall.php](https://www.mediawiki.org/wiki/Manual:Rebuildall.php) script.
See [Restoring a wiki from backup](https://www.mediawiki.org/wiki/Manual:Restoring_a_wiki_from_backup) for details.

&nbsp;

---

The source code of _backupbot_ is primarily distributed under the terms of
the [GNU Affero General Public License v3.0] or any later version. See
[COPYRIGHT] for details.

[docker badge]: https://badgen.net/badge/icon/docker?icon=docker&label
[docker hub]: https://github.com/orgs/femiwiki/packages/container/backupbot
[mysql]: https://www.mysql.com/
[mediawiki]: https://www.mediawiki.org/
[femiwiki]: https://femiwiki.com
[localsettings.php]: https://www.mediawiki.org/wiki/Manual:LocalSettings.php
[aws s3]: https://aws.amazon.com/s3/
[gnu affero general public license v3.0]: LICENSE
[copyright]: COPYRIGHT

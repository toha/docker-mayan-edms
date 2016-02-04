# docker-mayan-edms
Docker Image for the document vault mayan edms. Includes fixes for OCR german texts.

## Install

## Add postgres user and database

Get shell in postgres container
```
docker exec -it postgres-run bash
```

add postgres user mayan
```
su -c "createuser -P -d mayan" postgres
```

create database
```
su -c "createdb -O mayan $YOURDBNAME" postgres
```

## Build Image

```
docker build -t mayan-edms .
```

## Create data only container

```
docker create --name mayan-edms tha_mayan
```

Never start this container! Its a data only container.


## Run container
```
docker run -t --link postgres-run:postgres --volumes-from mayan-data --name mayan-run mayan-edms
```

## Run mayan init
```
docker exec -it mayan-run bash
mayan-edms.py initialsetup
```

If you are upgrading run ```migrate``` and ```syncdb``` instead of ```initialsetup```


## Backup

```
docker run --rm --volumes-from mayan-data -v $(pwd):/backup ubuntu tar cvf /backup/backup.tar /usr/local/lib/python2.7/dist-packages/mayan
```

## Restore

Create ramdisk in container

```
mount -t tmpfs -o size=1G none /mnt
```

* Copy backup.tar to ```/mnt```

* Restore backup

```
cd /mnt
docker run --rm --volumes-from mayan-data -v $(pwd):/backup ubuntu tar xvf /backup/backup.tar
cd
umount /mnt
```

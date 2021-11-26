-# netrunnerdb

-v2+ version of netrunnerdb.  Our card database, API and deckbuilding site.

- Set up with Docker
    - `docker-compose build`
    - `docker-compose up -d db`
    - `./docker-first-run.sh` with nrdbv2 as the password when prompted.
    - `docker-compose up -d`
    - Clone https://github.com/NoahTheDuke/netrunner-data as a sibling to this directory:
    - Run `docker-compose exec web rails c` to open the Rails console, then run `CardsController.helpers.import` to import all card data from that repository.
    - TODO: deal with images well for the docker version.

- Set up a typical Rails dev environment locally
    - `bundle install` to install requisite gems
    - Ensure you have postgres installed and available on your system
    - `rake db:create` to create the database
    - `rake db:migrate` to apply all current migrations
- To populate with cards:
    - Clone https://github.com/NoahTheDuke/netrunner-data outside of this directory (as a sibling to this repository is perfect, as shown below):
        - `..`
            - `netrunner-data/`
            - `nrdb/`
    - Run `rails c` to open the Rails console, then run `CardsController.helpers.import` to import all card data from that repository
- To add card images:
    - Create another folder called `netrunner-scans/` in the same enclosing folder (so, you should have `netrunner-data/`, `netrunner-scans/`, `nrdb/` in the same folder)
    - Download the contents from here https://drive.google.com/drive/folders/1WwMF6danrz8qvY-yZ5R9wSiFVRESZO7a to that folder
    - Add the following code to a file called `slugs.sh`, run `chmod +x slugs.sh` to make it executable, and then `./slugs.sh` to convert the titles to url slugs:

```bash
#!/bin/bash

for filename in ./*; do
    [ -e "$filename" ] || continue
    if [[ -d $filename ]]; then
        s=$(echo $filename | sed 's/[0-9][0-9] - //g' | iconv -t ascii//TRANSLIT | sed -E 's/[~\^]+//g' | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+\|-+$//g' | sed -E 's/^-+//g' | sed -E 's/-+$//g' | tr A-Z a-z);
        # echo $s;
        mv "$filename" $s;
    fi
done

for filename in ./*; do
    [ -e "$filename" ] || continue
    if [[ -d $filename ]]; then
        cd $filename
        for image in ./*.jpg; do
            s=$(echo $(basename ${image%.*}) | sed 's/[0-9][0-9][0-9] - //g' | iconv -t ascii//TRANSLIT | sed -E 's/[~\^]+//g' | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+\|-+$//g' | sed -E 's/^-+//g' | sed -E 's/-+$//g' | tr A-Z a-z);
            # echo $s;
            mv "$image" $s.jpg;
        done
        cd ..
    fi
done
```

    - symlink `./public/assets/images/` to the folder you've just run `slugs.sh` in and you _should_ be ok!

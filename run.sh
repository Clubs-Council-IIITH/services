find . -name ".env.example" -exec sh -c 'f="{}"; cp $f $(echo $f | sed "s/.example//g")' &> /dev/null;

docker compose up --build

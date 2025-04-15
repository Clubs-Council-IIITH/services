git_add() {
  git switch master
  git checkout -b timelog
  git add .
  git commit -m "logging: add timestamp prefix"
  git push --set-upstream origin timelog
}

for dir in clubs events members interfaces user; do
  cd subgraphs/$dir
  git_add
  cd ../..
done

cd web
git_add
cd ..

cd gateway
git_add
cd ..

for dir in auth auth-dev files; do
  cd apis/$dir
  git_add
  cd ../..
done

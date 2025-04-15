for dir in clubs events members interfaces users; do
  cd "$dir"
  git add requirements.txt
  git commit -m "update packages to latest"
  git push
  cd ..
done

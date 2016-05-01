git add .
read -p "What do you want to say?`echo $'\n> '`" comment
git commit -m "$comment"
git push origin master

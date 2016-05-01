#################################################
# Created by @jgaudard  :: I don't twitter much 
# bash script to publish to github, for the lazy...
# Created: 30 April 2016    Edited: 30 April 2016
# Version 1.0
#################################################

git add .
read -p "What do you want to say?`echo $'\n> '`" comment
git commit -m "$comment"
git push origin master

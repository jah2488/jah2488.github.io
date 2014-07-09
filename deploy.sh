git checkout master                   &&
git merge dev                         &&
middleman build --verbose             &&
rm -rf css js img 404 LICENSE README blog game talk about &&
cd build                              &&
mv * .[^.]* ..                        ; # Don't care if this line fails (it will)
cd ..                                 &&
git add --all                         &&
git commit -m "Release"               &&
git push                              &&
git checkout dev

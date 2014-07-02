git checkout master                   &&
git merge dev                         &&
middleman build --verbose             &&
rm -rf css js 404 LICENSE README blog &&
cd build                              &&
mv * .[^.]* ..                        &&
cd ..                                 &&
git add --all                         &&
git commit -m "Release"               &&
git push                              &&
git checkout dev

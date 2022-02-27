pushr() {
  branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  git push -u origin $branch $@
}
mr() {
  target=${1:-dev}
  branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  git remote -v | grep origin | awk 'NR==1 {print; exit}' | cut -d "@" -f 2 | awk -F '.git' '{print $1}' | sed "s/\:/\//" | awk '{print "https://"$1"/-/merge_requests/new?merge_request[source_branch]='"$branch"'&merge_request[target_branch]='$target'"}' | xargs open
}
graph() {
  branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  git remote -v | grep origin | awk 'NR==1 {print; exit}' | cut -d "@" -f 2 | awk -F '.git' '{print $1}' | sed "s/\:/\//" | awk '{print "https://"$1"/-/network/'$branch'"}' | xargs open
}
ci() {
  git remote -v | grep origin | awk 'NR==1 {print; exit}' | cut -d "@" -f 2 | awk -F '.git' '{print $1}' | sed "s/\:/\//" | awk '{print "https://"$1"/pipelines"}' | xargs open
}
mrs() {
  git remote -v | grep origin | awk 'NR==1 {print; exit}' | cut -d "@" -f 2 | awk -F '.git' '{print $1}' | sed "s/\:/\//" | awk '{print "https://"$1"/-/merge_requests"}' | xargs open
}
remote() {
  branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  git remote -v | grep origin | awk 'NR==1 {print; exit}' | cut -d "@" -f 2 | awk -F '.git' '{print $1}' | sed "s/\:/\//" | awk '{print "https://"$1"/-/tree/'$branch'"}' | xargs open
}
release() {
  git fetch
  git checkout master
  git stash
  git reset --hard origin/master
  version=$(cat package.json | jq .version | tr -d '"')
  split_version=(${(s/./)version})
  major=${split_version[1]}
  middle=${split_version[2]}
  minor=${split_version[3]}

  bump=${1:-minor}
  case $bump in
  major) major=$((major+1))
  ;;
  middle) middle=$((middle+1))
  ;;
  minor) minor=$((minor+1))
  ;;
  esac

  git co -b "release/v$major.$middle.$minor"
  jq --arg version "$major.$middle.$minor" '.version = $version' package.json > temp-package.json
  mv -f temp-package.json package.json
  git add package.json
  git commit -m "release v$major.$middle.$minor" --no-verify
}

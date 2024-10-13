# Function that changes git remote source from https tp ssh. Useful 
# because github, for example, restricted an ability to push via https
# some time ago.
git-https-to-ssh() {
  git_get_remote_url() {
    git remote -v | awk '{print $2}' | head -n 1
  }

  convert_https_to_ssh() {
    sed 's|https://github.com/|git@github.com:|'
  }

  set_ssh_remote_url() {
    local new_url=$1
    git remote set-url origin "$new_url"
    echo "Remote URL changed to: $new_url"
  }

  url=$(git_get_remote_url)
  [[ $url == https://github.com/* ]] && set_ssh_remote_url "$(echo "$url" | convert_https_to_ssh)" || echo "No HTTPS URL detected. Current URL: $url"
}


source "/Users/lanceerickson/.bashrc"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function* 
# For virtualenvs
export WORKON_HOME='~/Projekte/envs'
source '/usr/local/bin/virtualenvwrapper.sh'
# For go
export GOPATH=$HOME/Projekte/gowork

export PATH="/Users/lanceerickson/bin:/Library/Frameworks/Python.framework/Versions/2.7/bin:/Users/lanceerickson/.node/bin:/Users/lanceerickson/.composer/vendor/bin:/usr/local/mysql/bin:$PATH:$GOPATH/bin"

# The next line updates PATH for the Google Cloud SDK.
source '/Users/lanceerickson/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
source '/Users/lanceerickson/google-cloud-sdk/completion.bash.inc'

# NVM
export NVM_DIR="/Users/lanceerickson/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
source /usr/local/opt/nvm/nvm.sh

# Azure CLI 2.0
source '/Users/lanceerickson/lib/azure-cli/az.completion'

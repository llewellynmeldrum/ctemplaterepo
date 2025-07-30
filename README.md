This template repo is accompanied by a zsh script, which was built for macos but I think should work on linux? if not remove the `''` from the `sed` line.

```bash
function cinitrepo() {
    local name
    if [[ $# -lt 1 ]]; then
	echo "Project name undefined, terminating..."
	return 1;
    else
	name="$1"
    fi

    mount
    git clone https://github.com/llewellynmeldrum/ctemplaterepo
    mv ctemplaterepo "$name" 
    cd "$name" 
    local makefile="./Makefile"
    sed -i '' "1s/.*/PROJECT := ${name}/"  "$makefile"

    # clear the readme
    rm README.md 
    touch README.md 
    echo "Initialized project: $name"
}
```

Script usage:
```bash 
    cinitrepo <PROJECT_NAME>
```
It writes to the Makefile with the name you supply, and also renames the working dir folder to the name of your choice.

This README.md gets cleared by the zsh script. 

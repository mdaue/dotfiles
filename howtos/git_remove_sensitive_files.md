# Git Remove Sensitive
Sometimes, an oopsie is made... shit happens. Below an example of how to completely eradicate sensitive files from a Git repo. Then, don't ever do it again.

Q: Why are the some many steps? Why can't I just type "git rm <sensitive file path>"?
A: Depending on how many commits have been made since the sensitive file was included and how many revisions were made to it, the file is a part of the Git commit history. That means that there are multiple parts of this file distributed in your repo's commit history. The only way to complete eradicate the sensitive file is by using the git filter-branch method.

## Setup
```
export YOUR_REPO=<https://github.com/your-username/your-repo>
export REPO_DIR=your-repo
export SENSITIVE_DATA_FILE=<path to your sensitive data>
```

## Clone and change dir to your affected repo
git clone $YOUR\_REPO; cd $REPO\_DIR

## Filter-branch Force
A few ''warnings'':
* This will overwrite existing tags
* Removes the specified file and ''any empty commits generated as a result''
* Adds this file to gitignore to avoid future problems
* '''WILL REWRITE''' your entire commit history... '''DO NOT DO THIS IN A PUBLIC BRANCH''' or your friends will abandon ship; consider yourself warned. If you don't know why this is bad, look here: [What happens when you rewrite history on a public branch](http://stackoverflow.com/questions/11149499/what-happens-when-you-rewrite-history-of-a-public-branch)
```
# Complete prune all history of file
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch $SENSITIVE_DATA_FILE' --prune-empty --tag-name-filter cat -- --all

# Add to gitignore
echo "$SENSITIVE_DATA_FILE" >> .gitignore
git add .gitignore

# Force push is required as your history has been rewritten
git push origin --force --all
```

## Caveats
* Performing this on a public branch will come with a litany of headaches - make sure that the risk outweigh the cost; if the sensitive data are credentials, maybe it's easier just to change the credentials of the affected sites.
* Otherwise make sure all your collaborators know to rebase and not merge from your repo

# Credits
All credits of information on this readme go to [Github](https://help.github.com/articles/removing-sensitive-data-from-a-repository/)


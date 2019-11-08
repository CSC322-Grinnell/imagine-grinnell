# Contributing to this project
## Code style
### Ruby
Ruby code styling in this project should conform to the [ruby style guide](https://rubystyle.guide/), and this is enforced by [rubocop](https://github.com/rubocop-hq/rubocop) [(docs)](https://docs.rubocop.org/en/stable/).
The configuration for rubocop can be found in [.rubocop.yml](./.rubocop.yml).
To run only rubocop for an error report, you can call `docker-compose run rails bin/lint.sh --ruby`.
If you want rubocop to try and correct as many errors as it can find safely, you can call `docker-compose run rails bin/lint.sh --ruby --fix-safe`.
If you want rubocop to try and correct as many errors as it can find with potential edge case problems, you can call `docker-compose run rails bin/lint.sh --ruby --fix`.
You probably want to be using the normal `--fix` call most of the time.
The cases that it will screw up are explicitly weird parts of ruby that you are not going to run into anyway.

## Git and Github
Understanding how git internals work conceptually is *highly* recommended before moving any farther in this document.
A good introduction can be found [here](https://www.youtube.com/watch?v=P6jD966jzlk).

Following this, I would highly recommend reading [this](https://www.atlassian.com/git/tutorials/cherry-pick) article on what cherry picking is, and [this](https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase) on rebasing.
Altassian's documentation in general is quite good if you're looking for how some command is meant to be used.

### Git workflow
[This](https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow) document provides a pretty good overview of the "feature branch" workflow, which gives a pretty good high-level overview of the git workflow.
It should be noted, however, that feature branch editing tends to imply that you'll finish an entire feature before putting it up for code review.
Instead, just get to the point where you have passing tests for as small an amount of changes as is reasonable, and hopefully a single commit, and then put in a pull request.
I would recommend naming whatever branch you are working on with just your name; it saves cognitive overhead.

### Commit Hygiene
#### Commit Messages
Read [this](https://chris.beams.io/posts/git-commit/) piece on the matter.
If you're feeling particularly short on time skim the first couple paragraphs and then jump down to the "rules". To reiterate them, though:

 - Separate subject from body with a blank line
 - Limit the subject line to 50 characters
 - Capitalize the subject line
 - Do not end the subject line with a period
 - Use the imperative mood in the subject line
 - Wrap the body at 72 characters
 - Use the body to explain what and why vs. how

If you're looking for how to style things, use [markdown](https://www.markdownguide.org/cheat-sheet/) syntax.
(That's also how this file is written)

As an aside, using the `git commit -m "My commit message"` syntax to write commit messages is somewhat limiting, and I would recommend that you use the default `git commit` command, which simply brings up a text editor to edit the message with.
To change this editor on MacOS and Linux, you want to set the `EDITOR` and `VISUAL` environment variables to the name of the text editors that you want to use.
For example, if you want to use `nano`, you would write the following:

    export EDITOR='nano'
    export VISUAL='nano'

To keep these changes when you re-open your shell, you should add these two lines to your `~/.bashrc`.

To do this on windows, see [this](https://stackoverflow.com/questions/2114111/where-does-git-config-global-get-written-to) entry on stackoverflow.

#### Commit size
The big thing to keep in mind is that you really don't want to make much progress without putting in a pull request.
Try to keep each pull request to a single commit, doing a single change.
As a rough metric; 80 lines of code added is probably too many.

### Pull requests
#### Making pull requests
When you have some changes that you want reviewed, you should use the github pull request system to get your changes reviewed.
This can be done by
1. Opening up the web ui
1. Clicking the "branch" button on the left hand side
1. Clicking "Compare and pull request"
Alternatively, you can look into the official [hub](https://hub.github.com/) command line tool.

#### Pull request messages
In general these can be short or nonexistent, as most of the information that you would want here is in your commit message.
What does make sense to put here are things relevant only at the time that you make the pull request, or messages directed specifically at the code reviewer.

#### Editing a pull request
If you want to make changes to a pull request, you can simply update the relevant branch. It just works!

#### Reviewing pull requests
If you think a pull request needs changes, you should add a comment to the pull request and then message the requestee that they have comments.
If you are happy with the state of a pull request, you should merge it!
To actually merge a pull request, in general you are going to want the "rebase and merge" option, as opposed to the default merge.
This will just grab the commits that have happened since the head of master and shove them on top of the current master branch.
If there are merge conflicts, the best way to resolve them is probably to checkout the branch to merge locally and use the `git` command line, and then manually push to master.

### Git tricks

Please add cool things you find to this section!

#### Config file

The git config file can be very useful, and allows you to define new git command in terms of existing ones and the whole command line.
It can be found at `~/.gitconfig` on linux and OSx, and to find it on windows you can use the following command `git config --list --show-origin` (Note: this file may not yet exist).
[Here's](https://github.com/YourFin/dotfiles/blob/master/config/git/gitconfig) an example file.

#### Nice tree view of your commits

This command:

    git log --graph --abbrev-commit --decorate --all --format='%C(bold green)%h%C(reset)%C(cyan)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'

Gives a nice colored tree view of the entire git repository.

### Git problems, and how to solve them
Please contribute weird problems and how you solved them:

#### You need to edit a commit
To reword a commit, you can use the following command:

    git commit --ammend

This will pull up your text editor with the previous commit message and allow you to edit it.
It will also add any changes that you currently have staged to the commit.

#### You edited a commit *after* you pushed it to Github

Use `git push <remote> --force-with-lease` to push the changes to github.
_Do not do this with the master branch_.

#### Github has gotten ahead of your branch, and you care about the commited changes you have

1. Use `git fetch` to download all the changes from github but not apply them to your local copy.
1. Rebase onto master

#### Github has gotten ahead of your branch, and you don't care about the commited changes that you have
First, use `git fetch` to retrieve the changes that have been made upstream.
You can then use `git branch -f <your branch name> master`.
This moves the ref for `<your branch name>` to the same commit as master, without discarding your uncommitted changes.
If you want to discard your uncommitted changes, you can use `git reset --hard master` instead.

#### Git is complaining that I can't do `x` while I have unstaged changes, but I want to keep my changes without commiting them and do `x`
You need to stash your changes, do `x`, and then unstash your changes. This looks like the following:

    git stash
    git <x>
    git stash pop

#### I edited a git commit, but it was a bad idea and I want what I previously had back
This is where `git reflog` is your friend.
It keeps track of every change to HEAD for you, and will give you commit hashes that you can `checkout`, create new branches starting at, `reset` to, or use `git branch -f <branch name> <commit hash>` to force a current branch back onto.

Dress
===================

Bundler-like plugin manager with Git.

## Installation

```
$ mv ~/.emacs ~/.emacs.bak && mv ~/.emacs.d ~/.emacs.d.bak
$ git clone https://github.com/kawaguchi/dress.git ~/.emacs.d
```

### Manage .emacs.d on Github

```
[Fork kawaguchi/dress as .emacs.d]
$ git clone https://github.com/yourname/.emacs.d.git ~/.emacs.d
```

## Usage

### Write Dresscode

Gemfile-like DSL.

Sample:

```Dresscode
;; This line is comment.
helm :github helm-emacs/helm :require helm-config
jaunte :github kawaguchi/jaunte.el
```

Avaible sources
:url :emacswiki :git :github :gist

Options
- :require
- :config

### Write Config file

~/.emacs.d/config/pluginname.el

### Dress Install

Install missing plugins.

```
M-x dress-install
```

### Dress Up

Load all plugins and related config files.

```
M-x dress-up
```

### Switch Emacs environment using Git branch

```
$ git checkout ubuntu
$ git checkout macbook
$ git checkout test-new-feature
```

## TODO:

1. Dress update
2. Manage installed plugins

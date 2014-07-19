# vim-ansible-yaml
[![Gittip donate button](http://img.shields.io/gittip/Chase.svg?style=flat)](https://www.gittip.com/Chase/ "Donate weekly to this project using Gittip")
[![PayPayl donate button](http://img.shields.io/badge/paypal-donate-yellow.svg?style=flat)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=JA4ZUS8TSAEM2&item_name=vim%2dansible%2dyaml "Donate once-off to this project using Paypal")

Adds additional syntax highlighting and fixes indentation for Ansible's dialect of YAML.

Ansible YAML files are detected based on the presence of a
[structure following Ansible's Playbook Best Practices](http://www.ansibleworks.com/docs/playbooks_best_practices.html#directory-layout).

## Install

### Using [Vundle](https://github.com/gmarik/vundle)

1. Add the following to your `.vimrc` where other bundles are located:
       
		Bundle 'chase/vim-ansible-yaml'

2. Run from command line:

		$ vim +BundleInstall

### Using [pathogen](https://github.com/tpope/vim-pathogen)

1. Check out the repository into your bundle path:

        $ cd ~/.vim/bundle
        $ git clone git://github.com/chase/vim-ansible-yaml.git

### Normal

1. Check out the repository and copy the following to `.vim/` directory or any
   other run time path, keeping their directory structure intact:

		ftdetect/ansible.vim
		syntax/ansible.vim
		syntax/include/jinja.vim
		syntax/include/yaml.vim
		indent/ansible.vim

## Thanks
A huge thanks to [Igor Vergeichik](mailto:iverg@mail.ru) and [Nikolai Weibull](https://github.com/now) for their work on the YAML syntax that this bundle uses.  
Also, thank you, [Armin Ronacher](https://github.com/mitsuhiko), for the
simple and effective Jinja syntax file.

# vim-ansible-yaml

Adds additional syntax highlighting and fixes indentation for Ansible's dialect of YAML.

Ansible YAML files are detected based on the presence of a
[structure following Ansible's Playbook Best Practices](http://www.ansibleworks.com/docs/playbooks_best_practices.html#directory-layout).
For details, see the Detection section below.

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

## Detection

A file is recognized as an Ansible YAML file, and its filetype is set to `ansible`, if

1. The extensions is `.yml`
2. AND one of the following conditions holds:
  1. The file is somewhere under a directory named `roles`.
  2. The file is in the same directory as a directory (or file) named `group_vars`, `host_vars`, or `roles`.

## Configuration

So far, there is only one option. Others may be added later.

If you define

    let g:ansible_options = {'ignore_blank_lines': 1}

in your vimrc file, then the indent function will ignore blank lines when calculating the indent of the current line. This is helpful if your style is to insert blank lines, as in

```
tasks:
  - name: Say hello.
    command: echo Hello, world.

  - name: Say good night, Dick.
    command: echo Good night, Dick.
```

Any non-zero value has the same effect as `1`. If `g:ansible_options` is not defined, or if the `ignore_blank_lines` key is not present, or the value is `0`, then the indent function removes all indent after a blank line.

## Thanks
A huge thanks to [Igor Vergeichik](mailto:iverg@mail.ru) and [Nikolai Weibull](https://github.com/now) for their work on the YAML syntax that this bundle uses.  
Also, thank you, [Armin Ronacher](https://github.com/mitsuhiko), for the
simple and effective Jinja syntax file.

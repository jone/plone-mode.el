plone-mode.el
=============

`plone-mode.el` provides tools for developing plone / zope / python with emacs.


Installation
------------


Usage
-----

`plone-mode.el` is meant to be used in a buildout-based project environment. It
provides interfaces to various development tools and extensions which are
recommended to be installed within your project using buildout (such as
mrs.developer_ and plone.reload_) or globally with easy_install (such as
i18ndude_). Dependenging on what `plone-mode.el` features you wan't to use, you
may need to install some of theese tools.

Supported development tools:

* mrs.developer_: buildout extensions in project buildout and as global executable in PATH
* plone.reload_: egg in project buildout
* collective.recipe.omelette_: buildout recipe in project buildout
* i18ndude_: executable in PATH
* Graphviz_: graph visualization library
* pygraphviz_: python interface library for graphviz


Configuration
-------------

* Changelog username


Features
--------

**Running zope webserver within emacs**

Run the zope webserver in *foreground* mode within emacs. This uses the emacs
*Grand Unified Debugger mode (GDB)* wich allows to easily use the
*Python debugger (PDB)*.

Requirements:

* Buildout based environment.

Default binding: `M-p f`



**Reload python code**

Reloads modified development python code dynamically without restarting the zope
webserver.

Requirements:

* Buildout based environment.
* mrs.developer_ installed as executable in PATH
* mrs.developer_ used as buildout extension
* plone.reload_ installed on the zope instance

Default binding: `M-p r`



**Following python imports**

This feature makes it possible to open the definition file of a import. Move the
cursor in a python file to a python import line and press the key binding. The file
where the imported item is defined will be opened. When the binding is invoked on
a symbol somewhere in the code, it will try to find the import or the definition in
above in the code.

Requirements:

* Buildout based environment.
* collective.recipe.omelette_ installed as buildout recipe in the current project.

Default binding: `M-p g`



**Run i18ndude for generating translation files**

i18ndude_ is a great command line tool for generating .pot- and .po-files, used
for translation in zope / plone.
This features allows to build the .pot-files automatically, that means to search
translatable strings in your package and generate a translation template (.pot).
In a second step you can the sync the .pot-file with a language specific .po-file
and translate the missing strings directly within emacs.

As translation domain the name of the package is taken. That means if you are
editing a file within the package "foo.bar" and then invoking a i18ndude command,
the domain name "foo.bar" will be used. The translation files are stored in a
"locales" directory within your package, old-style "i18n" directories are not
supported, also old-style Products are not supported.

Requirements:

* Python package (old-style Products not supported)
* i18ndude_ installed and available in PATH
* Only for domain with the same name as the package.

Default bindings:

* Build .pot-file: `M-p i`
* Sync with .po-file: `M-p M-i`


**Create a dependency graph**

Create a dependency-graph (PDF) of the depencies within your packages. By default
all dependencies within development-packages are respected.

Options:

* `--follow`: Also show packages in the graph which are not in development mode (meaning located in your src-directory) but has a direct dependency from a development-package.
* `--recursive`: Show all packages wich have a direct or a indirect dependency from a development package.

See the mrs.developer_ documentation for further infos about the options.

Requirements:

* Buildout based environment.
* Development packages are within a "src" directory and the current buffer is somewhere within this directory.
* mrs.developer_ is installed as script in your PATH
* pygraphviz_ and Graphviz_ are installed.



**Make changelog entry**

In plone packages the changelog is usually located in `docs/HISTORY.txt` or in
`CHANGES.txt`. This feature will search the right changelog file, open it and add
your name in the common changelog form.

See the Configuration_ section for configuring your name.

Requirements:

* Package with either a `docs/HISTORY.txt` or a `CHANGES.txt

Default binding: `M-p c`



.. _mrs.developer: http://pypi.python.org/pypi/mrs.developer
.. _plone.reload: http://pypi.python.org/pypi/plone.reload
.. _collective.recipe.omelette: http://pypi.python.org/pypi/collective.recipe.omelette
.. _i18ndude: http://pypi.python.org/pypi/i18ndude
.. _Graphviz: http://www.graphviz.org/
.. _pygraphviz: http://networkx.lanl.gov/pygraphviz/

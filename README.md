# Purpose of this repository

This is main repository of my blog page `https://www.blogger.com/blog/posts/5450600235761388400?tab=rj&bpli=1&pli=1` about Technical Writing with `Emacs` and `Pandoc`. Primary focus of this blog is to showcase the possibilities of working with these awesome tools, from basic `Emacs` usage trough working in `org-mode` and with `git` to converting all your work to multiple output formats, be it with `Pandoc` or `org-mode`.

# IMPORTANT notice

Even though this is a public repository, some of the settings in `makefile` expects user to have specific setup. For conversion done with `emacs` `make` expects you to have an `emacs` config file, that is loaded specifically for conversion process (`-l` flag in `emacs` conversion commands). In my case that is file `exportConfig.el` located in mine `~/.doom.d` folder. If you would want to clone this repository and try running `make`, you will have to modify this setting for your specific setup.

Also, in `pandoc` settings I am using filter `pandoc-acronyms`, a `python pandoc` filter which can be installed with `pip`:

``` shell
pip install pandoc-acronyms
```

# Contents of this repository

- `src` folder contains per its name all source files needed to run all conversion processes, with the exception of `emacs` config file (see section above). Those are:

    + `main.org` file that contains some `org-mode` settings and `#+INCLUDE` directives for inclusion of individual chapter files.
    + `chapters` folder which contains individual chapter files in `org-mode` format and settings file in `org-mode` format for exporting each individual chapter to HTML format to be published in my blog.
    + `settings` folder contains a lot of settings files in various formats for `emacs` and `pandoc` conversions. Those are discussed in great deal in my blog.

- `release` folder of this repository contains results of conversion processes. Those are:
[2021-04-02 Fri]: As of now, in some parts of chapters there are notes, which are deliberately left in there. Those are marked with yellow and red text background.

    + conversion result from `org-mode` to pdf done with LaTeX exported via `emacs` export dispatcher.
    + conversion result from `org-mode` to HTML exported via `emacs` export dispatcher
    + conversion result from `org-mode` to `.odt` format export via `emacs` export dispatcher
    + conversion result from `org-mode` to pdf done with LaTeX exported via `pandoc`.
   [2021-04-02 Fri]: As of now, the exported pdf has numerous issues. Will be fixed in time. See `changelog.md` file.
    + conversion result from `org-mode` to pdf done with ConTeXt exported via `pandoc`.
   [2021-04-02 Fri]: As of now, the exported pdf has numerous issues. Will be fixed in time. See `changelog.md` file.
    + conversion result from `org-mode` to HTML exported via `pandoc`.
   [2021-04-02 Fri]: As of now, the exported HTML has numerous issues. Will be fixed in time. See `changelog.md` file.
    + conversion result from `org-mode` to `odt` format export via `pandoc`.
   [2021-04-02 Fri]: As of now, the exported `odt` has numerous issues. Will be fixed in time. See `changelog.md` file.
    + conversion result from `org-mode` to `docx` format export via `pandoc`.
   [2021-04-02 Fri]: As of now, the exported `docx` has numerous issues. Will be fixed in time. See `changelog.md` file. 
   
- `changelog.md` file tracking changes for day of uploading project to this repository, that is as of [2021-04-02 Fri].
- **This file** `README.md`

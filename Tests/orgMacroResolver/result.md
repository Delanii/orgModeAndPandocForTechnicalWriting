# Org macro expansion from org to HTML

This test proved unnecessary, because `org-mode` macros are correctly parsed by `pandoc`; that is at least for file formats supported by `org-mode` (so that would mean this the filter `orgMacrosResolver.lua` would be needed to export to `docx` and `context` formats ...)

# Org macro expansion from org to odt

Macro expansion with export from `org-mode` to `odt` proved interesting ...

1. Standard text is better put in <text:span> tags, not in <text:p>
2. It does seem that `pandoc` is not expanding `org-mode` macros while exporting. Test file exports OK with emacs `org-mode`, but not with `pandoc`

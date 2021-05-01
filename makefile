.ONESHELL: # Makes sure that `cd` command to make work Pandoc exorting is working as expected. Otherwise, `cd` runs in subprocess shell, which doesnt change working directory for `make`. Other option would be to write all the steps in one logical line. Each line end ha to then be escaped, because line ending are interpreted by `make` a rule separators. Example:
# cd dir; \
# pandoc stuff; \
# cd ..

# Setting Environment variables
#####################################
#
DOOMDIR = ~/.doom.d

# Main Configurations
# #############################

DoomEmacsExportConfig = ~/.doom.d/exportConfig.el

chaptersLocation = individualChapters

# Org file sources
# ####################
#
# Org chapter files
#
orgChapterFiles = src/chapters/*.org

# Main org source file, to which are imported all chapter files

mainOrgSource = src/main.org

# Org Macro Definitions
#
orgMacroDefinitions = src/settings/orgMacroDefinitions.org

# Pandoc files
# ####################
#
# Pandoc defaults files and settings
#
pandocMainDefaults = src/settings/pandocSettings/mainDefaultsPandoc.yaml

pandocFilters = src/settings/pandocSettings/pandocFilters/*.lua

pandocAcronyms = src/settings/pandocSettings/acronyms.json

# LaTeX Build Files
# #####################
#
# LaTeX settings file
#
LaTeXSettings = src/settings/setupfileLatex.org

# Arara compilation settings
#
araraSettings = arararc.yaml

# Main LaTeX source file
#
fullLaTeXBook = main.tex

# Resulting full blog pdf
#
fullPdfBookEmacs = orgModeAndPandocForTechnicalWriting_emacsExport.pdf

# HTML export settings
# ######################
#
# Export via Emacs export dispatcher
#
# HTML full book settings

htmlFullBookEmacsSettings = src/settings/HTMLFullExportSettingsReadtheorg_EmacsExport.org

htmlFullBookEmacsExport = orgModeAndPandocForTechnicalWriting_emacsExport.html

# HTML export of individual chapters
#
setupfileIndividualChapters = src/chapters/setupfileIndividualChapters.org
picturesConverterBase64 = src/settings/picturesConverterBase64.sh

# ODT export settings
#
odtStylesFile = src/settings/odtStyleFileOrgSource_Emacs.odt

odtFullBookEmacsExport = orgModeAndPandocForTechnicalWriting_emacsExport.odt

##################################
# Pandoc export settings
# ################################
#
# Pandoc LaTeX export settings
#
pandocLatexExportSettings = src/settings/pandocSettings/defaultsSettingsLatex.yaml src/settings/pandocSettings/specificMetadataLatex.yaml src/settings/pandocSettings/mainDefaultsPandoc.yaml src/settings/pandocSettings/acronyms.json src/settings/orgMacroDefinitions.org
pandocLatexExportSettingsPhantom = settings/pandocSettings/defaultsSettingsLatex.yaml

texPandoc = orgModeAndPandocForTechnicalWriting_pandocExport.tex
latexFullBookPandocExport = orgModeAndPandocForTechnicalWriting_pandocExport.pdf

# Pandoc ConTeXt export settings
#
pandocContextExportSettings = src/settings/pandocSettings/defaultsSettingsContext.yaml src/settings/pandocSettings/specificMetadataContext.yaml src/settings/pandocSettings/mainDefaultsPandoc.yaml src/settings/pandocSettings/acronyms.json src/settings/orgMacroDefinitions.org
pandocContextExportSettingsPhantom = settings/pandocSettings/defaultsSettingsContext.yaml

contextTex = orgModeAndPandocForTechnicalWriting_ConTeXt.tex
contextFullBookPandocExport = orgModeAndPandocForTechnicalWriting_ConTeXt.pdf

# Pandoc HTML export settings
#
pandocHTMLExportSettings = src/settings/pandocSettings/pandocHTMLExportSettings.yaml src/settings/pandocSettings/mainDefaultsPandoc.yaml src/settings/pandocSettings/acronyms.json src/settings/orgMacroDefinitions.org
pandocHTMLExportSettingsPhantom = settings/pandocSettings/pandocHTMLExportSettings.yaml # Necessary because of Pandoc PATH resolving issues - Pandoc cant find files included from other directory than working directory (`--resource-path` is not implemented in pandoc org reader)

htmlFullBookPandocExport = orgModeAndPandocForTechnicalWriting_PandocExport.html

# Pandoc ODT export settings
#
pandocODTExportSettings = src/settings/pandocSettings/defaultsSettingsOpenOffice.yaml src/settings/pandocSettings/mainDefaultsPandoc.yaml src/settings/pandocSettings/acronyms.json src/settings/orgMacroDefinitions.org
pandocODTExportSettingsPhantom = settings/pandocSettings/defaultsSettingsOpenOffice.yaml

odtFullBookPandocExport = orgModeAndPandocForTechnicalWriting_pandocExport.odt

# Pandoc DOCX export settings
#
pandocDOCXExportSettings = src/settings/pandocSettings/defaultsSettingsWord.yaml src/settings/pandocSettings/mainDefaultsPandoc.yaml src/settings/pandocSettings/acronyms.json src/settings/orgMacroDefinitions.org
pandocDOCXExportSettingsPhantom = settings/pandocSettings/defaultsSettingsWord.yaml

docxFullBookPandocExport = orgModeAndPandocForTechnicalWriting_pandocExport.docx

###############################################
###############################################
# Make build rules to build the full project
###############################################
###############################################

.PHONY : release
release : all clean
	mkdir -p release
	mv ${fullPdfBookEmacs} ${htmlFullBookEmacsExport} ${odtFullBookEmacsExport} ${htmlFullBookPandocExport} ${contextFullBookPandocExport} ${latexFullBookPandocExport} ${odtFullBookPandocExport} ${docxFullBookPandocExport} release
	rm -Rf release/orgModeAndPandocForTechnicalWriting_ConTeXt-export release/pictures
	scp -r src/pictures release/pictures
	mv orgModeAndPandocForTechnicalWriting_ConTeXt-export release/orgModeAndPandocForTechnicalWriting_ConTeXt-export

.PHONY : all # builds all export files
all : pdfEmacs htmlExportEmacs chaptersEmacs odtExportEmacs htmlExportPandoc contextFullBookPandoc latexFullBookPandoc odtExportPandoc docxExportPandoc

############################################
# Declaring environment variables for pandoc-acronyms
############################################

contextPandoc : export PANDOC_ACRONYMS_ACRONYMS = ./settings/pandocSettings/acronyms.json
texPandoc : export PANDOC_ACRONYMS_ACRONYMS = ./settings/pandocSettings/acronyms.json
htmlExportPandoc : export PANDOC_ACRONYMS_ACRONYMS = ./settings/pandocSettings/acronyms.json
odtExportPandoc : export PANDOC_ACRONYMS_ACRONYMS = ./settings/pandocSettings/acronyms.json

######################################
# Export governed by Emacs
# ###################################
#
# Export of pdf files

pdfEmacs : ${araraSettings} texEmacs
	arara --log --verbose --preamble fullcompile ${fullLaTeXBook}
	mv main.pdf ${fullPdfBookEmacs}

texEmacs : ${mainOrgSource} ${orgChapterFiles} ${LaTeXSettings} ${DoomEmacsExportConfig} ${orgMacroDefinitions}
	emacs -nw --batch ${mainOrgSource} -l ${DoomEmacsExportConfig} -f org-latex-export-to-latex --kill
	mv src/main.tex ${fullLaTeXBook}

# Building HTML files
#
# Export governed by org-mode HTML export dispatcher
#
# Full blog HTML
#
htmlExportEmacs : ${mainOrgSource} ${orgChapterFiles} ${orgMacroDefinitions} ${htmlFullBookEmacsSettings}
	emacs ${mainOrgSource} -nw -l ${DoomEmacsExportConfig} -f org-html-export-to-html --kill # =-nv= creates emacs window. It is impractical, but reportedly there is no better solution ... HTML source block colorization requires =font-lock= to colorize, and that gets started only while drawing emacs window.
	mv src/main.html ${htmlFullBookEmacsExport}

# Exporting individual chapters
#
chaptersEmacs : ${mainOrgSource} ${orgChapterFiles} ${setupfileIndividualChapters}
	mkdir -p ${chaptersLocation}
	emacs src/chapters/introduction.org -nw -l ${DoomEmacsExportConfig} -f org-html-export-to-html --kill
	emacs src/chapters/git-Basics.org -nw -l ${DoomEmacsExportConfig} -f org-html-export-to-html --kill
	emacs src/chapters/exportToLaTex-Basics.org -nw -l ${DoomEmacsExportConfig} -f org-html-export-to-html --kill
	mv src/chapters/*.html ${chaptersLocation}
	rm -f ${chaptersLocation}/setupfileIndividualChapters.html
	rm -Rf ${chaptersLocation}/pictures
	scp -r src/pictures ${chaptersLocation}/pictures
	scp ${picturesConverterBase64} ${chaptersLocation}
	cd ${chaptersLocation}
	./picturesConverterBase64.sh
	cd ..

# Exporting with org-mode to .odt
#
odtExportEmacs : ${mainOrgSource} ${orgChapterFiles} ${odtStylesFile}
	emacs ${mainOrgSource} -nw -l ${DoomEmacsExportConfig} -f org-odt-export-to-odt --kill
	mv src/main.odt ${odtFullBookEmacsExport}

######################################
# Export governed by pandoc
# ###################################
#
# Building pdf files with pandoc
#
# With LaTeX:
#
texPandoc : ${mainOrgSource} ${orgChapterFiles} ${pandocLatexExportSettings} ${pandocMainDefaults} ${pandocFilters} ${pandocAcronyms}
	cd src
	pandoc --defaults=${pandocLatexExportSettingsPhantom} -o ${texPandoc}
	cd ..
	mv src/pandocLatexLog.log pandocLatexLog.log
	mv src/${texPandoc} ${texPandoc}

latexFullBookPandoc : texPandoc ${araraSettings}
	arara --log --verbose --preamble fullcompile ${texPandoc}

# With ConTeXt:

contextPandoc : ${mainOrgSource} ${orgChapterFiles} ${pandocContextExportSettings} ${pandocMainDefaults} ${pandocFilters} ${pandocAcronyms}
	cd src
	pandoc --defaults=${pandocContextExportSettingsPhantom} -o ${contextTex}
	cd ..
	mv src/pandocContextLog.log pandocContextLog.log
	mv src/${contextTex} ${contextTex}

contextFullBookPandoc : contextPandoc
	context ${contextTex}
#
#
# Export to html
#
htmlExportPandoc : ${mainOrgSource} ${orgChapterFiles} ${pandocHTMLExportSettings} ${pandocMainDefaults} ${pandocFilters}
	cd src
	pandoc --defaults=${pandocHTMLExportSettingsPhantom} -o ${htmlFullBookPandocExport}
	cd ..
	mv src/pandocHTMLExportLog.log pandocHTMLExportLog.log
	mv src/${htmlFullBookPandocExport} ${htmlFullBookPandocExport}

# Export to odt with Pandoc
#
odtExportPandoc : ${mainOrgSource} ${orgChapterFiles} ${pandocODTExportSettings} ${pandocMainDefaults} ${pandocFilters}
	cd src
	pandoc --defaults=${pandocODTExportSettingsPhantom} -o ${odtFullBookPandocExport}
	cd ..
	mv src/pandocODTLog.log pandocODTLog.log
	mv src/${odtFullBookPandocExport} ${odtFullBookPandocExport}

# Export to docx with Pandoc
#
docxExportPandoc : ${mainOrgSource} ${orgChapterFiles} ${pandocDOCXExportSettings} ${pandocMainDefaults} ${pandocFilters}
	cd src
	pandoc --defaults=${pandocDOCXExportSettingsPhantom} -o ${docxFullBookPandocExport}
	cd ..
	mv src/pandocDOCXLog.log pandocDOCXLog.log
	mv src/${docxFullBookPandocExport} ${docxFullBookPandocExport}

.PHONY clean :
clean :
	rm -Rf *.log *.tex *.gz *.out *.aux *.toc *.lot *.lof *.lol *.pyg *.listing *.bcf *.glg* *.glo* *.gls* *.ist *.run.xml *.bbl *.blg *.synctex *.tuc *.lua *.pytxcode ./_minted-main ./_minted-orgModeAndPandocForTechnicalWriting_pandocExport ./src/.auctex-auto ./individualChapters/pictures ./individualChapters/picturesConverterBase64.sh # -R removes folders, -f makes `rm` not error when file is not found.

.PHONY purge :
purge: clean
	rm -Rf *.pdf *.html *.odt *.docx ${chaptersLocation} ./orgModeAndPandocForTechnicalWriting_ConTeXt-export ./release

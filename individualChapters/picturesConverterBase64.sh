#!/bin/bash

for file in pictures/*.png; do
    base64 "$file" | tr --delete '\n' > "${file%.png}.txt" # =base64= introduces linebrakes that have to be removed for standalone picture inclusion in html
done

for file in pictures/*.txt; do
    conversion=$(<${file}) #echo "${conversion}" OK
#    sed -i -- 's|src="../pictures|src="./pictures|g' *.html # Working if there is a "pictures" folder with pictures
    sed -i -- 's|<img src="../'"${file%.txt}"'.png|<img src="data:image/png;base64,'"${conversion}"'|g' *.html # standalone picture inclusion, see: https://www.thesitewizard.com/html-tutorial/embed-images-with-data-urls.shtml and =sed= syntax, see: https://stackoverflow.com/questions/7189604/replacing-html-tag-content-using-sed
done

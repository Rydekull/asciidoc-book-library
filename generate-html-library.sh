#!/bin/bash

IFS=$'\n'
cat <<EOF> index.html
<html>
  <head>
    <meta charset="UTF-8">
    <title>AsciiDoc Book Library</title>
    <link rel="stylesheet" media="all" href="style.css" />
  </head>

  <body id='top'>
    <div class='header'>
      <h1>AsciiDoc Book Library</h1>
    </div>
    <div class='categories'>
      <p>
EOF

for CATEGORY in $(ls -1d */ | sort --ignore-case)
do
cat <<EOF>> index.html
        <span class="category"><a href="#${CATEGORY%%/}">${CATEGORY%%/}</a></span>
EOF
echo test > ${CATEGORY}/index.html
done

cat <<EOF>> index.html
      </p>
    </div>
    <div class='library'>
EOF

for CATEGORY in $(ls -1d */ | sort --ignore-case)
do
  cat <<EOF>> index.html
      <span id="${CATEGORY%%/}"><a href="${CATEGORY}" class="category-link">${CATEGORY%%/}</a></span>
      <ul class='shelf'>
EOF
  echo ${CATEGORY%%/} > ${CATEGORY}/index.html
  for BOOK in $(ls -1d "${CATEGORY}"/*/ 2> /dev/null)
  do
    echo ${BOOK/*\/\//} > ${CATEGORY}/index.html
    cat <<EOF>> index.html
        <li class='book'>
          <a href="${BOOK}" class="book-link">${BOOK/*\/\//}</a>
        </li>
EOF
  done
  cat <<EOF>> index.html
      </ul>
      <p class="top"><a href="#top">- Top -</a></p>
    </div>
    <div class='library'>
EOF
done

cat <<EOF>> index.html
  </body>
</html>
EOF

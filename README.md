testx-file-keywords
=====

A library that extends testx with keywords for content of text files. This library is packaged as a npm package.

## How does it work
From the directory of the art code install the package as follows:
```sh
npm install testx-file-keywords --save
```

After installing the package add the keywords to your protractor config file as follows:

for testx 0.x
```
testx.addKeywords(require('testx-file-keywords'))
```
for testx 1.x
```
testx.keywords.add(require('testx-file-keywords'))
```

## Keywords

| Keyword                | Argument name | Argument value  | Description | Supports repeating arguments |
| ---------------------- | ------------- | --------------- |------------ | ---------------------------- |
| check text in file     |               |                 | check that the expected regex matches the text in the file |  |
|                        | file          | full path to the file |one of **file**, **url** or **link** has to be specified| No |
|                        | url           | URL of the file |one of **file**, **url** or **link** has to be specified| No |
|                        | link          | link to the pdf file |one of **file**, **url** or **link** has to be specified| No |
|                        | timeout       | timeout in milliseconds to wait for the link to the file to appear on the screen; ignored if the keyword is used with **file** or **url**;  parameters; defaults to 5000 if not present || No |
|                        | expect1(2, 3...) | expected regular expression to match the text in the file || Yes |
| check text not in file |               |                 | same as **check text in file**, but checks that the specified regex DOES NOT match |  |

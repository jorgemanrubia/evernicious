# Evernicious: a tool for importing del.icio.us bookmarks into evernote

Evernicious is a tool for converting delicious bookmarks to Evernote format.

The del.icio.us bookmarks can be exported at the [official site](http://www.delicious.com/) in `html` format. Evernicious will take these bookmarks and generate a file that can be imported into Evernote using the official [Evernote client for Mac or Windows](http://www.evernote.com/about/intl/es/download/).

For each del.icio.us bookmark, it will generate an Evernote note. It will preserve tags and comments from del.icio.us bookmarks. Tags will be loaded into Evernote when the generated file is imported.

## Installation

	gem install evernicious
  
## Usage

	evernicious delicious-bookmarks-file.htm
  
It will generate a file `delicious-bookmarks-file.htm.enex` that can be imported into evernote.

## How to import your del.icio.us bookmarks file into Evernote

1. Export your del.icio.us bookmars using the [export bookmarks page](https://secure.delicious.com/settings/bookmarks/export) at the settings section of your [del.icio.us](http://www.delicious.com/) account. You will obtain a file with named something like `delicious-20110102.htm`.
2. Execute evernicious on the downloaded file. For example: `evernicious delicious-20110102.htm`. It will generate `delicious-20110102.htm.enex`
3. In the Evernote desktop client, go to `File\Import notes from archive` and select the generated `.enex` file.




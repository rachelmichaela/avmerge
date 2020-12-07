# `avmerge` 
A simple Perl script that merges matching subsequent audio and video 
files into a single file with `ffmpeg`.

Document last updated 6th December, 2020 (20 Kislev 5781);

### Table of Contents
- [About `avmerge`](#about-avmerge)
- [How to use `avmerge`](#how-to-use-avmerge)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgements](#acknowledgements)

### About `avmerge`

`avmerge` is a simple Perl script that merges matching subsequent audio
and video files into a single file with `ffmpeg`.

It works by looking for files that use the file extension provided as 
the argument `import_file_extension` in the working directory. Once it
has found a file with the file extension, it then looks for another file
with the same file extension. Once it finds two files, it merges them
together with `ffmpeg`.

This script should only be used for merging files in directories that
contain an even number of files (i.e. only matching pairs of files). The
script currently does not compare the names of the files, so it will not 
work if the files are not in the same order, and it may incorrectly
merge mismatching files if there is an odd number of files with the
relevant file extension within the working directory.

Please note that this script does not remove any files after the merging
process is complete. You must remove the original files manually if you
wish to do so.

### How to use `avmerge`

Before you can use `avmerge`, you must install 
[FFmpeg](https://ffmpeg.org/download.html) globally.

To use `avmerge` in a single directory without installing it, the 
following steps are required.
1. Download the `avmerge.pl` file from this repository;
2. Move the `avmerge.pl` file into the directory;
3. Run the script via `./avmerge.pl` with two arguments:
	- the first argument, `import_file_extension`, should be the file
	extension of both of the files that you wish to merge.
	- the second argument, `export_file_extension`, should be the file
	extension of the resulting combined file.

Full example:
```
perl avmerge.pl webm mkv
```

To use `avmerge` globally, the following steps are required.
1. Download `avmerge.pl` and rename it to `avmerge`;
2. Move `avmerge` to your user binary directory (e.g. `/usr/local/bin`);
3. Add your user binary directory to PATH if it is not already present;
4. Make the file executable;
5. Run the script via `avmerge` with two arguments:
	- the first argument, `import_file_extension`, should be the file
	extension of both of the files that you wish to merge.
	- the second argument, `export_file_extension`, should be the file
	extension of the resulting combined file.

Full example:
```
avmerge webm mkv
```

### Contributing

Contributions can be made in the form of pull requests, or via bug 
reports and suggestions in the repository issues.

All contributors must assign the copyright of their contribution to the 
author of the project. This is to avoid the 
myraid of issues caused by having multiple intellectual property holders
in a single project.

### License

Copyright &copy; 2020 Rachel Michaela Bradley.

`avmerge` is released in its entirety under the BSD 2-Clause License. 
The full text of this license is available in the COPYING file.

### Acknowledgements

- Thanks to the FFmpeg project team for their useful programmes.
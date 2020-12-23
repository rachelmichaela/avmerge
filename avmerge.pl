#!/usr/bin/env perl
=begin comment
Copyright (c) 2020, Rachel Michaela Bradley
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
=end comment
=cut

use warnings;
use strict;
use Getopt::Std;
use Cwd;

package Avmerge;

my %options;
Getopt::Std::getopts('ry', \%options);

my $num_args = $#ARGV + 1;
if ($num_args != 2 && $num_args != 3) {
	printf "Usage: avmerge [-ry] import_file_extension [second_import_file_extension] export_file_extension\n";
	printf "Example: avmerge webm mkv\n";
	printf "See avmerge(8) for more details.\n";
	exit;
}

if ($num_args == 2) {
	our $VIMPORTEXT = $ARGV[0];
	our $AIMPORTEXT = $VIMPORTEXT;
	our $EXPORTEXT = $ARGV[1];
} else {
	our $VIMPORTEXT = $ARGV[0];
	our $AIMPORTEXT = $ARGV[1];
	our $EXPORTEXT = $ARGV[2];
}

if ($options{y}) {
	our $FFMPEG = 'ffmpeg -i \"${files[$i]}\" -i \"${files[$i + 1]}\" \"${export}.$Avmerge::EXPORTEXT\" -y';
} else {
	our $FFMPEG = 'ffmpeg -i \"${files[$i]}\" -i \"${files[$i + 1]}\" \"${export}.$Avmerge::EXPORTEXT\"';
}

my @dirs;

if ($options{r}) {
	recursive(Cwd::getcwd());
	merge();
} else {
	push @dirs, Cwd::getcwd();
	merge();
}

sub recursive {
	my ($currdir) = @_;
	if (-d $currdir) {
		opendir my $handle, $currdir or warn "Could not open ${currdir}.\n";
		while (my $subdir = readdir $handle) {
			next if ($subdir eq q{.} || $subdir eq q{..});
			push @dirs, $currdir;
			recursive("$currdir/$subdir");
		}
		close $handle or die "Could not close ${handle}.\n";
	}
	return;
}

sub merge {
	foreach my $dir (@dirs) {
		printf "Using directory: ${dir}\n";
		chdir $dir or warn "Could not change to ${dir}.\n";
		my @files = glob q{*};
		for (my $i = 0;$i < @files;$i++) {
			if ($files[$i] =~ m/$Avmerge::VIMPORTEXT/msx) {
				printf "Found: %s\n", $files[$i];
				if ($files[$i + 1] =~ m/$Avmerge::AIMPORTEXT/msx) {
					printf "Matched: %s\n", $files[$i + 1];
					my $export = $files[$i];
					$export =~ s/[.].*//msx;
					printf "Executing: ffmpeg -i ${files[$i]} -i ${files[$i + 1]} ${export}.$Avmerge::EXPORTEXT\n";
					system "$Avmerge::FFMPEG";
					$i++;
				} else {
					printf "No files found.\n";
					last;
				}
			}
		}
	}
	return;
}
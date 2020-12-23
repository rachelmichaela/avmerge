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
use Config;
use File::Copy 'copy';

my $srcfile = 'avmerge.pl';
my $bindir = '/usr/local/bin';
my $binfile = 'avmerge';
my $mandir = '/usr/local/share/man/man8';
my $manfile = 'avmerge.8';
my $osstr = $Config{osname};

if ($osstr =~ m/darwin/ || $osstr =~ m/bsd/ || $osstr =~ m/linux/) {
	if (not -d $mandir) {
		mkdir $mandir or die "Could not create directory ${mandir}\n";
	}
	copy "${srcfile}", "${bindir}/${binfile}" or die "Could not copy ${srcfile} to ${bindir}\n";
	copy "${manfile}", "${mandir}/${manfile}" or die "Could not copy ${manfile} to ${mandir}\n";
	chmod 0555, "${bindir}/${binfile}" or die "Could not set ${bindir}/${binfile} as executable.\n";
} else {
	printf "Your platform is not supported by this install script. Please install ${binfile} manually.\n";
}
